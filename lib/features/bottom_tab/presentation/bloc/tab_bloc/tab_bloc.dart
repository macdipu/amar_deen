import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:amar_deen/features/bookmark/presentation/screen/bookmark_screen.dart';
import 'package:amar_deen/features/home/presentation/screen/home_screen.dart';
import 'package:amar_deen/features/quran/presentation/screen/quran_screen.dart';
import 'package:amar_deen/features/search/presentation/screen/search_screen.dart';
import 'package:amar_deen/features/settings/presentation/screen/setting_screen.dart';

part 'tab_event.dart';
part 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabState(0, pages[0])) {
    on<TabEvent>((event, emit) async {
      if (event is SetTab) {
        emit(TabState(
          event.index,
          pages[event.index],
        ));
      }
    });
  }
}

final List<Widget> pages = [
  HomeScreen(),
  SearchScreen(),
  QuranScreen(fromNav: true),
  BookmarkScreen(),
  SettingScreen(),
];
