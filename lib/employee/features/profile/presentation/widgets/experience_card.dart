import 'package:flutter/material.dart';
import 'package:koala/product/constants/app_colors.dart';

class ExperienceCard extends StatelessWidget {
  final String title;
  final String company;
  final String duration;
  final String description;
  final bool isLast;

  const ExperienceCard({
    super.key,
    required this.title,
    required this.company,
    required this.duration,
    required this.description,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _timelineIndicator(),
          SizedBox(width: 16),
          Expanded(child: _cardContent()),
        ],
      ),
    );
  }

  Widget _timelineIndicator() {
    return SizedBox(
      width: 24,
      child: Column(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor,
              border: Border.all(color: AppColors.primaryColor, width: 2),
            ),
          ),
          if (!isLast)
            Expanded(
              child: Container(
                width: 2,
                color: AppColors.primaryColor.withValues(alpha: 0.3),
              ),
            ),
        ],
      ),
    );
  }

  Widget _cardContent() {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.business, size: 16, color: AppColors.primaryColor),
              SizedBox(width: 6),
              Text(
                company,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: Colors.grey),
              SizedBox(width: 6),
              Text(
                duration,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
