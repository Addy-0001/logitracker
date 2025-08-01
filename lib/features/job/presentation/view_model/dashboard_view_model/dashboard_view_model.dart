import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/features/job/domain/use_case/get_ongoing_job_use_case.dart';
import 'package:logitracker/features/job/domain/use_case/get_upcoming_jobs_use_case.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardViewModel extends Bloc<DashboardEvent, DashboardState> {
  final GetOngoingJobUseCase getOngoingJobUseCase;
  final GetUpcomingJobsUseCase getUpcomingJobsUseCase;

  DashboardViewModel(this.getOngoingJobUseCase, this.getUpcomingJobsUseCase)
    : super(DashboardState()) {
    on<LoadJobsEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      final ongoingResult = await getOngoingJobUseCase();
      final upcomingResult = await getUpcomingJobsUseCase();
      ongoingResult.fold(
        (failure) => emit(
          state.copyWith(isLoading: false, errorMessage: failure.message),
        ),
        (ongoingJob) => upcomingResult.fold(
          (failure) => emit(
            state.copyWith(isLoading: false, errorMessage: failure.message),
          ),
          (upcomingJobs) => emit(
            state.copyWith(
              isLoading: false,
              ongoingJob: ongoingJob,
              upcomingJobs: upcomingJobs,
            ),
          ),
        ),
      );
    });
  }
}
