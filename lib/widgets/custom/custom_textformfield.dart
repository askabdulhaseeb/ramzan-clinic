import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utilities/utilities.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    required TextEditingController? controller,
    this.textCapitalization,
    this.padding,
    this.onFieldSubmitted,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.validator,
    this.initialValue,
    this.hint = '',
    this.label,
    this.color,
    this.contentPadding,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.sufficIcon,
    this.showSuffixIcon = true,
    this.readOnly = false,
    this.autoFocus = false,
    this.textAlign = TextAlign.start,
    this.style,
    this.border,
    this.starticon,
    this.borderColor,
    Key? key,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController? _controller;
  final EdgeInsetsGeometry? padding;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final void Function(String)? onChanged;
  final Widget? sufficIcon;
  final bool showSuffixIcon;
  final String? Function(String? value)? validator;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final Color? color;
  final String? initialValue;
  final String? hint;
  final String? label;
  final bool readOnly;
  final bool autoFocus;
  final TextAlign textAlign;
  final InputBorder? border;
  final TextStyle? style;
  final IconData? starticon;
  final Color? borderColor;
  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  void _onListen() => setState(() {});
  @override
  void initState() {
    widget._controller!.addListener(_onListen);
    super.initState();
  }

  @override
  void dispose() {
    widget._controller!.removeListener(_onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final InputBorder border = OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).textTheme.bodySmall!.color!),
    );
    return Container(
      padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 4),
      constraints: BoxConstraints(maxWidth: Utilities.maxWidth),
      child: TextFormField(
        initialValue: widget.initialValue,
        controller: widget._controller,
        readOnly: widget.readOnly,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.none,
        keyboardType: widget.keyboardType == TextInputType.number
            ? const TextInputType.numberWithOptions(signed: true, decimal: true)
            : widget.maxLines! > 1
                ? TextInputType.multiline
                : widget.keyboardType ?? TextInputType.text,
        textInputAction: widget.maxLines! > 1
            ? TextInputAction.newline
            : widget.textInputAction ?? TextInputAction.next,
        autofocus: widget.autoFocus,
        focusNode: widget.focusNode,
        textAlign: widget.textAlign,
        onChanged: widget.onChanged,
        minLines: widget.minLines,
        maxLines: (widget._controller!.text.isEmpty) ? 1 : widget.maxLines,
        maxLength: widget.maxLength,
        onFieldSubmitted: widget.onFieldSubmitted,
        style: widget.style,
        validator: (String? value) =>
            widget.validator == null ? null : widget.validator!(value),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          fillColor:
              widget.color ?? Theme.of(context).textTheme.bodyLarge!.color!,
          hintText: widget.hint,
          label: Text(widget.label ?? widget.hint ?? ''),
          hintStyle: const TextStyle(color: Colors.grey),
          labelStyle: const TextStyle(color: Colors.grey),
          suffixIcon: widget.sufficIcon ??
              ((widget._controller!.text.isEmpty ||
                      !widget.showSuffixIcon ||
                      widget.showSuffixIcon == false)
                  ? null
                  : IconButton(
                      splashRadius: 16,
                      onPressed: () => setState(() {
                        widget._controller!.clear();
                      }),
                      icon: const Icon(CupertinoIcons.clear, size: 18),
                    )),
          focusColor: Theme.of(context).primaryColor,
          border: widget.border ?? border,
        ),
      ),
    );
  }
}
