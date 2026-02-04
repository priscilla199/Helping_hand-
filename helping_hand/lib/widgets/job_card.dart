import 'package:flutter/material.dart';
import '../models/job_model.dart';
import '../utils/constants.dart';

class JobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback? onTap;
  final VoidCallback? onApply;
  final bool showApplyButton;

  const JobCard({
    Key? key,
    required this.job,
    this.onTap,
    this.onApply,
    this.showApplyButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingM),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and pay
              Row(
                children: [
                  Expanded(
                    child: Text(
                      job.title,
                      style: AppConstants.subheadingStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingM),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spacingM,
                      vertical: AppConstants.spacingS,
                    ),
                    decoration: BoxDecoration(
                      color: AppConstants.primaryColor,
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                    ),
                    child: Text(
                      '\$${job.pay.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppConstants.textWhiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppConstants.spacingM),

              // Description
              Text(
                job.description,
                style: AppConstants.bodyStyle.copyWith(
                  color: AppConstants.textSecondaryColor,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: AppConstants.spacingM),

              // Job details row
              Row(
                children: [
                  _buildDetailItem(
                    Icons.category_outlined,
                    job.category.toString().split('.').last,
                  ),
                  const SizedBox(width: AppConstants.spacingL),
                  _buildDetailItem(
                    Icons.access_time,
                    '${job.estimatedHours}h',
                  ),
                  const SizedBox(width: AppConstants.spacingL),
                  _buildDetailItem(
                    Icons.location_on_outlined,
                    job.location,
                  ),
                ],
              ),

              const SizedBox(height: AppConstants.spacingM),

              // Employer info and status
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: AppConstants.primaryLightColor,
                    child: Text(
                      job.employerName.isNotEmpty
                          ? job.employerName[0].toUpperCase()
                          : 'E',
                      style: TextStyle(
                        color: AppConstants.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingS),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.employerName,
                          style: AppConstants.bodyStyle.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Posted ${_formatDate(job.createdAt)}',
                          style: AppConstants.captionStyle,
                        ),
                      ],
                    ),
                  ),
                  if (showApplyButton && job.isAvailable)
                    ElevatedButton(
                      onPressed: onApply,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.secondaryColor,
                        foregroundColor: AppConstants.textWhiteColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.spacingL,
                          vertical: AppConstants.spacingS,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                        ),
                      ),
                      child: const Text(
                        'Apply',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                ],
              ),

              // Status indicator
              if (job.isUrgent)
                Container(
                  margin: const EdgeInsets.only(top: AppConstants.spacingM),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacingM,
                    vertical: AppConstants.spacingS,
                  ),
                  decoration: BoxDecoration(
                    color: AppConstants.warningColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                    border: Border.all(
                      color: AppConstants.warningColor.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.priority_high,
                        color: AppConstants.warningColor,
                        size: 16,
                      ),
                      const SizedBox(width: AppConstants.spacingS),
                      Text(
                        'Urgent',
                        style: TextStyle(
                          color: AppConstants.warningColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: AppConstants.textSecondaryColor,
        ),
        const SizedBox(width: AppConstants.spacingXS),
        Text(
          text,
          style: AppConstants.captionStyle.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

// Compact version for lists
class CompactJobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback? onTap;

  const CompactJobCard({
    Key? key,
    required this.job,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingS),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingM),
          child: Row(
            children: [
              // Job icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppConstants.primaryLightColor,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                ),
                child: Icon(
                  _getCategoryIcon(job.category),
                  color: AppConstants.primaryColor,
                  size: 24,
                ),
              ),

              const SizedBox(width: AppConstants.spacingM),

              // Job details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: AppConstants.bodyStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppConstants.spacingXS),
                    Text(
                      job.location,
                      style: AppConstants.captionStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Pay amount
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${job.pay.toStringAsFixed(2)}',
                    style: AppConstants.bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppConstants.primaryColor,
                    ),
                  ),
                  Text(
                    '${job.estimatedHours}h',
                    style: AppConstants.captionStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(JobCategory category) {
    switch (category) {
      case JobCategory.cleaning:
        return Icons.cleaning_services;
      case JobCategory.gardening:
        return Icons.eco;
      case JobCategory.delivery:
        return Icons.delivery_dining;
      case JobCategory.handyman:
        return Icons.build;
      case JobCategory.other:
        return Icons.work;
    }
  }
} 