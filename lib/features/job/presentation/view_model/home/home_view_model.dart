import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/core/bloc/state/bloc_state.dart';
import 'package:logitracker/features/job/domain/entity/job_entity.dart';
import 'package:logitracker/features/job/domain/use_case/get_all_jobs_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeViewModel extends Bloc<HomeEvent, HomeState> {
  final GetAllJobsUseCase _useCase;
  final String? id;

  HomeViewModel(this._useCase, this.id) : super(HomeInitial()) {
    on<FetchJobs>(fetchJobs);
    add(FetchJobs(id));
  }

  Future<void> fetchJobs(FetchJobs event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    final response = await _useCase.call(id);
    response.fold(
      (e) {
        emit(HomeError(e.toString()));
        return true;
      },
      (x) {
        emit(HomeLoaded(x));
        return true;
      },
    );
  }
}
