import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tharad_task/core/common/widgets/app_button.dart';
import 'package:tharad_task/core/localization/cubit/locale_cubit.dart';
import 'package:tharad_task/core/values/app_colors.dart';
import 'package:tharad_task/core/values/app_text_style.dart';
import 'package:tharad_task/l10n/app_localizations.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  static void show(BuildContext context) {
    final cubit = context.read<LocaleCubit>();
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const LanguageBottomSheet(),
      ),
    );
  }

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  late String _selectedCode;

  @override
  void initState() {
    super.initState();
    _selectedCode = context.read<LocaleCubit>().state.locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(tr.language, style: AppTextStyles.bold20),
          Gap(24.h),
          _LanguageOption(
            label: 'اللغة العربية',
            isSelected: _selectedCode == 'ar',
            onTap: () => setState(() => _selectedCode = 'ar'),
          ),
          Gap(12.h),
          _LanguageOption(
            label: 'English',
            isSelected: _selectedCode == 'en',
            onTap: () => setState(() => _selectedCode = 'en'),
          ),
          Gap(24.h),
          AppButton(
            text: tr.apply,
            textStyle: AppTextStyles.bold12.copyWith(color: AppColors.white),
            onPressed: () {
              context.read<LocaleCubit>().changeLocale(_selectedCode);
              Navigator.pop(context);
            },
          ),
          Gap(16.h),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(label, style: AppTextStyles.medium14),
            Gap(12.w),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : AppColors.hintTextColor,
            ),
          ],
        ),
      ),
    );
  }
}