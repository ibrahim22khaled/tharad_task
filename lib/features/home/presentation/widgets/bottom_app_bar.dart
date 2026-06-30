import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tharad_task/core/values/app_colors.dart';
import 'package:tharad_task/core/values/app_text_style.dart';

class NavBarItem {
  final String activeAssetPath;
  final String inactiveAssetPath;
  final String label;

  const NavBarItem({
    required this.activeAssetPath,
    required this.inactiveAssetPath,
    required this.label,
  });
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavBarItem> items;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.appTextFormFieldFillColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(items.length, (index) {
              final isActive = index == currentIndex;
              final item = items[index];
              return _NavBarTile(
                item: item,
                isActive: isActive,

                onTap: () => onTap(index),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavBarTile extends StatelessWidget {
  final NavBarItem item;
  final bool isActive;

  final VoidCallback onTap;

  const _NavBarTile({
    required this.item,
    required this.isActive,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              isActive ? item.activeAssetPath : item.inactiveAssetPath,
              width: 24,
              height: 24,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: AppTextStyles.regular12.copyWith(
                color: isActive ? AppColors.activeTab : AppColors.nonactiveTab,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
