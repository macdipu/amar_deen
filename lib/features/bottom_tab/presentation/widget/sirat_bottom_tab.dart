import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:amar_deen/l10n/generated/app_localizations.dart';
import 'package:amar_deen/features/bottom_tab/presentation/bloc/tab_bloc/tab_bloc.dart';

class SiratNavigationBar extends StatelessWidget {
  const SiratNavigationBar();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<TabBloc, TabState>(
      builder: (context, state) {
        return BottomNavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: state.index,
          onTap: (index) => BlocProvider.of<TabBloc>(context).add(
            SetTab(index),
          ),
          selectedFontSize: Theme.of(context).textTheme.bodyMedium!.fontSize!,
          unselectedFontSize: Theme.of(context).textTheme.bodyMedium!.fontSize!,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/navigation_icon/svg/home_nfill.svg',
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
                width: 24.sp,
              ),
              label: l10n.navHome,
              activeIcon: SvgPicture.asset(
                'assets/images/navigation_icon/svg/home_nfill.svg',
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor,
                width: 24.sp,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/navigation_icon/svg/search.svg',
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
                width: 24.sp,
              ),
              label: l10n.navSearch,
              activeIcon: SvgPicture.asset(
                'assets/images/navigation_icon/svg/search.svg',
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor,
                width: 24.sp,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/navigation_icon/svg/quran_nfill.svg',
                width: 24.sp,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
              ),
              label: l10n.navQuran,
              activeIcon: SvgPicture.asset(
                'assets/images/navigation_icon/svg/quran_nfill.svg',
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor,
                width: 24.sp,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/navigation_icon/svg/bookmark_nfill.svg',
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
                width: 24.sp,
              ),
              label: l10n.navBookmark,
              activeIcon: SvgPicture.asset(
                'assets/images/navigation_icon/svg/bookmark_nfill.svg',
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor,
                width: 24.sp,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/navigation_icon/svg/setting_nfill.svg',
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
                width: 24.sp,
              ),
              label: l10n.navSetting,
              activeIcon: SvgPicture.asset(
                'assets/images/navigation_icon/svg/setting_nfill.svg',
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor,
                width: 24.sp,
              ),
            ),
          ],
        );
      },
    );
  }
}
