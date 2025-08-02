// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:logitracker/shared/widgets/center_hint_text.dart';
import 'package:logitracker/shared/widgets/loading_widget.dart';

class LoadPageWidget<T> extends StatelessWidget {
  final Future<T> futureFunction;
  final Widget Function(BuildContext context, T) builder;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Widget? noDataWidget;
  const LoadPageWidget({
    super.key,
    required this.futureFunction,
    required this.builder,
    this.errorWidget,
    this.loadingWidget,
    this.noDataWidget,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: futureFunction,
      builder: (c, x) {
        if (x.connectionState == ConnectionState.waiting) {
          return loadingWidget ?? LoadingWidget();
        } else if (x.hasError) {
          return errorWidget ?? CenterHintText(text: x.error.toString());
        } else if (x.hasData) {
          if (x.data == null) {
            return noDataWidget ??
                const CenterHintText(text: ("No Data Found"));
          }
          return builder(context, x.data as T);
        } else {
          return noDataWidget ?? const CenterHintText(text: ("No Data Found"));
        }
      },
    );
  }
}
