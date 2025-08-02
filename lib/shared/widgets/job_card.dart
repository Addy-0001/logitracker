import 'package:flutter/material.dart';
import '../../features/job/domain/entity/job_entity.dart';

class JobCard extends StatelessWidget {
  final JobEntity job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surface,
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.priority,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${job.startTime} - ${job.endTime}",
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(job.recipient, style: theme.textTheme.bodySmall),
              ],
            ),
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                job.imageUrl,
                height: 150,
                width: 100,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      height: 150,
                      width: 100,
                      color: theme.colorScheme.error.withOpacity(0.1),
                      child: Icon(
                        Icons.error_outline,
                        color: theme.colorScheme.error,
                        size: 40,
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
