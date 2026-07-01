import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tharad_task/core/localization/cubit/locale_cubit.dart';
import 'package:tharad_task/core/localization/cubit/locale_state.dart';
import 'package:tharad_task/core/localization/language_bottom_sheet.dart';
import 'package:tharad_task/core/values/app_colors.dart';
import 'package:tharad_task/core/values/app_text_style.dart';
import 'package:tharad_task/gen/assets.gen.dart';

class LanguageChangeWidget extends StatelessWidget {
  const LanguageChangeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, localeState) {
            return GestureDetector(
              onTap: () => LanguageBottomSheet.show(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    localeState.locale.languageCode == 'ar' ? 'English' : 'العربية',
                    style: AppTextStyles.medium12.copyWith(color: AppColors.textColor),
                  ),
                  Gap(6.w),
                  SvgPicture.asset(Assets.icons.global),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
