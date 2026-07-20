import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'locale_event.dart';
part 'locale_state.dart';

const List<Locale> kSupportedLocales = [Locale('en'), Locale('bn')];

class LocaleBloc extends HydratedBloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(const LocaleState(Locale('en'))) {
    on<LocaleEvent>((event, emit) async {
      if (event is ChangeLocale) {
        emit(LocaleState(event.locale));
      }
    });
  }

  @override
  LocaleState? fromJson(Map<String, dynamic> json) {
    try {
      final code = json['languageCode'] as String;
      final locale = kSupportedLocales.firstWhere(
        (l) => l.languageCode == code,
        orElse: () => const Locale('en'),
      );
      return LocaleState(locale);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, String>? toJson(LocaleState state) {
    try {
      return {'languageCode': state.locale.languageCode};
    } catch (e) {
      return null;
    }
  }
}
