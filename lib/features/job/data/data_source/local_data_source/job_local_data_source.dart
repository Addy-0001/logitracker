import 'package:logitracker/features/job/domain/entity/job_entity.dart';
import '../../../../../app/constant/hive_service.dart';
import '../../model/job_hive_model.dart';

class JobLocalDataSource {
  Future<void> saveJob(JobEntity job) async {
    final box = HiveService.getJobBox();
    await box.put(
      job.jobId,
      JobHiveModel(
        jobId: job.jobId,
        priority: job.priority,
        startTime: job.startTime,
        endTime: job.endTime,
        recipient: job.recipient,
        imageUrl: job.imageUrl,
      ),
    );
  }

  Future<JobEntity?> getJob(String jobId) async {
    final box = HiveService.getJobBox();
    final jobHive = await box.get(jobId);
    if (jobHive == null) return null;
    return JobEntity(
      jobId: jobHive.jobId,
      priority: jobHive.priority,
      startTime: jobHive.startTime,
      endTime: jobHive.endTime,
      recipient: jobHive.recipient,
      imageUrl: jobHive.imageUrl,
    );
  }

  Future<List<JobEntity>> getAllJobs() async {
    final box = HiveService.getJobBox();
    return box.values
        .map(
          (jobHive) => JobEntity(
            jobId: jobHive.jobId,
            priority: jobHive.priority,
            startTime: jobHive.startTime,
            endTime: jobHive.endTime,
            recipient: jobHive.recipient,
            imageUrl: jobHive.imageUrl,
          ),
        )
        .toList();
  }
}
