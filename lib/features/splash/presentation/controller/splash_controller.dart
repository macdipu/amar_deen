import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:amar_deen/core/bloc/database/database_bloc.dart';

Future<void> checkDatabaseAvailability(BuildContext context) async {
  BlocProvider.of<DatabaseBloc>(context).add(InitDatabase(context));
}
