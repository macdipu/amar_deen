import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amar_deen/l10n/generated/app_localizations.dart';

import '../bloc/dua_bloc/dua_bloc.dart';
import '../bloc/dropdown_bloc/dropdown_bloc.dart';
import '../widget/dua_category_card.dart';

class DuaScreen extends StatelessWidget {
  const DuaScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DuaBloc, DuaState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).homeCollectionDua),
          ),
          body: SafeArea(
            child: ListView.builder(
                itemCount: state.duas.categorizedDuas.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: index == 0
                        ? EdgeInsets.only(
                            top: 16.h,
                            bottom: 8.0.h,
                          )
                        : EdgeInsets.symmetric(
                            vertical: 8.0.h,
                          ),
                    child: BlocProvider(
                      create: (context) => DropdownBloc(),
                      child: DuaCategoryCard(
                        state.duas.categorizedDuasList[index],
                        index + 1,
                      ),
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
