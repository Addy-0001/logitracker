import 'package:logitracker/core/constant/api_endpoints.dart';
import 'package:logitracker/dependency_inject.dart';
import 'package:logitracker/features/job/data/data_source/job_data_source.dart';
import 'package:logitracker/features/job/domain/entity/job_entity.dart';
import 'package:logitracker/services/core/http_service.dart';
import 'package:logitracker/services/core/preference_service.dart';

class JobRemoteDatasource implements IJobDataSource {
  final HttpService _httpService;

  JobRemoteDatasource(this._httpService);

  @override
  Future<List<JobEntity>> getAllJobs({String? driverId}) async {
    String endpoint;
    var userId = locator<PreferenceService>().userName;
    if (driverId != null && driverId.isNotEmpty) {
      // Use driver-specific endpoint: job/getJobForDriver/:driverId
      endpoint = 'job/getJobForDriver/$userId';
    } else {
      // Fallback to general jobs endpoint
      endpoint = ApiEndpoints.getJobs;
    }

    var response = await _httpService.getData(endpoint);
    return (response as List<dynamic>)
        .map((x) => JobEntity.fromMap(x))
        .toList();
  }

  @override
  Future<SingleJobResponse> getJobById(String id) async {
    var response = await _httpService.getData('${ApiEndpoints.jobDetails}/$id');
    return SingleJobResponse.fromMap(response as Map<String, dynamic>);
  }
}
