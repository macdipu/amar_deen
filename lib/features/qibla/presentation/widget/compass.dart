import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Compass extends StatelessWidget {
  const Compass({required this.heading, required this.qiblah});

  /// Device's current compass heading, in degrees (0-360).
  final double heading;

  /// Bearing from true north to the Qiblah, in degrees (0-360).
  final double qiblah;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 0.5.sh,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: heading * (pi / 180) * -1,
              child: SvgPicture.asset(
                'assets/images/qiblat_icon/svg/kiblat_lingkar.svg',
                height: 0.5.sh,
              ),
            ),
            Transform.rotate(
              angle: qiblah * (pi / 180) * -1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 0.0625.sh),
                  SvgPicture.asset(
                    'assets/images/qiblat_icon/svg/kiblat_needle.svg',
                    height: 0.25.sh,
                  ),
                  SizedBox(height: 0.1875.sh),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
