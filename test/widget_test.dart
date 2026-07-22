// Smoke test: builds the real app widget tree (DI, routing, every
// globally-provided bloc) and confirms it doesn't throw. The previous
// version of this file was the unmodified `flutter create` counter-app
// template - it always failed since this app has no counter, and never
// actually exercised anything about Sirate Mustaqeem.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:amar_deen/core/di/injection.dart';
import 'package:amar_deen/main.dart';

class _InMemoryStorage implements Storage {
  final Map<String, dynamic> _data = {};

  @override
  dynamic read(String key) => _data[key];

  @override
  Future<void> write(String key, dynamic value) async => _data[key] = value;

  @override
  Future<void> delete(String key) async => _data.remove(key);

  @override
  Future<void> clear() async => _data.clear();

  @override
  Future<void> close() async {}
}

void main() {
  setUp(() {
    HydratedBloc.storage = _InMemoryStorage();
    configureDependencies();
  });

  testWidgets('App builds without throwing', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(tester.takeException(), isNull);

    // SplashScaffold schedules a 750ms delayed navigation - let it settle
    // so no Timer is left pending when the test tears down.
    await tester.pump(const Duration(seconds: 1));
  });
}
