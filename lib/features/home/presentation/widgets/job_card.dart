import 'package:flutter/material.dart';
import 'package:koala/core/constants.dart';
import 'package:koala/features/home/data/models/job_model.dart';
import 'package:koala/features/home/presentation/widgets/job_detail_bottom_sheet.dart';

class JobCard extends StatelessWidget {
  final JobModel job;
  final double? distance;

  const JobCard({super.key, required this.job, this.distance});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: job.category.color,
          child: Icon(job.category.icon, color: Colors.white, size: 24),
        ),
        title: Text(
          job.title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              job.subtitle,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: Colors.grey,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (distance != null) const SizedBox(height: 4),
            if (distance != null)
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 14,
                    color: ThemeConstants.primaryColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${distance!.toStringAsFixed(1)} km',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: ThemeConstants.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
          ],
        ),
        trailing: Column(
          children: [
            Text(
              '₺${job.price.toStringAsFixed(0)}',
              style: const TextStyle(
                color: ThemeConstants.primaryColor,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        onTap: () => JobDetailBottomSheet.show(context, job),
      ),
    );
  }
}
