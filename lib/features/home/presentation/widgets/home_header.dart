import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tharad_task/core/values/app_colors.dart';
import 'package:tharad_task/core/values/app_text_style.dart';
import 'package:tharad_task/gen/assets.gen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.title, required this.titleAlign});
  final String title;
  final AlignmentGeometry titleAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Stack(
            alignment: titleAlign,
            children: [
              Text(
                title,
                style: AppTextStyles.bold16.copyWith(color: AppColors.white),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(Assets.icons.notification),
              ),
            ],
          ),
        ),
        Gap(28.5.h),
      ],
    );
  }
}
