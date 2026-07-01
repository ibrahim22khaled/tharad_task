import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tharad_task/core/values/app_colors.dart';

class ProfileLoadingWidget extends StatelessWidget {
  const ProfileLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray300,
      highlightColor: AppColors.appTextFormFieldFillColor,
      period: const Duration(milliseconds: 1200),
      child: Padding(
        padding: EdgeInsets.only(top: 32.h, right: 20.w, left: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 80.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            Gap(20.h),

            _labelPlaceholder(),
            Gap(6.h),
            _fieldPlaceholder(),
            Gap(16.h),

            _labelPlaceholder(),
            Gap(6.h),
            _fieldPlaceholder(),
            Gap(16.h),

            _labelPlaceholder(),
            Gap(6.h),
            Container(
              height: 120.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Gap(16.h),

            _labelPlaceholder(),
            Gap(6.h),
            _fieldPlaceholder(),
            Gap(16.h),

            _labelPlaceholder(),
            Gap(6.h),
            _fieldPlaceholder(),
            Gap(16.h),

            _labelPlaceholder(),
            Gap(6.h),
            _fieldPlaceholder(),
            Gap(29.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 58.w),
              child: Container(
                height: 48.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Gap(27.h),
          ],
        ),
      ),
    );
  }

  Widget _labelPlaceholder() {
    return Container(
      width: 100.w,
      height: 12.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _fieldPlaceholder() {
    return Container(
      height: 48.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}