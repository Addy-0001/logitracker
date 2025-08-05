import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:logitracker/features/job/domain/entity/coordinate_entity.dart';
import 'package:logitracker/features/job/domain/repository/coordinate_repository.dart';
import 'package:logitracker/services/location/location_service.dart';

class LiveTrackingService {
  static LiveTrackingService? _instance;

  final ICoordinateRepository _coordinateRepository;
  StreamSubscription<Position>? _locationSubscription;
  Timer? _updateTimer;
  String? _currentJobId;
  bool _isTracking = false;

  LiveTrackingService._internal(this._coordinateRepository);

  factory LiveTrackingService.create(
    ICoordinateRepository coordinateRepository,
  ) {
    _instance = LiveTrackingService._internal(coordinateRepository);
    return _instance!;
  }

  static LiveTrackingService get instance {
    if (_instance == null) {
      throw StateError(
        'LiveTrackingService not initialized. Call create() first.',
      );
    }
    return _instance!;
  }

  bool get isTracking => _isTracking;
  String? get currentJobId => _currentJobId;

  Future<bool> startTracking(String jobId) async {
    if (_isTracking && _currentJobId == jobId) {
      return true; // Already tracking this job
    }

    // Stop any existing tracking
    await stopTracking();

    _currentJobId = jobId;

    // Start location tracking
    final locationStarted = await LocationService.instance.startTracking();
    if (!locationStarted) {
      return false;
    }

    // Listen to location updates
    _locationSubscription = LocationService.instance.positionStream.listen(
      (Position position) async {
        await _updateJobCoordinate(position);
      },
      onError: (error) {
        print('Location stream error: $error');
      },
    );

    // Set up periodic updates every 30 seconds as backup
    _updateTimer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      final position = await LocationService.instance.getCurrentPosition();
      if (position != null) {
        await _updateJobCoordinate(position);
      }
    });

    _isTracking = true;
    return true;
  }

  Future<void> _updateJobCoordinate(Position position) async {
    if (_currentJobId == null) return;

    try {
      final coordinate = CoordinateEntity(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      await _coordinateRepository.updateLiveCoordinate(
        _currentJobId!,
        coordinate,
      );
      print(
        'Updated job $_currentJobId coordinates: ${position.latitude}, ${position.longitude}',
      );
    } catch (e) {
      print('Error updating job coordinate: $e');
    }
  }

  Future<void> stopTracking() async {
    _isTracking = false;
    _currentJobId = null;

    await _locationSubscription?.cancel();
    _locationSubscription = null;

    _updateTimer?.cancel();
    _updateTimer = null;

    LocationService.instance.stopTracking();
  }

  void dispose() {
    stopTracking();
  }
}
