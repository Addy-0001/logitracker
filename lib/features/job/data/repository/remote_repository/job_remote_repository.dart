import 'package:logitracker/features/job/data/data_source/remote_data_source/job_remote_datasource.dart';
import 'package:logitracker/features/job/domain/entity/job_entity.dart';
import 'package:logitracker/features/job/domain/repository/job_repository.dart';

class JobRemoteRepository implements IJobRepository {
  final JobRemoteDatasource _dataSource;

  JobRemoteRepository(this._dataSource);

  @override
  Future<List<JobEntity>> getAllJobs() async {
    var response = await _dataSource.getAllJobs();
    return response;
  }

  @override
  Future<SingleJobResponse> getJobById(String id) {
    var response = _dataSource.getJobById(id);
    return response;
  }
}
