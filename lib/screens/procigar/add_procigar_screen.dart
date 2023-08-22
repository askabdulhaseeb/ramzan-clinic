import 'package:flutter/material.dart';

import '../../database/apis/procigar_api.dart';
import '../../enums/procigar_type.dart';
import '../../models/procigar/procigar.dart';
import '../../utilities/custom_validator.dart';
import '../../widgets/custom/custom_appbar.dart';
import '../../widgets/custom/custom_elevated_button.dart';
import '../../widgets/custom/custom_textformfield.dart';

class AddProcigarScreen extends StatefulWidget {
  const AddProcigarScreen({required this.type, Key? key}) : super(key: key);
  static const String routeName = '/add-procigar';
  final ProcigarType type;

  @override
  State<AddProcigarScreen> createState() => _AddProcigarScreenState();
}

class _AddProcigarScreenState extends State<AddProcigarScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _fee = TextEditingController();
  final TextEditingController _discountInPercent = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  double discountInRupees = 0.0;
  bool isLoading = false;
  void updateDiscount() {
    setState(() {
      discountInRupees = (double.tryParse(_fee.text) ?? 0.0) *
          ((double.tryParse(_discountInPercent.text) ?? 0.0) / 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Form(
          key: key,
          child: Column(
            children: <Widget>[
              CustomAppBar(title: 'Add ${widget.type.title}'),
              CustomTextFormField(
                controller: _name,
                hint: 'Name',
                autoFocus: true,
                textCapitalization: TextCapitalization.words,
                validator: (String? value) => CustomValidator.isEmpty(value),
              ),
              CustomTextFormField(
                controller: _fee,
                hint: 'Fee',
                onChanged: (_) => updateDiscount(),
                keyboardType: TextInputType.number,
                validator: (String? value) => CustomValidator.isEmpty(value),
              ),
              CustomTextFormField(
                controller: _discountInPercent,
                hint: 'Discount in Percent',
                onChanged: (_) => updateDiscount(),
                keyboardType: TextInputType.number,
                validator: (String? value) => CustomValidator.isEmpty(value),
              ),
              Text(
                'Discount in Rupees: $discountInRupees',
                style: const TextStyle(color: Colors.grey),
              ),
              CustomElevatedButton(
                title: 'Save',
                isLoading: isLoading,
                onTap: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onTap() async {
    if (!key.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });
    final Procigar procigar = Procigar(
      name: _name.text,
      fee: double.tryParse(_fee.text) ?? 0.0,
      discountInPercent: double.tryParse(_discountInPercent.text) ?? 0.0,
      type: widget.type,
    );
    final bool added = await ProcigarAPI().create(procigar);
    if (added) {
      setState(() {
        _name.clear();
        _fee.clear();
        _discountInPercent.clear();
        discountInRupees = 0.0;
        isLoading = false;
      });
    }
  }
}
