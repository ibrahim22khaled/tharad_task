import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad_task/core/common/widgets/app_button.dart';
import 'package:tharad_task/core/common/widgets/app_text_form_field.dart';
import 'package:tharad_task/core/common/widgets/app_toast.dart';
import 'package:tharad_task/core/common/widgets/password_field.dart';
import 'package:tharad_task/core/utils/complete_check_notifier.dart';
import 'package:tharad_task/core/utils/validator.dart';
import 'package:tharad_task/core/values/app_colors.dart';
import 'package:tharad_task/core/values/app_text_style.dart';
import 'package:tharad_task/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:tharad_task/features/auth/presentation/cubits/register/register_state.dart';
import 'package:tharad_task/core/common/widgets/image_picker_widget.dart';
import 'package:tharad_task/gen/assets.gen.dart';
import 'package:tharad_task/l10n/app_localizations.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late final CompleteCheckerNotifier _checkerNotifier;
  String? _imagePath;
  String? _imageError;

  @override
  void initState() {
    super.initState();
    _checkerNotifier = CompleteCheckerNotifier(_isButtonEnabled);
    _usernameController.addListener(_recheck);
    _emailController.addListener(_recheck);
    _passwordController.addListener(_recheck);
    _confirmPasswordController.addListener(_recheck);
  }

  bool _isButtonEnabled() =>
      _imagePath != null &&
      _usernameController.text.trim().isNotEmpty &&
      _emailController.text.trim().isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty;

  void _recheck() => _checkerNotifier.recheck();

  @override
  void dispose() {
    _usernameController.removeListener(_recheck);
    _emailController.removeListener(_recheck);
    _passwordController.removeListener(_recheck);
    _confirmPasswordController.removeListener(_recheck);
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _checkerNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.isSuccess) {
          final email = context.read<RegisterCubit>().registeredEmail!;
          context.push('/otp', extra: email);
        }
        if (state.isFailure) {
          AppToasts.error(
            context,
            message: state.errorMessage ?? 'Error occurred',
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackgroundColor,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(60.h),
                  Center(
                    child: Image.asset(
                      Assets.images.logo.path,
                      width: 178.w,
                      height: 58.h,
                    ),
                  ),
                  Gap(32.h),
                  Center(
                    child: Text(tr.createAccount, style: AppTextStyles.bold20),
                  ),
                  Gap(24.h),

                  Text(
                    tr.profilePic,
                    style: AppTextStyles.medium10.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),

                  Gap(6.h),
                  ImagePickerWidget(
                    onImageSelected: (path) {
                      setState(() {
                        _imagePath = path;
                        _imageError = null;
                      });
                      _recheck();
                    },
                    onError: (error) => setState(() => _imageError = error),
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
                  Gap(12.h),

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
                  Gap(12.h),

                  Text(
                    tr.password,
                    style: AppTextStyles.medium10.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),

                  Gap(6.h),
                  PasswordTextForm(
                    passwordController: _passwordController,
                    validate: (v) => Validator(v, tr).password,
                  ),
                  Gap(12.h),

                  Text(
                    tr.passwordConfirmation,
                    style: AppTextStyles.medium10.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),

                  Gap(6.h),
                  PasswordTextForm(
                    passwordController: _confirmPasswordController,
                    validate: (v) => Validator(
                      v,
                      tr,
                    ).confirmPasswordValidator(_passwordController.text),
                  ),
                  Gap(40.h),
                  ValueListenableBuilder<bool>(
                    valueListenable: _checkerNotifier,
                    builder: (context, isEnabled, _) {
                      return AppButton(
                        isEnabled: isEnabled,
                        isLoading: state.isLoading,
                        text: tr.createAccount,
                        textStyle: AppTextStyles.bold12.copyWith(
                          color: AppColors.white,
                        ),
                        onPressed: _onRegister,
                      );
                    },
                  ),
                  Gap(12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tr.haveAccount,
                        style: AppTextStyles.medium12.copyWith(
                          color: AppColors.textColor,
                        ),
                      ),
                      Gap(4.w),
                      GestureDetector(
                        onTap: () => context.go('/login'),
                        child: Text(
                          tr.login,
                          style: AppTextStyles.medium12.copyWith(
                            color: AppColors.authtextColor,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.authtextColor,
                            decorationThickness: 10.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(50.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onRegister() {
    final tr = AppLocalizations.of(context)!;
    if (_imagePath == null) {
      setState(() => _imageError = tr.imageReguired);
      return;
    }
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<RegisterCubit>().register(
      email: _emailController.text.trim(),
      username: _usernameController.text.trim(),
      password: _passwordController.text,
      passwordConfirmation: _confirmPasswordController.text,
      imagePath: _imagePath!,
    );
  }
}
