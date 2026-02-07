import 'package:flutter/material.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

/// Toggle Switch Widget for Auth Forms
///
/// Specifications from Figma Auth Dialogs:
/// - ON state: Background #C0333C (primary), circle on right
/// - OFF state: Background #E4E4E7 (gray200), circle on left
/// - Dimensions: 36px width × 20px height
/// - Border radius: 100px (pill shape)
class ToggleSwitch extends StatefulWidget {
  /// Whether the toggle is on
  final bool value;

  /// Callback when toggle changes
  final ValueChanged<bool> onChanged;

  /// Optional label text displayed next to toggle
  final String? label;

  /// Whether the toggle is disabled
  final bool isEnabled;

  const ToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.isEnabled = true,
  });

  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Set initial position
    if (widget.value) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(ToggleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.isEnabled) {
      widget.onChanged(!widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: UISizes.width.w36,
                height: UISizes.height.h20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(UISizes.square.r100),
                  color: widget.value ? UIColors.primary : UIColors.gray200,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: UISizes.height.h2,
                      top: UISizes.height.h2,
                      bottom: UISizes.width.w2,
                      width: UISizes.width.w16,
                      child: Transform.translate(
                        offset: Offset(
                          _animation.value *
                              (UISizes.width.w36 -
                                  UISizes.width.w18 -
                                  UISizes.width.w4),
                          0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: UIColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          if (widget.label != null) ...[
            SizedBox(width: UISizes.width.w8),
            UIText(
              title: widget.label!,
              titleSize: UISizes.font.sp14,
              titleColor: UIColors.gray500,
            ),
          ],
        ],
      ),
    );
  }
}
