import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utilities/custom_validator.dart';
import '../../utilities/utilities.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    required TextEditingController controller,
    this.textInputAction = TextInputAction.done,
    this.hint = 'Password',
    this.color,
    this.starticon,
    Key? key,
  })  : _controller = controller,
        super(key: key);
  final TextEditingController _controller;
  final String hint;
  final TextInputAction? textInputAction;
  final Color? color;
  final IconData? starticon;
  @override
  PasswordTextFormFieldState createState() => PasswordTextFormFieldState();
}

class PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _notVisible = true;
  void _onListener() => setState(() {});
  @override
  void initState() {
    widget._controller.addListener(_onListener);
    super.initState();
  }

  @override
  void dispose() {
    widget._controller.removeListener(_onListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const InputBorder border = OutlineInputBorder();
    return Container(
      constraints: BoxConstraints(maxWidth: Utilities.maxWidth),
      child: TextFormField(
        controller: widget._controller,
        obscureText: _notVisible,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: widget.textInputAction,
        cursorColor: Theme.of(context).colorScheme.primary,
        validator: (String? value) => CustomValidator.password(value),
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, top: 12),
          fillColor:
              widget.color ?? Theme.of(context).textTheme.bodyLarge!.color!,
          hintText: widget.hint,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: widget.starticon == null
              ? null
              : SizedBox(
                  width: 40,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        widget.starticon,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
          suffixIcon: IconButton(
            onPressed: () => setState(() {
              _notVisible = !_notVisible;
            }),
            splashRadius: 16,
            icon: (_notVisible == true)
                ? const Icon(CupertinoIcons.eye)
                : const Icon(CupertinoIcons.eye_slash),
          ),
          focusColor: Theme.of(context).primaryColor,
          border: border,
        ),
      ),
    );
  }
}
