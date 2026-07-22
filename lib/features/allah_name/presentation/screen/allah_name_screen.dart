import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/allah_name_bloc/allah_name_bloc.dart';
import 'package:amar_deen/l10n/generated/app_localizations.dart';

import 'package:amar_deen/core/constants/constants.dart';
import '../widget/name_card.dart';

class AllahNameScreen extends StatelessWidget {
  const AllahNameScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllahNameBloc, AllahNameState>(
      builder: (context, state) {
        if (state.allahNames.isEmpty) {
          BlocProvider.of<AllahNameBloc>(context).add(
            const FetchAllahName(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).homeCollectionAllahNames),
          ),
          body: SafeArea(
            child: Padding(
              padding: kPagePadding,
              child: ListView.builder(
                itemCount: state.allahNames.length,
                itemBuilder: (context, index) => NameCard(
                  state.allahNames[index],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
