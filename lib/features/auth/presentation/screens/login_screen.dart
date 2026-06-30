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
import 'package:tharad_task/core/utils/complete_check_notifier.dart';
import 'package:tharad_task/core/values/app_colors.dart';
import 'package:tharad_task/core/values/app_text_style.dart';
import 'package:tharad_task/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:tharad_task/features/auth/presentation/cubits/login/login_state.dart';
import 'package:tharad_task/features/auth/presentation/widgets/remember_me_check_box.dart';
import 'package:tharad_task/gen/assets.gen.dart';
import 'package:tharad_task/l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final CompleteCheckerNotifier _checkerNotifier;

  @override
  void initState() {
    super.initState();
    _checkerNotifier = CompleteCheckerNotifier(_isButtonEnabled);
    _emailController.addListener(_recheck);
    _passwordController.addListener(_recheck);
  }

  bool _isButtonEnabled() =>
      _emailController.text.trim().isNotEmpty &&
      _passwordController.text.isNotEmpty;

  void _recheck() => _checkerNotifier.recheck();

  @override
  void dispose() {
    _emailController.removeListener(_recheck);
    _passwordController.removeListener(_recheck);
    _emailController.dispose();
    _passwordController.dispose();
    _checkerNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          AppToasts.success(context, message: tr.loginSuccessfully);
          context.go('/homeshell');
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
          appBar: AppBar(
            backgroundColor: AppColors.scaffoldBackgroundColor,
            scrolledUnderElevation: 0,
            elevation: 0,
            title: LanguageChangeWidget(),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(100.h),
                  Center(
                    child: Image.asset(
                      Assets.images.logo.path,
                      width: 178.w,
                      height: 58.h,
                    ),
                  ),
                  Gap(100.h),
                  Text(tr.login, style: AppTextStyles.bold20),
                  Gap(24.h),

                  Text(
                    tr.email,
                    style: AppTextStyles.medium10.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),

                  Gap(6.h),
                  AppTextFormField(
                    controller: _emailController,
                    // validate: (v) => Validator(v, tr).email(),
                  ),
                  Gap(12.h),

                  Text(
                    tr.password,
                    style: AppTextStyles.medium10.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),

                  Gap(6.h),
                  PasswordTextForm(passwordController: _passwordController),
                  // Gap(4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RememberMeCheckBox(),
                      Text(
                        tr.didForgetPassword,
                        style: AppTextStyles.medium10.copyWith(
                          color: AppColors.authtextColor,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.authtextColor,
                          decorationThickness: 10.0,
                        ),
                      ),
                    ],
                  ),
                  Gap(40.h),
                  ValueListenableBuilder<bool>(
                    valueListenable: _checkerNotifier,
                    builder: (context, isEnabled, _) {
                      return AppButton(
                        isEnabled: isEnabled,
                        isLoading: state.isLoading,
                        text: tr.login,
                        textStyle: AppTextStyles.bold12.copyWith(
                          color: AppColors.white,
                        ),
                        onPressed: _onLogin,
                      );
                    },
                  ),
                  Gap(12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tr.haventAccount,
                        style: AppTextStyles.medium12.copyWith(
                          color: AppColors.textColor,
                        ),
                      ),
                      Gap(4.w),
                      GestureDetector(
                        onTap: () => context.go('/register'),
                        child: Text(
                          tr.createAccount,
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

  void _onLogin() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<LoginCubit>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }
}
