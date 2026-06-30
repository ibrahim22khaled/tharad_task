import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad_task/core/common/widgets/app_button.dart';
import 'package:tharad_task/core/common/widgets/app_toast.dart';
import 'package:tharad_task/core/values/app_colors.dart';
import 'package:tharad_task/core/values/app_text_style.dart';
import 'package:tharad_task/features/auth/presentation/cubits/otp/otp_cubit.dart';
import 'package:tharad_task/features/auth/presentation/cubits/otp/otp_state.dart';
import 'package:tharad_task/features/auth/presentation/widgets/otp_pin_fields_widget.dart';
import 'package:tharad_task/gen/assets.gen.dart';
import 'package:tharad_task/l10n/app_localizations.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  bool _hasError = false;

  static const _timerDuration = 60;
  int _remainingSeconds = _timerDuration;
  Timer? _timer;
  bool get _canResend => _remainingSeconds == 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _remainingSeconds = _timerDuration;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  String get _timerText {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds Sec';
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state.isSuccess) context.go('/login');
        if (state.isFailure) {
          setState(() => _hasError = true);
          AppToasts.error(
            context,
            message: state.errorMessage ?? 'Error occurred',
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackgroundColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(80.h),
                Image.asset(
                  Assets.images.logo.path,
                  width: 178.w,
                  height: 58.h,
                ),
                const Spacer(),
                Text(tr.verificationCode, style: AppTextStyles.bold20),
                Gap(8.h),
                Text(
                  tr.otpMsg,
                  style: AppTextStyles.medium12.copyWith(
                    color: AppColors.gray300,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(32.h),
                OtpPinCodeWidget(
                  controller: _otpController,
                  hasError: _hasError,
                  errorMessage: _hasError ? tr.otpError : null,
                  onChanged: (_) {
                    if (_hasError) setState(() => _hasError = false);
                  },
                  onCompleted: (_) => _onVerify(context, state),
                ),
                Gap(12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          tr.didntReceiveCode,
                          style: AppTextStyles.medium10.copyWith(
                            color: AppColors.textColor,
                          ),
                        ),
                        Gap(4.w),
                        GestureDetector(
                          onTap: _canResend ? _onResend : null,
                          child: Text(
                            tr.resend,
                            style: AppTextStyles.medium10.copyWith(
                              color: _canResend
                                  ? AppColors.authtextColor
                                  : AppColors.textColor,
                              decoration: _canResend
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                              decorationColor: AppColors.authtextColor,
                              decorationThickness: 10.0
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      _timerText,
                      style: AppTextStyles.medium10.copyWith(
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                AppButton(
                  isLoading: state.isLoading,
                  text: tr.next,
                  textStyle: AppTextStyles.bold12.copyWith(color: AppColors.white),
                  onPressed: state.isLoading
                      ? null
                      : () => _onVerify(context, state),
                ),
                Gap(50.h),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onVerify(BuildContext context, OtpState state) {
    if (_otpController.text.length < 4) {
      setState(() => _hasError = true);
      return;
    }
    context.read<OtpCubit>().verifyOtp(
      email: widget.email,
      otp: _otpController.text,
    );
  }

  void _onResend() {
    _otpController.clear();
    setState(() => _hasError = false);
    _startTimer();
  }
}
