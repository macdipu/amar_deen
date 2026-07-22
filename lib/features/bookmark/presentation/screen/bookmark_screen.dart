import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:amar_deen/features/dua_azkar/presentation/dua/bloc/dua_bloc/dua_bloc.dart';
import 'package:amar_deen/features/quran/presentation/bloc/quran_bloc/quran_bloc.dart';
import 'package:amar_deen/features/tasbih/presentation/bloc/tasbih_bloc/tasbih_bloc.dart';
import '../bloc/category_bloc/category_bloc.dart';
import '../widget/bookmark_content.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: CategoryBloc(
        BlocProvider.of<DuaBloc>(context).state.duas,
        BlocProvider.of<TasbihBloc>(context).state.tasbihs,
        BlocProvider.of<QuranBloc>(context).state.qurans,
      ),
      child: BookmarkContent(),
    );
  }
}
