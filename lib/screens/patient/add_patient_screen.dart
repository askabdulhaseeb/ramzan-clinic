import 'package:flutter/material.dart';

import '../../database/apis/patient_api.dart';
import '../../enums/gender.dart';
import '../../functions/time_fun.dart';
import '../../models/core/address.dart';
import '../../models/patient/patient.dart';
import '../../utilities/custom_validator.dart';
import '../../utilities/utilities.dart';
import '../../widgets/address/address_bottom_sheet.dart';
import '../../widgets/custom/custom_appbar.dart';
import '../../widgets/custom/custom_elevated_button.dart';
import '../../widgets/custom/custom_textformfield.dart';
import '../../widgets/custom/custom_toast.dart';
import '../../widgets/custom/gender_radio_widget.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({Key? key}) : super(key: key);
  static const String routeName = '/add-patient';

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _cnic = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _fullAddress = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  DateTime? dob;
  Gender gender = Gender.male;
  Address? address;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Utilities.maxWidth,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: key,
              child: Column(
                children: <Widget>[
                  const CustomAppBar(title: 'Add Patient'),
                  CustomTextFormField(
                    controller: _firstName,
                    hint: 'First Name',
                    autoFocus: true,
                    readOnly: isLoading,
                    textCapitalization: TextCapitalization.words,
                    validator: (String? value) =>
                        CustomValidator.lessThen2(value),
                  ),
                  CustomTextFormField(
                    controller: _lastName,
                    hint: 'Father/Husband',
                    readOnly: isLoading,
                    textCapitalization: TextCapitalization.words,
                    validator: (String? value) =>
                        CustomValidator.lessThen2(value),
                  ),
                  GenderRadioWidget(
                    onChange: (Gender? value) {
                      if (value == null) return;
                      gender = value;
                    },
                  ),
                  Row(
                    children: <Widget>[
                      const Text(
                        'Date of Birth',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      if (dob != null) Text(TimeFun.dob(dob ?? DateTime.now())),
                      TextButton(
                        onPressed: () async {
                          dob = await showDatePicker(
                            context: context,
                            initialDate: DateTime(1999),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          setState(() {});
                        },
                        child: const Text('Choose'),
                      ),
                    ],
                  ),
                  CustomTextFormField(
                    controller: _cnic,
                    label: 'CNIC',
                    hint: 'Ex: 1234512345671',
                    readOnly: isLoading,
                    keyboardType: TextInputType.number,
                    validator: (String? value) => null,
                  ),
                  SearchableAddress(
                    selectedAddress: address,
                    onSelect: (Address? value) => setState(() {
                      address = value;
                      _fullAddress.text = value?.string ?? '';
                    }),
                  ),
                  CustomTextFormField(
                    controller: _fullAddress,
                    hint: 'Full Address',
                    readOnly: isLoading,
                    keyboardType: TextInputType.streetAddress,
                    validator: (String? value) => null,
                  ),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 4),
                      const Text('+92'),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CustomTextFormField(
                          controller: _phone,
                          label: 'Phone Number',
                          hint: '3001234567',
                          readOnly: isLoading,
                          keyboardType: TextInputType.phone,
                          validator: (String? value) =>
                              CustomValidator.lengthLessThen(value, 10),
                        ),
                      ),
                    ],
                  ),
                  CustomElevatedButton(
                    title: 'Add',
                    isLoading: isLoading,
                    onTap: onAdd,
                  ),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAdd() async {
    if (!key.currentState!.validate()) return;
    if (dob == null) {
      CustomToast.errorSnackBar(context: context, text: 'Select Date of Birth');
      return;
    }
    setState(() {
      isLoading = true;
    });
    final Patient patient = Patient(
      name: _firstName.text,
      lastName: _lastName.text,
      gender: gender,
      dob: dob ?? DateTime.now(),
      cnic: _cnic.text,
      address: address?.addressID ?? '',
      fullAddress: _fullAddress.text,
      phoneNumber: '+92${_phone.text}',
    );
    try {
      await PatientAPI().create(patient);
    } catch (e) {
      debugPrint(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }
}
