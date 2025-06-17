import 'package:flutter/material.dart';
import 'package:logitracker/core/common/card/job_card.dart';
import 'package:logitracker/model/job_model.dart';

// dashboard screen

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    this.ongoingJob = const JobModel(
      priority: "Medium Priority",
      startTime: "2 PM",
      endTime: "3 PM",
      recipient: "Adamya Neupane",
      imageUrl: "imageUrl",
    ),

    this.otherJobs = const [
      JobModel(
        priority: "High Priority",
        startTime: "3 PM",
        endTime: "4 PM",
        recipient: "John Doe",
        imageUrl: "imageUrl",
      ),
      JobModel(
        priority: "Low Priority",
        startTime: "4 PM",
        endTime: "4:30 PM",
        recipient: "Jane Doe",
        imageUrl: "imageUrl",
      ),
      JobModel(
        priority: "High Priority",
        startTime: "4 PM",
        endTime: "5 PM",
        recipient: "Random Name",
        imageUrl: "imageUrl",
      ),
      JobModel(
        priority: "Medium Priority",
        startTime: "6 PM",
        endTime: "7 PM",
        recipient: "User 1123",
        imageUrl: "imageUrl",
      ),
    ],
  });
  final JobModel ongoingJob;

  final List<JobModel> otherJobs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  style: Theme.of(context).textTheme.bodyMedium,
                  "Ongoing Delivery",
                ),
              ),

              JobCard(job: ongoingJob),

              Center(
                child: Text(
                  style: Theme.of(context).textTheme.bodyMedium,
                  "Upcoming Deliveries",
                ),
              ),

              for (int i = 0; i < otherJobs.length; i++)
                JobCard(job: otherJobs[i]),
            ],
          ),
        ),
      ),
    );
  }
}
