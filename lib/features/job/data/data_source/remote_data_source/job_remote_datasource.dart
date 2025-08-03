import 'package:logitracker/core/constant/api_endpoints.dart';
import 'package:logitracker/features/job/data/data_source/job_data_source.dart';
import 'package:logitracker/features/job/domain/entity/job_entity.dart';
import 'package:logitracker/services/core/http_service.dart';

class JobRemoteDatasource implements IJobDataSource {
  final HttpService _httpService;

  JobRemoteDatasource(this._httpService);
  @override
  Future<List<JobEntity>> getAllJobs() async {
    var response = await _httpService.getData(ApiEndpoints.getJobs);
    return (response as List<dynamic>)
        .map((x) => JobEntity.fromMap(x))
        .toList();
  }
}
