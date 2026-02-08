import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happyco/core/theme/ui_theme.dart';
import 'package:happyco/core/ui/widgets/labels/ui_text.dart';

class UITextInput extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final String? value;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool isRequired;
  final bool isEnabled;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? maxLength;
  final bool obscureText;
  final bool showPasswordToggle;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? errorMessage;
  final String? helperText;
  final bool readOnly;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final TextEditingController? controller;
  final String? semanticLabel;

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
    this.semanticLabel,
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
    _initializeController();
    _initializeFocusNode();
  }

  void _initializeController() {
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = TextEditingController(text: widget.value ?? '');
      _ownsController = true;
    }
  }

  void _initializeFocusNode() {
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    } else {
      _focusNode = FocusNode();
      _ownsFocusNode = true;
    }
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(UITextInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_ownsController && widget.value != oldWidget.value) {
      _updateControllerValue(widget.value ?? '');
    }

    if (widget.controller != oldWidget.controller) {
      _handleControllerUpdate(widget.controller);
    }

    if (widget.focusNode != oldWidget.focusNode) {
      _handleFocusNodeUpdate(widget.focusNode);
    }
  }

  void _updateControllerValue(String newValue) {
    if (_controller.text != newValue) {
      _controller.text = newValue;
      _controller.selection = TextSelection.collapsed(offset: newValue.length);
    }
  }

  void _handleControllerUpdate(TextEditingController? newController) {
    if (_ownsController) _controller.dispose();
    if (newController != null) {
      _controller = newController;
      _ownsController = false;
    } else {
      _controller = TextEditingController(text: widget.value ?? '');
      _ownsController = true;
    }
  }

  void _handleFocusNodeUpdate(FocusNode? newFocusNode) {
    _focusNode.removeListener(_handleFocusChange);
    if (_ownsFocusNode) _focusNode.dispose();

    if (newFocusNode != null) {
      _focusNode = newFocusNode;
      _ownsFocusNode = false;
    } else {
      _focusNode = FocusNode();
      _ownsFocusNode = true;
    }
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() => setState(() {});

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (_ownsController) _controller.dispose();
    if (_ownsFocusNode) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasError = widget.errorMessage?.isNotEmpty == true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) _buildLabel(),
        if (widget.label != null) SizedBox(height: UISizes.height.h8),
        _buildInputContainer(hasError),
        if (hasError) _buildErrorMessage(),
        if (widget.helperText != null && !hasError) _buildHelperText(),
      ],
    );
  }

  Widget _buildLabel() {
    return Row(
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
    );
  }

  Widget _buildInputContainer(bool hasError) {
    return Container(
      height: UISizes.height.h48,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: widget.isEnabled ? UIColors.white : UIColors.gray100,
        borderRadius: BorderRadius.circular(UISizes.square.r12),
        border: Border.all(
          color: _getBorderColor(hasError),
          width: 1,
        ),
      ),
      child: Semantics(
        label: widget.semanticLabel,
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
          textAlignVertical: TextAlignVertical.center,
          textAlign: widget.textAlign,
          style: TextStyle(
            fontSize: UISizes.font.sp14,
            fontWeight: FontWeight.w500,
            color: UIColors.gray700,
          ),
          decoration: InputDecoration(
            isDense: true,
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
              vertical: UISizes.height.h14,
            ),
            counterText: '',
          ),
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
        ),
      ),
    );
  }

  Color _getBorderColor(bool hasError) {
    if (hasError) return UIColors.red500;
    if (_focusNode.hasFocus) return UIColors.primaryGreen;
    return UIColors.gray200;
  }

  Widget _buildErrorMessage() {
    return Padding(
      padding: EdgeInsets.only(
        top: UISizes.height.h4,
        left: UISizes.width.w16,
      ),
      child: UIText(
        title: widget.errorMessage!,
        titleSize: UISizes.font.sp12,
        titleColor: UIColors.red500,
      ),
    );
  }

  Widget _buildHelperText() {
    return Padding(
      padding: EdgeInsets.only(
        top: UISizes.height.h4,
        left: UISizes.width.w16,
      ),
      child: UIText(
        title: widget.helperText!,
        titleSize: UISizes.font.sp12,
        titleColor: UIColors.gray500,
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.showPasswordToggle) {
      return GestureDetector(
        onTap: () => setState(() => _obscureText = !_obscureText),
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
