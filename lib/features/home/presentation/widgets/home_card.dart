import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad_task/core/values/app_colors.dart';
import 'package:tharad_task/core/values/app_text_style.dart';
import 'package:tharad_task/gen/assets.gen.dart';
import 'package:tharad_task/l10n/app_localizations.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(Assets.images.home.path, width: 350.w, height: 110.h),
        Positioned(
          bottom: 30.h,
          child: Text(
            tr.homeImage,
            style: AppTextStyles.bold16.copyWith(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
