import 'package:flutter/material.dart';
import 'package:happyco/core/services/html_rendering_service.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

/// Product Description Section
///
/// Renders the product's HTML description with expand/collapse functionality.
/// Uses [HtmlRenderingService] to decouple HTML parsing from the UI layer,
/// allowing the rendering engine to be swapped without touching this widget.
class ProductDescriptionSection extends StatefulWidget {
  final String? description;
  final HtmlRenderingService htmlRenderingService;

  const ProductDescriptionSection({
    super.key,
    required this.description,
    required this.htmlRenderingService,
  });

  @override
  State<ProductDescriptionSection> createState() =>
      _ProductDescriptionSectionState();
}

class _ProductDescriptionSectionState extends State<ProductDescriptionSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final description = widget.description;
    if (description == null || description.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIText(
            title: 'Mô tả sản phẩm',
            titleSize: UISizes.font.sp16,
            fontWeight: FontWeight.w600,
            titleColor: UIColors.gray900,
          ),
          SizedBox(height: UISizes.height.h12),
          widget.htmlRenderingService.renderHtml(
            description,
            isExpanded: _isExpanded,
          ),
          SizedBox(height: UISizes.height.h8),
          _buildToggleButton(),
        ],
      ),
    );
  }

  Widget _buildToggleButton() {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          UIText(
            title: _isExpanded ? 'Thu gọn' : 'Xem thêm',
            titleSize: UISizes.font.sp14,
            fontWeight: FontWeight.w600,
            titleColor: UIColors.primary,
          ),
          SizedBox(width: UISizes.width.w4),
          Icon(
            _isExpanded
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            size: UISizes.width.w20,
            color: UIColors.primary,
          ),
        ],
      ),
    );
  }
}
