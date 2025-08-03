import 'package:logitracker/core/constant/api_endpoints.dart';
import 'package:logitracker/features/job/data/data_source/coordinate_data_source.dart';
import 'package:logitracker/services/core/http_service.dart';

class CoordinateRemoteDatasource implements CoordinateDataSource {
  final HttpService _httpService;

  CoordinateRemoteDatasource(this._httpService);
  @override
  Future<void> updateLiveCoordinate(
    String jobId,
    double latitude,
    double longitude,
  ) async {
    final data = {
      "currentCoords": {"latitude": latitude, "longitude": longitude},
    };

    final response = await _httpService.patchData(
      "/updateCoord/$jobId",
      data: data,
    );

    // Optional: Handle response
    if (response['success'] != true) {
      throw Exception(response['message'] ?? "Failed to update coordinates");
    }
  }

  @override
  Future<Map<String, dynamic>> getLiveCoordinate(String jobId) async {
    final response = await _httpService.getData("/getLiveCoord/$jobId");
    return response['coordinate']; // contains latitude & longitude
  }

  @override
  Future<Map<String, dynamic>> getPickupAndDropoff(String jobId) async {
    final response = await _httpService.getData("/getCoord/$jobId");
    return {
      'pickup': response['pickupCoordinates'],
      'dropoff': response['dropoffCoordinates'],
    };
  }

  @override
  Future<Map<String, dynamic>> getAllCoordinates(String jobId) async {
    final response = await _httpService.getData(
      "${ApiEndpoints.getAllCoord}/$jobId",
    );
    return Map<String, dynamic>.from(response['data']);
  }
}
