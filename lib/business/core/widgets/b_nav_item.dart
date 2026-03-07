import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/product/constants/app_colors.dart';

class BNavItem extends StatefulWidget {
  final int index;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final String? label;
  final bool? centerItem;

  const BNavItem({
    super.key,
    required this.index,
    required this.isSelected,
    required this.onTap,

    this.label,
    this.centerItem,
    required this.icon,
  });

  @override
  State<BNavItem> createState() => _BNavItemState();
}

class _BNavItemState extends State<BNavItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryColor,
      borderRadius: widget.centerItem == true
          ? BorderRadius.circular(200)
          : BorderRadius.circular(25),
      child: InkWell(
        borderRadius: widget.centerItem == true
            ? BorderRadius.circular(200)
            : BorderRadius.circular(25),
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: widget.centerItem == true
                ? Colors.white
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(widget.centerItem == true ? 14 : 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HugeIcon(
                  icon: widget.icon,
                  size: 26,
                  color: widget.isSelected
                      ? Colors.white
                      : (widget.centerItem == true
                            ? AppColors.primaryColor
                            : Colors.grey[300]!),
                ),
                if (widget.centerItem != true && widget.label != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      widget.label!,
                      style: TextStyle(
                        color: widget.isSelected
                            ? Colors.white
                            : Colors.grey[300],
                        fontSize: 9,
                        fontFamily: 'Poppins',
                        fontWeight: widget.isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
