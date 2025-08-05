import 'package:logitracker/features/job/domain/entity/job_entity.dart';

abstract interface class IJobDataSource {
  Future<List<JobEntity>> getAllJobs({String? driverId});
  Future<SingleJobResponse> getJobById(String id);
}
