import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:happyco/core/config/app_constants.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/cards/ui_card.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/core/ui/widgets/shimmer/happy_shimmer.dart';
import 'package:happyco/domain/entities/news_entity.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/features/pages/news/bloc/news_bloc.dart';
import 'package:happyco/core/ui/widgets/filters/filter_tabs.dart';
import 'package:happyco/features/home/widgets/home_header.dart';
import 'package:happyco/features/news/widgets/compact_news_card.dart';
import 'package:happyco/features/news/widgets/news_card.dart';
import 'package:happyco/features/news/widgets/product_compact_card.dart';
import 'package:happyco/features/news/widgets/video_card.dart';
import 'package:happyco/core/ui/widgets/layouts/section_header.dart';

/// News screen displaying articles, Q&A, products, and videos.
///
/// Based on Figma design node-id=1:2452.
@RoutePage()
class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<NewsBloc>()..add(OnNewsInitialize()),
      child: Builder(
        builder: (context) => _NewsPageContent(),
      ),
    );
  }
}

class _NewsPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return _buildLoadingState();
        }

        if (state is NewsError) {
          return _buildErrorState(context, state.message);
        }

        if (state is NewsLoaded) {
          return _buildLoadedState(context, state);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoadingState() {
    return Scaffold(
      backgroundColor: UIColors.background,
      body: Column(
        children: [
          const HomeHeader(),
          SizedBox(height: UISizes.height.h8),
          _buildFilterTabsShimmer(),
          SizedBox(height: UISizes.height.h16),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: UISizes.width.w16,
                  right: UISizes.width.w16,
                  bottom: UISizes.height.h80,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPromotionsShimmer(),
                    SizedBox(height: UISizes.height.h24),
                    _buildBannerShimmer(),
                    SizedBox(height: UISizes.height.h24),
                    _buildQASectionShimmer(),
                    SizedBox(height: UISizes.height.h24),
                    _buildLatestNewsSectionShimmer(),
                    SizedBox(height: UISizes.height.h24),
                    _buildFeaturedProductsSectionShimmer(),
                    SizedBox(height: UISizes.height.h24),
                    _buildVideosSectionShimmer(),
                    SizedBox(height: UISizes.height.h24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabsShimmer() {
    return SizedBox(
      height: UISizes.height.h40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index == 4 ? 0 : UISizes.width.w12,
            ),
            child: HappyShimmer.rounded(
              width: index == 0
                  ? UISizes.width.w150
                  : (index == 1 ? UISizes.width.w124 : UISizes.width.w161),
              height: UISizes.height.h40,
              borderRadius: UISizes.square.r12,
            ),
          );
        },
      ),
    );
  }

  Widget _buildPromotionsShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(3, (index) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: index == 2 ? 0 : UISizes.height.h12,
          ),
          child: Column(
            children: [
              HappyShimmer.rounded(
                width: double.infinity,
                height: UISizes.height.h160,
                borderRadius: UISizes.square.r12,
              ),
              SizedBox(height: UISizes.height.h8),
              HappyShimmer.rounded(
                width: double.infinity,
                height: UISizes.height.h40,
                borderRadius: 0,
              ),
              SizedBox(height: UISizes.height.h4),
              HappyShimmer.rounded(
                width: double.infinity,
                height: UISizes.height.h20,
                borderRadius: 0,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildBannerShimmer() {
    return HappyShimmer.rounded(
      width: double.infinity,
      height: UISizes.height.h133,
      borderRadius: UISizes.square.r12,
    );
  }

  Widget _buildQASectionShimmer() {
    return UICard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HappyShimmer.rounded(
                width: UISizes.width.w150,
                height: UISizes.height.h24,
                borderRadius: 0,
              ),
              HappyShimmer.rounded(
                width: UISizes.width.w60,
                height: UISizes.height.h20,
                borderRadius: 0,
              ),
            ],
          ),
          SizedBox(height: UISizes.height.h12),
          ...List.generate(3, (index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == 2 ? 0 : UISizes.height.h12,
              ),
              child: Row(
                children: [
                  HappyShimmer.rounded(
                    width: UISizes.width.w80,
                    height: UISizes.height.h56,
                    borderRadius: UISizes.square.r4,
                  ),
                  SizedBox(width: UISizes.width.w12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HappyShimmer.rounded(
                          width: UISizes.width.w200,
                          height: UISizes.height.h22,
                          borderRadius: 0,
                        ),
                        SizedBox(height: UISizes.height.h8),
                        HappyShimmer.rounded(
                          width: UISizes.width.w150,
                          height: UISizes.height.h20,
                          borderRadius: 0,
                        ),
                        SizedBox(height: UISizes.height.h8),
                        HappyShimmer.rounded(
                          width: UISizes.width.w60,
                          height: UISizes.height.h20,
                          borderRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLatestNewsSectionShimmer() {
    return UICard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HappyShimmer.rounded(
                width: UISizes.width.w150,
                height: UISizes.height.h24,
                borderRadius: 0,
              ),
              HappyShimmer.rounded(
                width: UISizes.width.w60,
                height: UISizes.height.h20,
                borderRadius: 0,
              ),
            ],
          ),
          SizedBox(height: UISizes.height.h12),
          ...List.generate(3, (index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == 2 ? 0 : UISizes.height.h12,
              ),
              child: Row(
                children: [
                  HappyShimmer.rounded(
                    width: UISizes.width.w80,
                    height: UISizes.height.h56,
                    borderRadius: UISizes.square.r4,
                  ),
                  SizedBox(width: UISizes.width.w12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HappyShimmer.rounded(
                          width: UISizes.width.w200,
                          height: UISizes.height.h22,
                          borderRadius: 0,
                        ),
                        SizedBox(height: UISizes.height.h8),
                        HappyShimmer.rounded(
                          width: UISizes.width.w150,
                          height: UISizes.height.h20,
                          borderRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFeaturedProductsSectionShimmer() {
    return UICard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HappyShimmer.rounded(
                width: UISizes.width.w150,
                height: UISizes.height.h24,
                borderRadius: 0,
              ),
              HappyShimmer.rounded(
                width: UISizes.width.w60,
                height: UISizes.height.h20,
                borderRadius: 0,
              ),
            ],
          ),
          SizedBox(height: UISizes.height.h12),
          ...List.generate(3, (index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == 2 ? 0 : UISizes.height.h12,
              ),
              child: Row(
                children: [
                  HappyShimmer.rounded(
                    width: UISizes.width.w80,
                    height: UISizes.height.h56,
                    borderRadius: UISizes.square.r4,
                  ),
                  SizedBox(width: UISizes.width.w12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HappyShimmer.rounded(
                          width: UISizes.width.w200,
                          height: UISizes.height.h22,
                          borderRadius: 0,
                        ),
                        SizedBox(height: UISizes.height.h4),
                        Row(
                          children: [
                            HappyShimmer.rounded(
                              width: UISizes.width.w100,
                              height: UISizes.height.h22,
                              borderRadius: 0,
                            ),
                            SizedBox(width: UISizes.width.w8),
                            HappyShimmer.rounded(
                              width: UISizes.width.w80,
                              height: UISizes.height.h22,
                              borderRadius: 0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildVideosSectionShimmer() {
    return UICard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HappyShimmer.rounded(
                width: UISizes.width.w150,
                height: UISizes.height.h24,
                borderRadius: 0,
              ),
              HappyShimmer.rounded(
                width: UISizes.width.w60,
                height: UISizes.height.h20,
                borderRadius: 0,
              ),
            ],
          ),
          SizedBox(height: UISizes.height.h12),
          ...List.generate(3, (index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == 2 ? 0 : UISizes.height.h12,
              ),
              child: HappyShimmer.rounded(
                width: double.infinity,
                height: UISizes.height.h120,
                borderRadius: UISizes.square.r8,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: UISizes.width.w48,
            color: UIColors.gray400,
          ),
          SizedBox(height: UISizes.height.h16),
          UIText(
            title: AppErrorMessages.genericError,
            titleSize: UISizes.font.sp16,
            titleColor: UIColors.gray600,
          ),
          SizedBox(height: UISizes.height.h8),
          UIText(
            title: message,
            titleSize: UISizes.font.sp14,
            titleColor: UIColors.gray500,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, NewsLoaded state) {
    return Scaffold(
      backgroundColor: UIColors.background,
      body: Column(
        children: [
          const HomeHeader(),
          SizedBox(height: UISizes.height.h8),
          FilterTabs(
            selectedCategory: state.selectedCategory,
            onCategorySelected: (category) {
              context.read<NewsBloc>().add(OnNewsFilterChange(category));
            },
          ),
          SizedBox(height: UISizes.height.h16),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: UISizes.width.w16,
                  right: UISizes.width.w16,
                  bottom: UISizes.height.h80,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPromotionsSection(state.newsByCategory),
                    SizedBox(height: UISizes.height.h24),
                    _buildBannerSection(state.banner),
                    SizedBox(height: UISizes.height.h24),
                    _buildQASection(state.qaList),
                    SizedBox(height: UISizes.height.h24),
                    _buildLatestNewsSection(state.latestNews),
                    SizedBox(height: UISizes.height.h24),
                    _buildFeaturedProductsSection(state.featuredProducts),
                    SizedBox(height: UISizes.height.h24),
                    _buildRelatedVideosSection(state.relatedVideos),
                    SizedBox(height: UISizes.height.h24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionsSection(List<NewsEntity> news) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: news.map((article) => NewsCard(news: article)).toList(),
    );
  }

  Widget _buildBannerSection(NewsEntity? banner) {
    if (banner == null) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(UISizes.square.r12),
      child: Image.network(
        banner.imageUrl,
        height: UISizes.height.h133,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: UISizes.height.h133,
            width: double.infinity,
            color: UIColors.gray200,
            child: Icon(
              Icons.error_outline,
              size: UISizes.width.w48,
              color: UIColors.gray400,
            ),
          );
        },
      ),
    );
  }

  Widget _buildLatestNewsSection(List<NewsEntity> news) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: AppSectionTitles.latestNews,
          actionText: AppActionTexts.viewAll,
        ),
        SizedBox(height: UISizes.height.h12),
        ...news.take(3).map((article) => CompactNewsCard(news: article)),
      ],
    );
  }

  Widget _buildQASection(List<NewsEntity> qaList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: AppSectionTitles.qAndA,
          actionText: AppActionTexts.viewAll,
        ),
        SizedBox(height: UISizes.height.h12),
        ...qaList.take(3).map((qa) => CompactNewsCard(news: qa)),
      ],
    );
  }

  Widget _buildFeaturedProductsSection(List<ProductEntity> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: AppSectionTitles.featuredProducts,
          actionText: AppActionTexts.viewAll,
        ),
        SizedBox(height: UISizes.height.h12),
        ...products
            .take(3)
            .map((product) => ProductCompactCard(product: product)),
      ],
    );
  }

  Widget _buildRelatedVideosSection(List<NewsEntity> videos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: AppSectionTitles.relatedVideos,
          actionText: AppActionTexts.viewAll,
        ),
        SizedBox(height: UISizes.height.h12),
        ...videos.map((video) => VideoCard(video: video)),
      ],
    );
  }
}
