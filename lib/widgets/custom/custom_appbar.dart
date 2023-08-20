import 'package:flutter/material.dart';

import '../../utilities/utilities.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    this.width,
    this.title,
    this.textStyle,
    this.actions,
    super.key,
  });
  final double? width;
  final String? title;
  final TextStyle? textStyle;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Utilities.maxWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Navigator.of(context).canPop()
              ? IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.adaptive.arrow_back),
                )
              : const SizedBox(width: 20),
          title == null
              ? const SizedBox()
              : Text(title ?? '',
                  style: textStyle ??
                      const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
          actions ?? const SizedBox(width: 10),
        ],
      ),
    );
  }
}
