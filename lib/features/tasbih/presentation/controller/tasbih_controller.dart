import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:amar_deen/core/bloc/database/database_bloc.dart';
import 'package:amar_deen/core/di/injection.dart';
import '../../domain/entities/tasbih_entity.dart';
import '../../domain/usecases/create_tasbih.dart';
import '../../domain/usecases/delete_tasbih.dart';
import '../../domain/usecases/edit_tasbih.dart';
import '../../domain/usecases/toggle_tasbih_favorite.dart';
import '../bloc/tasbih_bloc/tasbih_bloc.dart';

Future<void> toggleTasbihFavorite(BuildContext context, Tasbih tasbih) async {
  final db = BlocProvider.of<DatabaseBloc>(context).db!;
  final tasbihs = await getIt<ToggleTasbihFavorite>()(db, tasbih);
  BlocProvider.of<TasbihBloc>(context).add(UpdateTasbih(tasbihs));
}

Future<void> createTasbih(
  BuildContext context,
  TextEditingController nameController,
  TextEditingController counterController,
) async {
  final db = BlocProvider.of<DatabaseBloc>(context).db!;
  final tasbihs = await getIt<CreateTasbih>()(db, {
    'name': nameController.text,
    'counter': int.parse(counterController.text),
  });
  BlocProvider.of<TasbihBloc>(context).add(UpdateTasbih(tasbihs));

  nameController.clear();
  counterController.clear();
}

Future<void> copyTasbih(
  BuildContext context,
  Tasbih tasbih,
) async {
  final db = BlocProvider.of<DatabaseBloc>(context).db!;
  final tasbihs = await getIt<CreateTasbih>()(db, {
    'name': tasbih.name,
    'counter': tasbih.counter,
  });
  BlocProvider.of<TasbihBloc>(context).add(UpdateTasbih(tasbihs));

  Navigator.of(context).pop();
}

Future<void> editTasbih(
  BuildContext context,
  Tasbih tasbih,
  TextEditingController nameController,
  TextEditingController counterController,
) async {
  final db = BlocProvider.of<DatabaseBloc>(context).db!;
  final tasbihs = await getIt<EditTasbih>()(db, tasbih, {
    'name': nameController.text,
    'counter': int.parse(counterController.text),
  });
  BlocProvider.of<TasbihBloc>(context).add(UpdateTasbih(tasbihs));

  nameController.clear();
  counterController.clear();
}

Future<void> deleteTasbih(BuildContext context, Tasbih tasbih) async {
  final db = BlocProvider.of<DatabaseBloc>(context).db!;
  final tasbihs = await getIt<DeleteTasbih>()(db, tasbih);

  BlocProvider.of<TasbihBloc>(context).add(
    UpdateTasbih(tasbihs),
  );
  Navigator.of(context).pop();
}
