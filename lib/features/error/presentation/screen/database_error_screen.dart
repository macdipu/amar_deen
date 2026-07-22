import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:amar_deen/core/bloc/database/database_bloc.dart';
import 'package:amar_deen/core/error/widgets/failure_widget.dart';

// No data/domain layer: this screen has no external data source or business
// logic of its own - it only renders `DatabaseBloc`'s existing failure state
// via `FailureWidget` (same "nothing to abstract" precedent as
// `ZakatCalculatorCubit` skipping `data/`, see PROGRESS.md TASK-029).
class DatabaseErrorScreen extends StatelessWidget {
  const DatabaseErrorScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabaseBloc, DatabaseState>(
      builder: (context, state) {
        if (state is DatabaseFailed)
          return Scaffold(
            body: SafeArea(
              child: FailureWidget(
                state.failure,
                () {},
              ),
            ),
          );
        return Scaffold();
      },
    );
  }
}
