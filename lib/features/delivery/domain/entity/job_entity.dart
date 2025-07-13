import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  final String id;
  final String? customerName;
  final String? status;

  JobEntity({required this.id, this.customerName, this.status});

  @override
  List<Object?> get props => [id, customerName, status];
}
