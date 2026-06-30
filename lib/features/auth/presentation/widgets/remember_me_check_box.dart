import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tharad_task/core/values/app_colors.dart';
import 'package:tharad_task/core/values/app_text_style.dart';
import 'package:tharad_task/l10n/app_localizations.dart';

class RememberMeCheckBox extends StatefulWidget {
  const RememberMeCheckBox({super.key});

  @override
  State<RememberMeCheckBox> createState() => _RememberMeCheckBoxState();
}

class _RememberMeCheckBoxState extends State<RememberMeCheckBox> {
  bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Row(
      children: [
        SizedBox(
          width: 16,
          height: 16,
          child: Checkbox(
            checkColor: AppColors.primary,
            hoverColor: AppColors.white,
            value: _rememberMe,
            onChanged: (v) => setState(() => _rememberMe = v!),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            // white background for the checkbox
            fillColor: WidgetStateProperty.all(AppColors.white),
            // border color for the checkbox
            side: WidgetStateBorderSide.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return BorderSide(color: AppColors.primary, width: 1.5);
              }
              return BorderSide(color: AppColors.textColor, width: 1.5);
            }),
          ),
        ),
        Gap(4.w),
        Text(
          tr.rememberMe,
          style: AppTextStyles.regular10.copyWith(color: AppColors.textColor),
        ),
      ],
    );
  }
}
