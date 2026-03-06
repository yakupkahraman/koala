import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/product/constants/app_colors.dart';

class BNavItem extends StatefulWidget {
  final int index;
  final IconData unSelectedIcon;
  final IconData selectedIcon;
  final bool isSelected;
  final VoidCallback onTap;
  final String? label;
  final bool? centerItem;

  const BNavItem({
    super.key,
    required this.index,
    required this.isSelected,
    required this.onTap,
    required this.unSelectedIcon,
    required this.selectedIcon,
    this.label,
    this.centerItem,
  });

  @override
  State<BNavItem> createState() => _BNavItemState();
}

class _BNavItemState extends State<BNavItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: widget.centerItem == true ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: EdgeInsets.all(widget.centerItem == true ? 14 : 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HugeIcon(
                icon: widget.isSelected
                    ? widget.selectedIcon
                    : widget.unSelectedIcon,
                size: 26,
                color: widget.isSelected
                    ? Colors.white
                    : (widget.centerItem == true
                          ? AppColors.primaryColor
                          : Colors.white),
              ),
              if (widget.centerItem != true && widget.label != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    widget.label!,
                    style: TextStyle(
                      color: widget.isSelected ? Colors.white : Colors.white,
                      fontSize: 9,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
