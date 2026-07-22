import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../di/injection.dart';
import '../error/exceptions.dart';
import 'package:amar_deen/features/dua_azkar/domain/dua/usecases/get_duas.dart';
import 'package:amar_deen/features/dua_azkar/presentation/dua/bloc/dua_bloc/dua_bloc.dart';
import 'package:amar_deen/features/quran/presentation/bloc/juz_bloc/juz_bloc.dart';
import 'package:amar_deen/features/quran/presentation/bloc/quran_bloc/quran_bloc.dart';
import 'package:amar_deen/features/quran/presentation/bloc/surah_bloc/surah_bloc.dart';
import 'package:amar_deen/features/tasbih/domain/usecases/get_tasbihs.dart';
import 'package:amar_deen/features/tasbih/presentation/bloc/tasbih_bloc/tasbih_bloc.dart';
import 'database_service.dart';

class DatabaseTable {
  static Future<void> cachedDataFromDb(
      Database db, BuildContext context) async {
    try {
      final duas = await getIt<GetDuas>()(db);

      BlocProvider.of<DuaBloc>(context).add(
        FetchDua(duas),
      );

      BlocProvider.of<QuranBloc>(context).add(
        FetchQuran(
          favoriteAyatIds:
              await DatabaseService().getFavoriteAyatIdsByLatest(db),
        ),
      );

      BlocProvider.of<SurahBloc>(context).add(
        FetchSurah(),
      );

      final tasbihs = await getIt<GetTasbihs>()(db);

      BlocProvider.of<TasbihBloc>(context).add(
        FetchTasbih(tasbihs),
      );

      List<Map<String, Object?>> juzs = await db.query('juz');

      BlocProvider.of<JuzBloc>(context).add(
        FetchJuz(juzs),
      );
    } catch (e) {
      throw LocalException(e.toString());
    }
  }
}
