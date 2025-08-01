import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logitracker/dependency_inject.dart';

class BlocProviderView<T extends StateStreamableSource<Object?>>
    extends StatelessWidget {
  final Widget child;
  final T Function()? objLocator;

  const BlocProviderView({super.key, required this.child, this.objLocator});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(
      create: (_) => objLocator != null ? objLocator!() : locator<T>(),
      child: child,
    );
  }
}
