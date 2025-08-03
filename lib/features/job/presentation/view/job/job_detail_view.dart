import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/core/bloc/view/bloc_provider_view.dart';
import 'package:logitracker/dependency_inject.dart';
import 'package:logitracker/features/job/domain/repository/coordinate_repository.dart';
import 'package:logitracker/features/job/presentation/view/map/map_view.dart';
import 'package:logitracker/features/job/presentation/view_model/job/job_detail_view_model.dart';
import 'package:logitracker/features/job/domain/entity/job_entity.dart';
import 'package:logitracker/features/job/presentation/view_model/map/map_view_model.dart';

class JobDetailView extends StatefulWidget {
  final String id;
  const JobDetailView({super.key, required this.id});

  @override
  State<JobDetailView> createState() => _JobDetailViewState();
}

class _JobDetailViewState extends State<JobDetailView> {
  @override
  Widget build(BuildContext context) {
    return BlocProviderView<JobDetailViewModel>(
      objLocator: () => locator<JobDetailViewModel>(param1: widget.id),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text(
            'Job Details',
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
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.grey[50]!, Colors.white],
            ),
          ),
          child: BlocListener<JobDetailViewModel, JobDetailState>(
            listener: (context, state) {
              if (state is JobDetailError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: ${state.message}'),
                    backgroundColor: Colors.red[700],
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(16),
                  ),
                );
              }
            },
            child: BlocBuilder<JobDetailViewModel, JobDetailState>(
              builder: (context, state) {
                if (state is JobDetailLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.red[700]!,
                      ),
                      strokeWidth: 4,
                    ),
                  );
                } else if (state is JobDetailError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.red[700],
                          size: 60,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Failed to load job details: ${state.message}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is JobDetailLoaded) {
                  final job = state.job.job; // ← actual JobEntity
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Job ID Header
                        _buildHeaderCard(job),
                        const SizedBox(height: 24),

                        // Driver Info
                        _buildSectionCard(
                          context,
                          title: "Driver Information",
                          icon: Icons.person_outline,
                          children: [
                            _buildInfoRow(
                              "Name",
                              job.driverInfo.name,
                              Icons.person,
                            ),
                            _buildInfoRow(
                              "Phone",
                              job.driverInfo.phone,
                              Icons.phone,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Pickup Info
                        _buildSectionCard(
                          context,
                          title: "Pickup Information",
                          icon: Icons.location_on_outlined,
                          children: [
                            _buildInfoRow(
                              "Name",
                              job.pickupInfo.name,
                              Icons.business,
                            ),
                            _buildInfoRow(
                              "Phone",
                              job.pickupInfo.phone,
                              Icons.phone,
                            ),
                            _buildInfoRow(
                              "Email",
                              job.pickupInfo.email,
                              Icons.email,
                            ),
                            _buildInfoRow(
                              "Latitude",
                              job.pickupInfo.latitude.toString(),
                              Icons.map,
                            ),
                            _buildInfoRow(
                              "Longitude",
                              job.pickupInfo.longitude.toString(),
                              Icons.map,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Drop-off Info
                        _buildSectionCard(
                          context,
                          title: "Drop-off Information",
                          icon: Icons.location_on_outlined,
                          children: [
                            _buildInfoRow(
                              "Name",
                              job.dropoffInfo.name,
                              Icons.business,
                            ),
                            _buildInfoRow(
                              "Phone",
                              job.dropoffInfo.phone,
                              Icons.phone,
                            ),
                            _buildInfoRow(
                              "Email",
                              job.dropoffInfo.email,
                              Icons.email,
                            ),
                            _buildInfoRow(
                              "Latitude",
                              job.dropoffInfo.latitude.toString(),
                              Icons.map,
                            ),
                            _buildInfoRow(
                              "Longitude",
                              job.dropoffInfo.longitude.toString(),
                              Icons.map,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Current Coordinates
                        _buildSectionCard(
                          context,
                          title: "Current Coordinates",
                          icon: Icons.my_location,
                          children: [
                            _buildInfoRow(
                              "Latitude",
                              job.currentCoords.latitude?.toString() ??
                                  'Not available',
                              Icons.gps_fixed,
                            ),
                            _buildInfoRow(
                              "Longitude",
                              job.currentCoords.longitude?.toString() ??
                                  'Not available',
                              Icons.gps_fixed,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Status & Meta (now includes prominent status)
                        _buildSectionCard(
                          context,
                          title: "Status & Metadata",
                          icon: Icons.info_outline,
                          children: [
                            _buildProminentStatusRow(
                              "Current Status",
                              job.status,
                            ),
                            _buildInfoRow(
                              "Urgent",
                              job.isUrgent ? 'Yes' : 'No',
                              Icons.priority_high,
                            ),
                            _buildInfoRow(
                              "Note",
                              job.note.isNotEmpty ? job.note : 'N/A',
                              Icons.note,
                            ),
                            _buildInfoRow(
                              "Created At",
                              _formatDate(job.createdAt),
                              Icons.access_time,
                            ),
                            _buildInfoRow(
                              "Updated At",
                              _formatDate(job.updatedAt),
                              Icons.update,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Add-Ons
                        if (job.addOns.fragileItems || job.addOns.heavyItem)
                          _buildSectionCard(
                            context,
                            title: "Add-Ons",
                            icon: Icons.extension,
                            children: [
                              _buildAddOnChip(
                                "Fragile Items",
                                job.addOns.fragileItems,
                                Icons.broken_image,
                                Colors.orange,
                              ),
                              _buildAddOnChip(
                                "Heavy Item",
                                job.addOns.heavyItem,
                                Icons.fitness_center,
                                Colors.purple,
                              ),
                            ],
                          ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox(); // fallback
                }
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            final jobId = widget.id;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (_) => BlocProvider(
                      create:
                          (_) => MapViewModel(locator<ICoordinateRepository>()),
                      child: MapView(jobId: jobId),
                    ),
              ),
            );
          },
          icon: const Icon(Icons.map_outlined, color: Colors.white),
          label: const Text(
            "View Map",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          backgroundColor: Colors.red[700],
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget _buildHeaderCard(JobEntity job) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red[600]!, Colors.red[800]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.red[800]!.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Job ID: ${job.id}",
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.5,
              shadows: [
                Shadow(
                  blurRadius: 5,
                  color: Colors.black45,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Colors.white.withOpacity(0.8),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                "Created: ${_formatDate(job.createdAt)}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.update,
                color: Colors.white.withOpacity(0.8),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                "Last Updated: ${_formatDate(job.updatedAt)}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.red[700], size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const Divider(height: 24, thickness: 1, color: Colors.grey),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[900],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProminentStatusRow(String label, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getStatusColor(status).withOpacity(0.4),
                    ),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(status),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddOnChip(
    String label,
    bool isEnabled,
    IconData icon,
    Color color,
  ) {
    if (!isEnabled) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange[700]!;
      case 'in_progress':
      case 'in progress':
        return Colors.blue[700]!;
      case 'completed':
        return Colors.green[700]!;
      case 'cancelled':
        return Colors.red[700]!;
      default:
        return Colors.grey[700]!;
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }
}
