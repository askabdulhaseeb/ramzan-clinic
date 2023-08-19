import '../../utilities/utilities.dart';
import 'package:flutter/material.dart';

import 'loader.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.title,
    required this.isLoading,
    required this.onTap,
    this.margin,
    this.padding,
    this.bgColor,
    this.borderRadius,
    this.border,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final bool isLoading;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? bgColor;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      constraints: BoxConstraints(maxWidth: Utilities.maxWidth),
      decoration: BoxDecoration(
        color: bgColor ?? Theme.of(context).primaryColor,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        border: border,
      ),
      child: Material(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        color: bgColor ?? Theme.of(context).primaryColor,
        child: isLoading
            ? const Loader()
            : InkWell(
                borderRadius: borderRadius ?? BorderRadius.circular(12),
                onTap: onTap,
                child: Container(
                  padding: padding ?? const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: textStyle ??
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                  ),
                ),
              ),
      ),
    );
  }
}
