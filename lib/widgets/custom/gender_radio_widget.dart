import 'package:flutter/material.dart';

import '../../enums/gender.dart';

class GenderRadioWidget extends StatefulWidget {
  const GenderRadioWidget({
    required this.onChange,
    Gender? initValue,
    super.key,
  }) : initValue = initValue ?? Gender.male;
  final Gender initValue;
  final void Function(Gender) onChange;

  @override
  State<GenderRadioWidget> createState() => _GenderRadioWidgetState();
}

class _GenderRadioWidgetState extends State<GenderRadioWidget> {
  Gender selectedGender = Gender.male;
  @override
  void initState() {
    selectedGender = widget.initValue;
    super.initState();
  }

  void onChange(Gender? value) {
    if (value == null) return;
    selectedGender = value;
    widget.onChange(value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: <Widget>[
        GenderRadioButton(
          value: Gender.male,
          groupValue: selectedGender,
          onChanged: (Gender? value) => onChange(value),
        ),
        GenderRadioButton(
          value: Gender.female,
          groupValue: selectedGender,
          onChanged: (Gender? value) => onChange(value),
        ),
        GenderRadioButton(
          value: Gender.other,
          groupValue: selectedGender,
          onChanged: (Gender? value) => onChange(value),
        ),
      ],
    );
  }
}

class GenderRadioButton extends StatelessWidget {
  const GenderRadioButton({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    super.key,
  });

  final Gender value;
  final Gender? groupValue;
  final void Function(Gender?) onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Radio<Gender>.adaptive(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
            Text(value.title),
          ],
        ),
      ),
    );
  }
}
