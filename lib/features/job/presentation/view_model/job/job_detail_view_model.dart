import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/core/bloc/state/bloc_state.dart';
import 'package:logitracker/features/job/domain/entity/job_entity.dart';
import 'package:logitracker/features/job/domain/use_case/get_job_by_id_use_case.dart';

part 'job_detail_event.dart';
part 'job_detail_state.dart';

class JobDetailViewModel extends Bloc<JobDetailEvent, JobDetailState> {
  final GetJobByIdUseCase _useCase;
  final String id;

  JobDetailViewModel(this._useCase, this.id) : super(JobDetailInitial()) {
    on<FetchJobDetail>(fetchJobById);
    add(FetchJobDetail(id: id));
  }

  Future<void> fetchJobById(
    FetchJobDetail event,
    Emitter<JobDetailState> emit,
  ) async {
    emit(JobDetailLoading());

    final response = await _useCase.call(event.id);
    response.fold(
      (e) {
        emit(JobDetailError(e.toString()));
        return true;
      },
      (job) {
        emit(JobDetailLoaded(job));
        return true;
      },
    );
  }
}
