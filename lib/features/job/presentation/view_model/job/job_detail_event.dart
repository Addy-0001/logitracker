part of 'job_detail_view_model.dart';

abstract class JobDetailEvent {}

class FetchJobDetail extends JobDetailEvent {
  final String id;

  FetchJobDetail({required this.id});
}
