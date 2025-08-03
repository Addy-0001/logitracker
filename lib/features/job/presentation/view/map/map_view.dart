import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:logitracker/features/job/presentation/view_model/map/map_view_model.dart';
import 'package:dio/dio.dart';
import 'package:logitracker/dependency_inject.dart'; // Assuming locator is here

class MapView extends StatefulWidget {
  final String jobId;
  const MapView({super.key, required this.jobId});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  List<LatLng> _routePoints = [];
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    context.read<MapViewModel>().add(LoadAllCoordinates(widget.jobId));
  }

  @override
  void didUpdateWidget(covariant MapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.jobId != oldWidget.jobId) {
      context.read<MapViewModel>().add(LoadAllCoordinates(widget.jobId));
    }
  }

  Future<void> fetchRoute(LatLng start, LatLng end) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://api.openrouteservice.org/v2/directions/driving-car',
        queryParameters: {
          'api_key':
              'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6IjE4NjgzMTQ3ODE4OTQ4MmNhZWYxMGQyODVhOTlkM2U0IiwiaCI6Im11cm11cjY0In0=',
          'start': '${start.longitude},${start.latitude}',
          'end': '${end.longitude},${end.latitude}',
        },
      );
      final geometry = response.data['features'][0]['geometry']['coordinates'];
      setState(() {
        _routePoints =
            geometry.map<LatLng>((coord) {
              return LatLng(coord[1], coord[0]);
            }).toList();
      });

      if (_routePoints.isNotEmpty) {
        _mapController.fitCamera(
          CameraFit.bounds(
            bounds: LatLngBounds.fromPoints(_routePoints),
            padding: const EdgeInsets.all(50.0),
          ),
        );
      }
    } catch (e) {
      print("Failed to fetch route: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Delivery Map",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.red[700]!, Colors.red[800]!, Colors.red[900]!],
              stops: const [0.0, 0.5, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.red[800]!.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<MapViewModel, MapState>(
        builder: (context, state) {
          if (state is MapLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red[700]!),
                strokeWidth: 4,
              ),
            );
          } else if (state is MapLoaded) {
            final coords = state.coordinates;
            final pickup = LatLng(
              coords.pickupCoordinates.latitude,
              coords.pickupCoordinates.longitude,
            );
            final dropoff = LatLng(
              coords.dropoffCoordinates.latitude,
              coords.dropoffCoordinates.longitude,
            );
            final current =
                coords.currentCoordinates != null
                    ? LatLng(
                      coords.currentCoordinates!.latitude,
                      coords.currentCoordinates!.longitude,
                    )
                    : null;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_routePoints.isEmpty) {
                fetchRoute(pickup, dropoff);
              }
            });

            final markers = <Marker>[
              Marker(
                point: pickup,
                width: 50,
                height: 50,
                child: Icon(
                  Icons.location_on,
                  color: Colors.green[700],
                  size: 40,
                ),
              ),
              Marker(
                point: dropoff,
                width: 50,
                height: 50,
                child: Icon(Icons.flag, color: Colors.red[700], size: 40),
              ),
            ];
            if (current != null) {
              markers.add(
                Marker(
                  point: current,
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.directions_car,
                    color: Colors.blue[700],
                    size: 40,
                  ),
                ),
              );
            }

            return Stack(
              // Use Stack to overlay zoom buttons
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: pickup,
                    initialZoom: 13.0,
                    initialCameraFit:
                        _routePoints.isNotEmpty
                            ? CameraFit.bounds(
                              bounds: LatLngBounds.fromPoints(_routePoints),
                              padding: const EdgeInsets.all(50.0),
                            )
                            : null,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c'],
                      userAgentPackageName: 'com.example.logitracker',
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: _routePoints,
                          strokeWidth: 6.0,
                          color: Colors.redAccent[700]!,
                          borderStrokeWidth: 2.0,
                          borderColor: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                    MarkerLayer(markers: markers),
                  ],
                ),
                // Zoom Buttons
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        heroTag: 'zoomInBtn', // Unique tag for hero animation
                        mini: true,
                        backgroundColor: Colors.red[600],
                        foregroundColor: Colors.white,
                        onPressed: () {
                          _mapController.move(
                            _mapController.camera.center,
                            _mapController.camera.zoom + 1,
                          );
                        },
                        child: const Icon(Icons.add),
                      ),
                      const SizedBox(height: 8),
                      FloatingActionButton(
                        heroTag: 'zoomOutBtn', // Unique tag for hero animation
                        mini: true,
                        backgroundColor: Colors.red[600],
                        foregroundColor: Colors.white,
                        onPressed: () {
                          _mapController.move(
                            _mapController.camera.center,
                            _mapController.camera.zoom - 1,
                          );
                        },
                        child: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is MapError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red[700], size: 60),
                  const SizedBox(height: 16),
                  Text(
                    "Error: ${state.message}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<MapViewModel>().add(
                        LoadAllCoordinates(widget.jobId),
                      );
                    },
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    label: const Text(
                      "Retry",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
