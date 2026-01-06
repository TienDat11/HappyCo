import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

/// Standardized Text Input Widget
class UITextInput extends StatefulWidget {
  /// Input label text
  final String? label;

  /// Placeholder text
  final String? placeholder;

  /// Current text value
  final String? value;

  /// Callback when text changes
  final ValueChanged<String>? onChanged;

  /// Callback when text is submitted
  final ValueChanged<String>? onSubmitted;

  /// Whether field is required (shows asterisk)
  final bool isRequired;

  /// Whether field is enabled
  final bool isEnabled;

  /// Text input type
  final TextInputType? keyboardType;

  /// Input formatter (e.g., phone number, numeric)
  final List<TextInputFormatter>? inputFormatters;

  /// Max lines (1 = single line)
  final int? maxLines;

  /// Max character count
  final int? maxLength;

  /// Obscure text (for passwords)
  final bool obscureText;

  /// Show/hide password toggle
  final bool showPasswordToggle;

  /// Prefix icon
  final IconData? prefixIcon;

  /// Suffix icon (widget)
  final Widget? suffixIcon;

  /// Error message to display
  final String? errorMessage;

  /// Helper text below input
  final String? helperText;

  /// Readonly state
  final bool readOnly;

  /// Focus node
  final FocusNode? focusNode;

  /// Text align
  final TextAlign textAlign;

  /// External controller (optional - if not provided, internal one is used)
  final TextEditingController? controller;

  const UITextInput({
    super.key,
    this.label,
    this.placeholder,
    this.value,
    this.onChanged,
    this.onSubmitted,
    this.isRequired = false,
    this.isEnabled = true,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
    this.maxLength,
    this.obscureText = false,
    this.showPasswordToggle = false,
    this.prefixIcon,
    this.suffixIcon,
    this.errorMessage,
    this.helperText,
    this.readOnly = false,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.controller,
  });

  @override
  State<UITextInput> createState() => _UITextInputState();
}

class _UITextInputState extends State<UITextInput> {
  late bool _obscureText;
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _ownsController = false;
  bool _ownsFocusNode = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;

    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = TextEditingController(text: widget.value ?? '');
      _ownsController = true;
    }

    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    } else {
      _focusNode = FocusNode();
      _ownsFocusNode = true;
    }

    // Listen to focus changes for border color
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(UITextInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update text if value prop changed and we own the controller
    if (_ownsController && widget.value != oldWidget.value) {
      final newValue = widget.value ?? '';
      if (_controller.text != newValue) {
        _controller.text = newValue;
        _controller.selection = TextSelection.collapsed(
          offset: newValue.length,
        );
      }
    }

    if (widget.controller != oldWidget.controller) {
      if (_ownsController) {
        _controller.dispose();
      }
      if (widget.controller != null) {
        _controller = widget.controller!;
        _ownsController = false;
      } else {
        _controller = TextEditingController(text: widget.value ?? '');
        _ownsController = true;
      }
    }

    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_onFocusChange);
      if (_ownsFocusNode) {
        _focusNode.dispose();
      }
      if (widget.focusNode != null) {
        _focusNode = widget.focusNode!;
        _ownsFocusNode = false;
      } else {
        _focusNode = FocusNode();
        _ownsFocusNode = true;
      }
      _focusNode.addListener(_onFocusChange);
    }
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (_ownsController) {
      _controller.dispose();
    }
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorMessage?.isNotEmpty == true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null)
          Row(
            children: [
              UIText(
                title: widget.label!,
                titleSize: UISizes.font.sp14,
                titleColor: UIColors.gray500,
              ),
              if (widget.isRequired) ...[
                SizedBox(width: UISizes.width.w4),
                UIText(
                  title: '*',
                  titleSize: UISizes.font.sp16,
                  titleColor: UIColors.red500,
                ),
              ],
            ],
          ),
        if (widget.label != null) SizedBox(height: UISizes.height.h8),

        Container(
          height: UISizes.height.h48,
          decoration: BoxDecoration(
            color: widget.isEnabled ? UIColors.white : UIColors.gray100,
            borderRadius: BorderRadius.circular(UISizes.square.r12),
            border: Border.all(
              color: hasError
                  ? UIColors.red500
                  : (_focusNode.hasFocus
                      ? const Color(0xFF236E45) // Primary Green
                      : UIColors.gray200),
              width: 1,
            ),
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            enabled: widget.isEnabled,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            obscureText: _obscureText,
            readOnly: widget.readOnly,
            textAlign: widget.textAlign,
            style: TextStyle(
              fontSize: UISizes.font.sp14,
              fontWeight: FontWeight.w500,
              color: UIColors.gray700,
            ),
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: TextStyle(
                fontSize: UISizes.font.sp14,
                fontWeight: FontWeight.w500,
                color: UIColors.gray300,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      size: UISizes.width.w20,
                      color: UIColors.gray400,
                    )
                  : null,
              suffixIcon: _buildSuffixIcon(),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: UISizes.width.w16,
              ),
              counterText: '', // Hide character counter
            ),
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
          ),
        ),

        if (hasError)
          Padding(
            padding: EdgeInsets.only(
              top: UISizes.height.h4,
              left: UISizes.width.w16,
            ),
            child: UIText(
              title: widget.errorMessage!,
              titleSize: UISizes.font.sp12,
              titleColor: UIColors.red500,
            ),
          ),

        if (widget.helperText != null && !hasError)
          Padding(
            padding: EdgeInsets.only(
              top: UISizes.height.h4,
              left: UISizes.width.w16,
            ),
            child: UIText(
              title: widget.helperText!,
              titleSize: UISizes.font.sp12,
              titleColor: UIColors.gray500,
            ),
          ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.showPasswordToggle) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        child: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          size: UISizes.width.w24,
          color: UIColors.gray500,
        ),
      );
    }
    return widget.suffixIcon;
  }
}
