import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/app/service_locator/service_locator.dart';
import '../../../../core/common/card/job_card.dart';
import '../view_model/dashboard_view_model/dashboard_event.dart';
import '../view_model/dashboard_view_model/dashboard_state.dart';
import '../view_model/dashboard_view_model/dashboard_view_model.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<DashboardViewModel>()..add(LoadJobsEvent()),
      child: BlocBuilder<DashboardViewModel, DashboardState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: theme.colorScheme.background,
            body: SafeArea(
              child:
                  state.isLoading
                      ? Center(
                        child: CircularProgressIndicator(
                          color: theme.colorScheme.primary,
                        ),
                      )
                      : SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "Ongoing Delivery",
                                style: theme.textTheme.displayMedium,
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (state.ongoingJob != null)
                              JobCard(job: state.ongoingJob!),
                            const SizedBox(height: 24),
                            Center(
                              child: Text(
                                "Upcoming Deliveries",
                                style: theme.textTheme.displayMedium,
                              ),
                            ),
                            const SizedBox(height: 16),
                            for (var job in state.upcomingJobs)
                              JobCard(job: job),
                          ],
                        ),
                      ),
            ),
          );
        },
      ),
    );
  }
}
