import 'package:flutter/material.dart';
import 'package:logitracker_mobile_app/features/delivery/domain/entity/job_entity.dart';

class JobCard extends StatelessWidget {
  final JobEntity job;

  const JobCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(job.customerName ?? 'Unknown Customer'),
        subtitle: Text('Status: ${job.status}'),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to job details
        },
      ),
    );
  }
}
