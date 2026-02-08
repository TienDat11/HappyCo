import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:happyco/core/theme/ui_colors.dart';
import 'package:happyco/core/theme/ui_sizes.dart';
import 'package:happyco/core/theme/ui_svgs.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/core/ui/widgets/shimmer/happy_shimmer.dart';
import 'package:happyco/features/app_router.gr.dart';
import 'package:happyco/features/pages/notification/bloc/notification_page_bloc.dart';
import 'package:happyco/features/pages/notification/widget/notification_item_shimmer.dart';
import 'package:happyco/features/pages/notification/widget/notification_item_widget.dart';
import 'package:happyco/core/ui/widgets/layouts/main_appbar.dart';

@RoutePage()
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          GetIt.I<NotificationPageBloc>()..add(OnNotificationInitialize()),
      child: const _NotificationPageContent(),
    );
  }
}

class _NotificationPageContent extends StatelessWidget {
  const _NotificationPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.background,
      body: Column(
        children: [
          const MainAppbar(title: 'Thông báo'),
          Expanded(
            child: BlocBuilder<NotificationPageBloc, NotificationPageState>(
              builder: (context, state) {
                if (state is NotificationLoading) {
                  debugPrint('🔥 LOADING STATE');
                  return _buildLoadingState();
                }

                if (state is NotificationError) {
                  return _buildErrorState(context, state.error);
                }

                if (state is NotificationLoaded) {
                  return _buildLoadedState(context, state);
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: UISizes.height.h16),
            _buildHeaderShimmer(),
            SizedBox(height: UISizes.height.h16),
            _buildNotificationListShimmer(),
            SizedBox(height: UISizes.height.h24),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: UISizes.width.w48,
            color: UIColors.gray400,
          ),
          SizedBox(height: UISizes.height.h16),
          Text(
            'Đã có lỗi xảy ra',
            style: TextStyle(
              fontSize: UISizes.font.sp16,
              color: UIColors.gray600,
            ),
          ),
          SizedBox(height: UISizes.height.h8),
          Text(
            error,
            style: TextStyle(
              fontSize: UISizes.font.sp14,
              color: UIColors.gray400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: UISizes.height.h24),
          ElevatedButton(
            onPressed: () {
              context.read<NotificationPageBloc>().add(OnNotificationRefresh());
            },
            child: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(
    BuildContext context,
    NotificationLoaded state,
  ) {
    if (state.notifications.isEmpty) {
      return _buildEmptyState();
    }

    final unreadCount = state.notifications.where((e) => !e.isRead).length;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<NotificationPageBloc>().add(OnNotificationRefresh());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: UISizes.height.h16),
              _buildHeader(unreadCount: unreadCount),
              SizedBox(height: UISizes.height.h16),
              NotificationItemWidget(
                items: state.notifications,
                onTap: (notification) {
                  context.router.push(
                    NotificationDetailRoute(id: notification.id),
                  );
                },
              ),
              SizedBox(height: UISizes.height.h32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader({required int unreadCount}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UIText(
            title: '$unreadCount thông báo mới',
            titleSize: UISizes.font.sp14,
            fontWeight: FontWeight.w400,
            titleColor: UIColors.gray500,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              UIText(
                title: 'Đánh dấu đã đọc',
                titleSize: UISizes.font.sp14,
                fontWeight: FontWeight.w400,
                titleColor: UIColors.primary,
              ),
              SizedBox(width: UISizes.width.w4),
              Icon(
                Icons.done_all_rounded,
                size: UISizes.font.sp24,
                color: UIColors.primary,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: UISizes.height.h64),
          SvgPicture.asset(
            UISvgs.notiEmptySvg,
            width: UISizes.width.w112,
            height: UISizes.height.h120,
          ),
          SizedBox(height: UISizes.height.h24),
          UIText(
            title: 'Chưa có thông báo nào!',
            titleSize: UISizes.font.sp16,
            fontWeight: FontWeight.w600,
            titleColor: UIColors.red600,
          ),
          SizedBox(height: UISizes.height.h8),
          UIText(
            title: 'Hiện tại chưa có thông báo nào!',
            titleSize: UISizes.font.sp14,
            titleColor: UIColors.gray500,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationListShimmer() {
    return Column(
      children: List.generate(
        6,
        (_) => const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: NotificationItemShimmer(),
        ),
      ),
    );
  }

  Widget _buildHeaderShimmer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left text shimmer
        HappyShimmer.rounded(
          width: UISizes.width.w140,
          height: UISizes.height.h16,
          borderRadius: UISizes.square.r6,
        ),

        // Right action shimmer
        Row(
          children: [
            HappyShimmer.rounded(
              width: UISizes.width.w90,
              height: UISizes.height.h16,
              borderRadius: UISizes.square.r6,
            ),
            SizedBox(width: UISizes.width.w8),
            HappyShimmer.circular(
              size: UISizes.font.sp24,
            ),
          ],
        ),
      ],
    );
  }
}
