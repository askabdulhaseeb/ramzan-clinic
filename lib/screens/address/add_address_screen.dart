import 'package:flutter/material.dart';

import '../../database/apis/address_api.dart';
import '../../models/core/address.dart';
import '../../utilities/custom_validator.dart';
import '../../widgets/custom/custom_appbar.dart';
import '../../widgets/custom/custom_elevated_button.dart';
import '../../widgets/custom/custom_textformfield.dart';
import '../../widgets/custom/custom_toast.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);
  static const String routeName = '/add-address';

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController _town = TextEditingController();
  final TextEditingController _city =
      TextEditingController(text: 'Qila Didar Singh');
  final TextEditingController _discrict =
      TextEditingController(text: 'Gujranawala');
  final TextEditingController _province = TextEditingController(text: 'Punjab');
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Form(
          key: key,
          child: Column(
            children: <Widget>[
              const CustomAppBar(title: 'New Address'),
              CustomTextFormField(
                controller: _town,
                hint: 'Town Name',
                autoFocus: true,
                textCapitalization: TextCapitalization.words,
                validator: (String? p0) => null,
              ),
              CustomTextFormField(
                controller: _city,
                hint: 'City Name',
                textCapitalization: TextCapitalization.words,
                validator: (String? p0) => CustomValidator.isEmpty(p0),
              ),
              CustomTextFormField(
                controller: _discrict,
                hint: 'District Name',
                textCapitalization: TextCapitalization.words,
                validator: (String? p0) => CustomValidator.isEmpty(p0),
              ),
              CustomTextFormField(
                controller: _province,
                hint: 'Province Name',
                textCapitalization: TextCapitalization.words,
                validator: (String? p0) => CustomValidator.isEmpty(p0),
              ),
              CustomElevatedButton(
                title: 'Save',
                isLoading: _isLoading,
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
    try {
      setState(() {
        _isLoading = true;
      });
      final Address address = Address(
        province: _province.text,
        district: _discrict.text,
        city: _city.text,
        town: _town.text,
      );
      await AddressAPI().create(address);
      _town.clear();
    } catch (e) {
      debugPrint(e.toString());
      CustomToast.errorSnackBar(
        context: context,
        text: 'Something wents wrong - ${e.toString()}',
      );
    }
    setState(() {
      _isLoading = false;
    });
  }
}
