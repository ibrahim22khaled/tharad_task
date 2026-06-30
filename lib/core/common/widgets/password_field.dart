import 'package:flutter/material.dart';
import 'package:tharad_task/core/common/widgets/app_text_form_field.dart';
import 'package:tharad_task/core/values/app_colors.dart';
import 'package:tharad_task/core/values/app_text_style.dart';

class PasswordTextForm extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final bool? isOptional;
  final String? Function(String?)? validate;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final EdgeInsetsGeometry margin;

  const PasswordTextForm({
    super.key,
    required this.passwordController,
    this.labelText,
    this.validate,
    this.isOptional,
    this.hintText,
    this.hintTextStyle,
    this.labelTextStyle,
    this.margin = const EdgeInsets.only(bottom: 16),
  });

  final TextEditingController passwordController;

  @override
  State<PasswordTextForm> createState() => _PasswordTextFormState();
}

class _PasswordTextFormState extends State<PasswordTextForm> {
  bool _isObscure = true;
  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      //  prefixIcon: (_) => AppSvgIcon(
      //    path: AppIcons.global,
      //  ),
      margin: widget.margin,
      obscureText: _isObscure,
      validate: widget.validate ,
      label: widget.labelText,
      labelTextStyle: AppTextStyles.regular12.copyWith(
        color: AppColors.hintTextColor,
      ),
      hintText: widget.hintText,
      hintTextStyle: AppTextStyles.regular14.copyWith(
        color: AppColors.hintTextColor,
      ),
      suffixIcon: UnconstrainedBox(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _togglePasswordVisibility,
          child: Icon(
            _isObscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 18,
            weight: 50,
            opticalSize: 20,
            grade: -20,
            color: !_isObscure ? AppColors.primary : AppColors.primary,
          ),
        ),
      ),

      controller: widget.passwordController,
      isOptional: widget.isOptional ?? true,
      inputType: TextInputType.visiblePassword,
    );
  }
}
