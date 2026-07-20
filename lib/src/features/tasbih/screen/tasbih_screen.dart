import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sirat_e_mustaqeem/l10n/generated/app_localizations.dart';

import '../../../core/util/bloc/tasbih/tasbih_bloc.dart';
import '../../../core/util/constants.dart';
import '../controller/tasbih_controller.dart';
import '../widget/detail_dialog.dart';
import '../widget/tasbih_card.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen();

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  late final TextEditingController nameController;
  late final TextEditingController counterController;

  @override
  void initState() {
    nameController = TextEditingController();
    counterController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    counterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<TasbihBloc, TasbihState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.homeCollectionTasbih),
            actions: [
              GestureDetector(
                onTap: () async {
                  await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: kBottomSheetBorderRadius,
                      ),
                      builder: (context) {
                        return DetailDialog(
                          title: l10n.tasbihAddNew,
                          nameController: nameController,
                          counterController: counterController,
                          submitFunction: () async {
                            await createTasbih(
                              context,
                              nameController,
                              counterController,
                            );
                          },
                        );
                      });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: SvgPicture.asset(
                    'assets/images/tasbih_icon/svg/add.svg',
                    width: 24.w,
                    color: kDarkTextColor,
                  ),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: ListView.builder(
                itemCount: state.tasbihs.tasbihs.length,
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
                    child: TasbihCard(
                      state.tasbihs.tasbihs[index],
                      index + 1,
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
