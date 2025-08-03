import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:logitracker/core/bloc/view/bloc_provider_view.dart';

class MockCubit extends Cubit<String> {
  MockCubit() : super('initial');
}

void main() {
  group('BlocProviderView Widget Tests', () {
    late GetIt locator;

    setUp(() {
      locator = GetIt.instance;
      locator.registerFactory<MockCubit>(() => MockCubit());
    });

    tearDown(() {
      locator.reset();
    });

    testWidgets('should provide bloc to child widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProviderView<MockCubit>(
            child: Builder(
              builder: (context) {
                final cubit = context.read<MockCubit>();
                return Text('State: ${cubit.state}');
              },
            ),
          ),
        ),
      );

      expect(find.text('State: initial'), findsOneWidget);
    });

    testWidgets('should use custom object locator when provided', (
      tester,
    ) async {
      final customCubit = MockCubit();
      customCubit.emit('custom');

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProviderView<MockCubit>(
            objLocator: () => customCubit,
            child: BlocBuilder<MockCubit, String>(
              builder: (context, state) => Text('State: $state'),
            ),
          ),
        ),
      );

      expect(find.text('State: custom'), findsOneWidget);
    });

    testWidgets('should render child widget correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProviderView<MockCubit>(child: const Text('Child Widget')),
        ),
      );

      expect(find.text('Child Widget'), findsOneWidget);
    });
  });
}
