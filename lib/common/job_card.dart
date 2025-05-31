import 'package:flutter/material.dart';
import 'package:logitracker/model/job_model.dart';

class JobCard extends StatelessWidget {
  final JobModel job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        spacing: 60,
        children: [
          Column(
            children: [
              Text(style: Theme.of(context).textTheme.bodySmall, job.priority),
              Text(
                style: Theme.of(context).textTheme.bodySmall,
                "${job.startTime} - ${job.endTime}",
              ),
              Text(style: Theme.of(context).textTheme.bodySmall, job.recipient),
            ],
          ),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              height: 150,
              "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg",
            ),
          ),
        ],
      ),
    );
  }
}
