import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:happyco/core/theme/ui_colors.dart';
import 'package:happyco/core/theme/ui_sizes.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/core/ui/widgets/layouts/main_appbar.dart';
import 'package:happyco/core/utils/extensions/date_extensions.dart';
import 'package:happyco/features/pages/notification-detail/bloc/notification_detail_bloc.dart';

@RoutePage()
class NotificationDetailPage extends StatelessWidget {
  final String id;
  const NotificationDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<NotificationDetailBloc>()
        ..add(OnNotificationDetailInitialize(id: id)),
      child: const _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatelessWidget {
  const _HomePageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.background,
      body: Column(
        children: [
          const MainAppbar(title: 'Chi tiết thông báo'),
          Expanded(
            child: BlocBuilder<NotificationDetailBloc, NotificationDetailState>(
              builder: (context, state) {
                if (state is NotificationDetailLoading) {
                  return _buildLoadingState();
                }

                if (state is NotificationDetailError) {
                  return _buildErrorState(context, state.error);
                }

                if (state is NotificationDetailLoaded) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: UISizes.height.h16),
        ],
      ),
    );
  }

  /// Displays error state with retry button
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
              context
                  .read<NotificationDetailBloc>()
                  .add(OnNotificationDetailRefresh(id: ''));
            },
            child: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(
    BuildContext context,
    NotificationDetailLoaded state,
  ) {
    final item = state.notificationDetail;

    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<NotificationDetailBloc>()
            .add(OnNotificationDetailRefresh(id: item.id));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: UISizes.height.h16),
              ClipRRect(
                borderRadius: BorderRadius.circular(UISizes.square.r12),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: UIColors.gray200),
                  ),
                ),
              ),
              SizedBox(height: UISizes.height.h16),
              UIText(
                title: item.title,
                titleSize: UISizes.font.sp16,
                fontWeight: FontWeight.w600,
                titleColor: UIColors.gray700,
                maxLines: 2,
              ),
              SizedBox(height: UISizes.height.h8),
              UIText(
                title: item.createdAt.toVietnameseAmPmDateTimeFormat(),
                titleSize: UISizes.font.sp14,
                titleColor: UIColors.gray500,
              ),
              SizedBox(height: UISizes.height.h16),
              UIText(
                title: item.description,
                titleSize: UISizes.font.sp14,
                titleColor: UIColors.gray500,
                lineHeight: 1.6,
              ),
              SizedBox(height: UISizes.height.h32),
            ],
          ),
        ),
      ),
    );
  }
}
