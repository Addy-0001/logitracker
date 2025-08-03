abstract class CoordinateDataSource {
  Future<void> updateLiveCoordinate(
    String jobId,
    double latitude,
    double longitude,
  );
  Future<Map<String, dynamic>> getLiveCoordinate(String jobId);
  Future<Map<String, dynamic>> getPickupAndDropoff(String jobId);
  Future<Map<String, dynamic>> getAllCoordinates(String jobId);
}
