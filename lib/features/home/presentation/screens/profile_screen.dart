import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad_task/core/common/widgets/app_button.dart';
import 'package:tharad_task/core/common/widgets/app_text_form_field.dart';
import 'package:tharad_task/core/common/widgets/app_toast.dart';
import 'package:tharad_task/core/common/widgets/password_field.dart';
import 'package:tharad_task/core/localization/language_change_widget.dart';
import 'package:tharad_task/core/session/cubit/app_session_cubit.dart';
import 'package:tharad_task/core/utils/complete_check_notifier.dart';
import 'package:tharad_task/core/utils/validator.dart';
import 'package:tharad_task/core/values/app_colors.dart';
import 'package:tharad_task/core/values/app_text_style.dart';
import 'package:tharad_task/core/common/widgets/image_picker_widget.dart';
import 'package:tharad_task/features/home/presentation/cubits/get_profile/get_profile_cubit.dart';
import 'package:tharad_task/features/home/presentation/cubits/get_profile/get_profile_state.dart';
import 'package:tharad_task/features/home/presentation/cubits/update_profile/update_profile_cubit.dart';
import 'package:tharad_task/features/home/presentation/cubits/update_profile/update_profile_state.dart';
import 'package:tharad_task/features/home/presentation/widgets/home_header.dart';
import 'package:tharad_task/features/home/presentation/widgets/profile_loading_widget.dart';
import 'package:tharad_task/l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late final CompleteCheckerNotifier _checkerNotifier;

  String? _imagePath;
  String? _networkImage;
  String? _imageError;

  @override
  void initState() {
    super.initState();
    _checkerNotifier = CompleteCheckerNotifier(_isButtonEnabled);
    _usernameController.addListener(_recheck);
    _emailController.addListener(_recheck);
    _oldPasswordController.addListener(_recheck);
    _newPasswordController.addListener(_recheck);
    _confirmPasswordController.addListener(_recheck);
  }

  bool _isButtonEnabled() =>
      _usernameController.text.trim().isNotEmpty &&
      _emailController.text.trim().isNotEmpty &&
      _oldPasswordController.text.isNotEmpty &&
      _newPasswordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty &&
      (_imagePath != null || _networkImage != null);

  void _recheck() => _checkerNotifier.recheck();

  @override
  void dispose() {
    _usernameController.removeListener(_recheck);
    _emailController.removeListener(_recheck);
    _oldPasswordController.removeListener(_recheck);
    _newPasswordController.removeListener(_recheck);
    _confirmPasswordController.removeListener(_recheck);
    _usernameController.dispose();
    _emailController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _checkerNotifier.dispose();
    super.dispose();
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;

    context.read<UpdateProfileCubit>().updateProfile(
      username: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      password: _oldPasswordController.text.isNotEmpty
          ? _oldPasswordController.text
          : null,
      newPassword: _newPasswordController.text.isNotEmpty
          ? _newPasswordController.text
          : null,
      newPasswordConfirmation: _confirmPasswordController.text.isNotEmpty
          ? _confirmPasswordController.text
          : null,
      imagePath: _imagePath,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [AppColors.primary, AppColors.secondary],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(title: tr.myProfile, titleAlign: Alignment.center),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(27),
                      topRight: Radius.circular(27),
                    ),
                  ),
                  child: BlocConsumer<GetProfileCubit, GetProfileState>(
                    listener: (context, state) {
                      if (state.isSuccess && state.data != null) {
                        _usernameController.text = state.data!.username ?? '';
                        _emailController.text = state.data!.email ?? '';
                        _networkImage = state.data!.image;
                        setState(() {});
                      }
                      if (state.isFailure) {
                        AppToasts.error(
                          context,
                          message: state.errorMessage ?? '',
                        );
                      }
                    },
                    builder: (context, getState) {
                      if (getState.isLoading) {
                        return const Center(child: ProfileLoadingWidget());
                      }

                      return SingleChildScrollView(
                        padding: EdgeInsets.only(
                          top: 32.h,
                          right: 20.w,
                          left: 20.w,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LanguageChangeWidget(),
                              Gap(8.h),
                              Text(
                                tr.userName,
                                style: AppTextStyles.medium10.copyWith(
                                  color: AppColors.textColor,
                                ),
                              ),
                              Gap(6.h),
                              AppTextFormField(
                                controller: _usernameController,
                                validate: (v) => Validator(v, tr).name,
                              ),
                              Text(
                                tr.email,
                                style: AppTextStyles.medium10.copyWith(
                                  color: AppColors.textColor,
                                ),
                              ),
                              Gap(6.h),
                              AppTextFormField(
                                controller: _emailController,
                                validate: (v) => Validator(v, tr).email(),
                              ),
                              Text(
                                tr.profilePic,
                                style: AppTextStyles.medium10.copyWith(
                                  color: AppColors.textColor,
                                ),
                              ),
                              Gap(6.h),
                              ImagePickerWidget(
                                initialImageUrl: _networkImage,
                                onImageSelected: (path) {
                                  setState(() {
                                    _imagePath = path;
                                    _imageError = null;
                                  });
                                  _recheck();
                                },
                                onError: (error) =>
                                    setState(() => _imageError = error),
                              ),
                              if (_imageError != null) ...[
                                Gap(4.h),
                                Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Text(
                                    _imageError!,
                                    style: AppTextStyles.medium10.copyWith(
                                      color: AppColors.redError,
                                    ),
                                  ),
                                ),
                              ],
                              Gap(12.h),
                              Text(
                                tr.oldPassword,
                                style: AppTextStyles.medium10.copyWith(
                                  color: AppColors.textColor,
                                ),
                              ),
                              Gap(6.h),
                              PasswordTextForm(
                                passwordController: _oldPasswordController,
                              ),
                              Text(
                                tr.newPassword,
                                style: AppTextStyles.medium10.copyWith(
                                  color: AppColors.textColor,
                                ),
                              ),
                              Gap(6.h),
                              PasswordTextForm(
                                passwordController: _newPasswordController,
                                validate: (v) {
                                  if (_newPasswordController.text.isEmpty) {
                                    return null;
                                  }
                                  return Validator(v, tr).password;
                                },
                              ),
                              Text(
                                tr.passwordConfirmation,
                                style: AppTextStyles.medium10.copyWith(
                                  color: AppColors.textColor,
                                ),
                              ),
                              Gap(6.h),
                              PasswordTextForm(
                                passwordController: _confirmPasswordController,
                                validate: (v) {
                                  if (_newPasswordController.text.isEmpty) {
                                    return null;
                                  }
                                  return Validator(
                                    v,
                                    tr,
                                  ).confirmPasswordValidator(
                                    _newPasswordController.text,
                                  );
                                },
                              ),
                              Gap(29.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 58.w),
                                child:
                                    BlocConsumer<
                                      UpdateProfileCubit,
                                      UpdateProfileState
                                    >(
                                      listener: (context, updateState) async {
                                        if (updateState.isSuccess) {
                                          final passwordWasChanged =
                                              _newPasswordController
                                                  .text
                                                  .isNotEmpty;

                                          if (passwordWasChanged) {
                                            AppToasts.success(
                                              context,
                                              message:
                                                  tr.changesSavedSuccessfully,
                                            );
                                            await context
                                                .read<AppSessionCubit>()
                                                .logout();
                                            if (context.mounted) {
                                              context.go('/splash');
                                            }
                                          } else {
                                            AppToasts.success(
                                              context,
                                              message:
                                                  tr.changesSavedSuccessfully,
                                            );
                                          }
                                        }
                                        if (updateState.isFailure) {
                                          AppToasts.error(
                                            // ignore: use_build_context_synchronously
                                            context,
                                            message:
                                                updateState.errorMessage ??
                                                tr.changesSavedFailure,
                                          );
                                        }
                                      },
                                      builder: (context, updateState) {
                                        return ValueListenableBuilder<bool>(
                                          valueListenable: _checkerNotifier,
                                          builder: (context, isEnabled, _) {
                                            return AppButton(
                                              isEnabled: isEnabled,
                                              isLoading: updateState.isLoading,
                                              text: tr.saveChanges,
                                              onPressed: _onSave,
                                            );
                                          },
                                        );
                                      },
                                    ),
                              ),
                              Gap(27.h),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
