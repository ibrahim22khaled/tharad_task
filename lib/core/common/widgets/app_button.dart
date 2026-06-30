import 'package:flutter/material.dart';
import 'package:tharad_task/core/values/app_colors.dart';
import 'package:tharad_task/core/values/app_text_style.dart';

class AppButton extends StatelessWidget {
  final Color? buttonColor;
  final Color? borderColor;
  final double? buttonRadius;
  final double height;
  final String text;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final Color? textColor;
  final bool isLoading;
  final bool isEnabled;
  final bool isExpanded;
  final double? elevation;
  final Widget? leading;
  final Widget? trailing;

  const AppButton({
    super.key,
    this.isLoading = false,
    this.isEnabled = true,
    this.buttonColor,
    this.borderColor,
    this.buttonRadius,
    this.height = 48,
    required this.text,
    this.textStyle,
    this.onPressed,
    this.textColor,
    this.elevation,
    this.isExpanded = true,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (isLoading || !isEnabled) ? null : onPressed,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        backgroundBuilder: (context, states, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: isEnabled ? AppColors.primaryGradient : null,
              color: isEnabled ? null : AppColors.gray250,
              borderRadius: BorderRadius.all(
                Radius.circular(buttonRadius ?? 10),
              ),
            ),
            child: child,
          );
        },
        side: borderColor != null
            ? BorderSide(color: borderColor ?? AppColors.secondary)
            : null,
        padding: EdgeInsets.zero,
        minimumSize: Size(double.infinity, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(buttonRadius ?? 10),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
        children: [
          if (leading != null) ...[
            const SizedBox(width: 5),
            leading!,
            const SizedBox(width: 5),
          ],
          Flexible(
            child: Text(
              text,
              style: textStyle ??
                  AppTextStyles.regular15.copyWith(
                    color: textColor ?? AppColors.white,
                  ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 5),
            isLoading ? _LoadingIndicator(color: textColor) : trailing!,
          ] else ...[
            const SizedBox(width: 5),
            if (isLoading) _LoadingIndicator(color: textColor),
          ],
        ],
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  final Color? color;
  const _LoadingIndicator({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      margin: const EdgeInsetsDirectional.only(start: 12),
      child: CircularProgressIndicator(
        color: color ?? AppColors.white,
        strokeWidth: 3,
      ),
    );
  }
}