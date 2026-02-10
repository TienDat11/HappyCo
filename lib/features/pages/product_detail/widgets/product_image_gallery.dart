import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyco/core/theme/ui_theme.dart';

class ProductImageGallery extends StatefulWidget {
  final List<String> imageUrls;

  const ProductImageGallery({
    super.key,
    required this.imageUrls,
  });

  @override
  State<ProductImageGallery> createState() => _ProductImageGalleryState();
}

class _ProductImageGalleryState extends State<ProductImageGallery> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onThumbnailTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return Container(
        height: 280.h,
        color: UIColors.gray100,
        child: Icon(
          Icons.image_outlined,
          size: 48.w,
          color: UIColors.gray300,
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 280.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index) {
              return Image.network(
                widget.imageUrls[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: UIColors.gray100,
                    child: Icon(
                      Icons.image_outlined,
                      size: 48.w,
                      color: UIColors.gray300,
                    ),
                  );
                },
              );
            },
          ),
        ),
        SizedBox(height: UISizes.height.h16),
        if (widget.imageUrls.length > 1)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.imageUrls.length, (index) {
                final isSelected = _currentIndex == index;
                return GestureDetector(
                  onTap: () => _onThumbnailTap(index),
                  child: Container(
                    margin: EdgeInsets.only(
                        right: index == widget.imageUrls.length - 1 ? 0 : 8.w),
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(
                        color: isSelected ? UIColors.primary : UIColors.gray200,
                        width: isSelected ? 2.w : 1.w,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3.r),
                      child: Image.network(
                        widget.imageUrls[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: UIColors.gray100,
                            child: Icon(
                              Icons.image_outlined,
                              size: 16.w,
                              color: UIColors.gray300,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}
