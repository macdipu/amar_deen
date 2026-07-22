import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amar_deen/core/constants/constants.dart';

class ChangeLanguageSwitch extends StatelessWidget {
  final bool isBangla;
  final ValueChanged<bool> onChanged;

  ChangeLanguageSwitch({
    required this.isBangla,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isBangla),
      child: AnimatedContainer(
        duration: kAnimationDuration,
        curve: kAnimationCurve,
        width: 80.0.w,
        height: 40.0.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0.r),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('EN'), Text('বাং')],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4.0.w,
              ),
              child: AnimatedAlign(
                duration: kAnimationDuration,
                curve: kAnimationCurve,
                alignment:
                    isBangla ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 28.0.w,
                  height: 28.0.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: AnimatedSwitcher(
                    duration: kAnimationDuration,
                    switchInCurve: kAnimationCurve,
                    reverseDuration: Duration.zero,
                    child: isBangla
                        ? Text(
                            'বাং',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 11.sp,
                            ),
                          )
                        : Text(
                            'EN',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
