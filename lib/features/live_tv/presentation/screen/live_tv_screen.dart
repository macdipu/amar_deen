import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:amar_deen/l10n/generated/app_localizations.dart';

import 'package:amar_deen/core/constants/constants.dart';
import 'package:amar_deen/core/error/widgets/failure_widget.dart';
import 'package:amar_deen/core/widgets/loading_widget.dart';
import '../bloc/live_tv_bloc/live_tv_bloc.dart';
import 'live_tv_player_screen.dart';

class LiveTvScreen extends StatelessWidget {
  const LiveTvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LiveTvBloc()..add(const FetchLiveTvChannels()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).homeCollectionLiveTv),
        ),
        body: SafeArea(
          child: Padding(
            padding: kPagePadding,
            child: BlocBuilder<LiveTvBloc, LiveTvState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const LoadingWidget();
                }
                if (state.failure != null) {
                  return FailureWidget(
                    state.failure!,
                    () {
                      BlocProvider.of<LiveTvBloc>(context)
                          .add(const FetchLiveTvChannels());
                    },
                    withAppbar: true,
                  );
                }

                return AlignedGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  itemCount: state.channels.length,
                  itemBuilder: (context, index) {
                    final channel = state.channels[index];
                    return _ChannelCard(
                      title: channel.name,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                LiveTvPlayerScreen(channel: channel),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ChannelCard extends StatelessWidget {
  const _ChannelCard({
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cardRadius = kCardBorderRadius.resolve(Directionality.of(context));
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: cardRadius,
      child: InkWell(
        borderRadius: cardRadius,
        onTap: onTap,
        child: SizedBox(
          height: 170.h,
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 46.w,
                  height: 46.w,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).primaryColor.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(
                    Icons.live_tv,
                    color: Theme.of(context).primaryColor,
                    size: 26.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.play_circle_fill,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      AppLocalizations.of(context).liveTvWatch,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
