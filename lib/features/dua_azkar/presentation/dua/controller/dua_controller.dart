import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:amar_deen/core/bloc/database/database_bloc.dart';
import 'package:amar_deen/core/di/injection.dart';
import '../../../domain/dua/entities/dua_entity.dart';
import '../../../domain/dua/usecases/toggle_dua_favorite.dart';
import '../bloc/dua_bloc/dua_bloc.dart';

Future<void> toggleDuaFavorite(BuildContext context, Dua dua) async {
  final db = BlocProvider.of<DatabaseBloc>(context).db!;
  final duas = await getIt<ToggleDuaFavorite>()(db, dua);
  BlocProvider.of<DuaBloc>(context).add(UpdateDua(duas));
}
