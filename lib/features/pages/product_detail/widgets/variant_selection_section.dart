import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';
import 'package:happyco/domain/entities/product_detail_entity.dart';
import 'package:happyco/domain/entities/variant_config_entity.dart';

class VariantSelectionSection extends StatelessWidget {
  final ProductDetailEntity product;
  final Map<String, String> selectedAttributes;
  final int quantity;
  final int maxQuantity;
  final Function(String key, String value) onAttributeSelected;
  final Function(int quantity) onQuantityChanged;

  const VariantSelectionSection({
    super.key,
    required this.product,
    required this.selectedAttributes,
    required this.quantity,
    required this.maxQuantity,
    required this.onAttributeSelected,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: UISizes.width.w16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...product.variantConfigs
              .map((config) => _buildAttributeGroup(config)),
          SizedBox(height: UISizes.height.h16),
          _buildQuantityStepper(),
        ],
      ),
    );
  }

  Widget _buildAttributeGroup(VariantConfigEntity config) {
    final values = product.uniqueValuesForKey(config.key);
    if (values.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIText(
          title: config.label,
          titleSize: UISizes.font.sp14,
          fontWeight: FontWeight.w600,
          titleColor: UIColors.gray700,
        ),
        SizedBox(height: UISizes.height.h8),
        Wrap(
          spacing: UISizes.width.w8,
          runSpacing: UISizes.height.h8,
          children: values.map((value) {
            final isSelected = selectedAttributes[config.key] == value;
            return GestureDetector(
              onTap: () => onAttributeSelected(config.key, value),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: UISizes.width.w16,
                  vertical: UISizes.height.h8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? UIColors.primary : UIColors.white,
                  borderRadius: BorderRadius.circular(UISizes.square.r8),
                  border: Border.all(
                    color: isSelected ? UIColors.primary : UIColors.gray200,
                    width: UISizes.square.r1,
                  ),
                ),
                child: UIText(
                  title: value,
                  titleSize: UISizes.font.sp12,
                  titleColor: isSelected ? UIColors.white : UIColors.gray700,
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: UISizes.height.h16),
      ],
    );
  }

  Widget _buildQuantityStepper() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIText(
          title: 'Số lượng',
          titleSize: UISizes.font.sp14,
          fontWeight: FontWeight.w600,
          titleColor: UIColors.gray700,
        ),
        SizedBox(height: UISizes.height.h8),
        Row(
          children: [
            _buildStepperButton(
              icon: Icons.remove,
              onTap:
                  quantity > 1 ? () => onQuantityChanged(quantity - 1) : null,
              isEnabled: quantity > 1,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: UISizes.width.w48),
              child: Container(
                height: UISizes.width.w32,
                alignment: Alignment.center,
                child: UIText(
                  title: quantity.toString(),
                  titleSize: UISizes.font.sp14,
                  fontWeight: FontWeight.bold,
                  titleColor: UIColors.gray900,
                ),
              ),
            ),
            _buildStepperButton(
              icon: Icons.add,
              onTap: quantity < maxQuantity
                  ? () => onQuantityChanged(quantity + 1)
                  : null,
              isEnabled: quantity < maxQuantity,
            ),
            if (maxQuantity > 0) ...[
              SizedBox(width: UISizes.width.w12),
              UIText(
                title: 'Kho: $maxQuantity',
                titleSize: UISizes.font.sp12,
                titleColor: UIColors.gray500,
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildStepperButton({
    required IconData icon,
    VoidCallback? onTap,
    required bool isEnabled,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          color: isEnabled
              ? UIColors.primary
              : UIColors.primary.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(UISizes.square.r8),
        ),
        child: Icon(
          icon,
          size: UISizes.width.w16,
          color: UIColors.white,
        ),
      ),
    );
  }
}
