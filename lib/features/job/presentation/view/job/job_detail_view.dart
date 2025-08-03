import 'package:flutter/widgets.dart';

class JobDetailView extends StatefulWidget {
  // The job id is needed for navigation here.
  final String id; 
  const JobDetailView({super.key, required this.id});

  @override
  State<JobDetailView> createState() => _JobDetailViewState();
}

class _JobDetailViewState extends State<JobDetailView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
