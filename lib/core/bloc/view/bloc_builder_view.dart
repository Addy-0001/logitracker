import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/core/bloc/state/bloc_state.dart';
import 'package:logitracker/core/common/widgets/center_hint_text.dart';
import 'package:logitracker/core/common/widgets/loading_widget.dart';

class BlocBuilderView<B extends StateStreamable<S>, S, LS extends LoadedState>
    extends StatelessWidget {
  final Widget? loadingWidget;
  final Widget Function(BuildContext, String)? errorWidget;
  final Widget Function(BuildContext, LS) child;

  const BlocBuilderView({
    super.key,
    this.loadingWidget,
    this.errorWidget,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        if (state is LoadingState) {
          return loadingWidget ?? const LoadingWidget();
        } else if (state is LoadedState) {
          return child(context, state as LS);
        } else if (state is ErrorState) {
          return errorWidget != null
              ? errorWidget!(context, state.message)
              : CenterHintText(text: state.message);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
