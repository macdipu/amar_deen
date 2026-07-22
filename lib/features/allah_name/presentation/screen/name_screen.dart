import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amar_deen/core/constants/constants.dart';
import '../../domain/entities/name_of_allah_entity.dart';

class NameScreen extends StatelessWidget {
  const NameScreen(this.name);

  final NameOfAllahEntity name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          width: 1.sw,
          padding: kPagePadding,
          child: Column(
            children: [
              Spacer(
                flex: 3,
              ),
              Text(
                name.transliteration,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              Spacer(
                flex: 2,
              ),
              Text(
                name.name,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Uthman',
                    ),
                textAlign: TextAlign.center,
              ),
              Spacer(
                flex: 2,
              ),
              Text(
                name.translation,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(),
                textAlign: TextAlign.center,
              ),
              Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
