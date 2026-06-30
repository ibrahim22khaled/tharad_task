import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tharad_task/core/values/app_colors.dart';
import 'package:tharad_task/core/values/app_text_style.dart';
import 'package:tharad_task/gen/assets.gen.dart';
import 'package:tharad_task/l10n/app_localizations.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeTitle(header: tr.aboutInternship),
        Gap(12.h),
        AboutInternBulk(description: tr.aboutInternship1),
        AboutInternBulk(description: tr.aboutInternship2),
        AboutInternBulk(description: tr.aboutInternship3),
        AboutInternBulk(description: tr.aboutInternship4),
        AboutInternBulk(description: tr.aboutInternship5),

        Gap(20.h),
        HomeTitle(header: tr.workNature),
        Gap(16.h),
        HomeBullet(bulletInfo: tr.homeBullet1),
        Gap(9.h),
        HomeBullet(bulletInfo: tr.homeBullet2),
        Gap(9.h),
        HomeBullet(bulletInfo: tr.homeBullet3),
        Gap(9.h),
        HomeBullet(bulletInfo: tr.homeBullet4),
        Gap(9.h),
        HomeBullet(bulletInfo: tr.homeBullet5),
      ],
    );
  }
}

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key, required this.header});
  final String header;

  @override
  Widget build(BuildContext context) {
    return 
        Text(
          header,
          style: AppTextStyles.bold20.copyWith(color: AppColors.textColor),
        );
      
  }
}

class AboutInternBulk extends StatelessWidget {
  const AboutInternBulk({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return 
        Row(
          children: [
            Flexible(
              child: Text(
                description,
                style: AppTextStyles.medium12.copyWith(color: AppColors.subText),
              ),
            ),
          ],
        );
      
    
  }
}

class HomeBullet extends StatelessWidget {
  const HomeBullet({super.key, required this.bulletInfo});
  final String bulletInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(Assets.icons.bullet),
        Gap(8.w),
        Text(
          bulletInfo,
          style: AppTextStyles.medium12.copyWith(color: AppColors.subText),
        ),
      ],
    );
  }
}
