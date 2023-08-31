import 'package:flutter/material.dart';

import '../../database/apis/counter_api.dart';
import '../../database/local/local_auth.dart';
import '../../database/local/local_case.dart';
import '../../database/local/local_counter.dart';
import '../../functions/id_generator.dart';
import '../../models/case/case.dart';
import '../../models/case/counter.dart';
import '../../models/user/app_user.dart';
import '../../utilities/custom_validator.dart';
import '../../utilities/utilities.dart';
import '../../widgets/custom/custom_appbar.dart';
import '../../widgets/custom/custom_circular_image.dart';
import '../../widgets/custom/custom_elevated_button.dart';
import '../../widgets/custom/custom_textformfield.dart';
import '../bashboard/dashboard_screen.dart';

class CreateCounterScreen extends StatefulWidget {
  const CreateCounterScreen({Key? key}) : super(key: key);
  static const String routeName = '/create-counter';

  @override
  State<CreateCounterScreen> createState() => _CreateCounterScreenState();
}

class _CreateCounterScreenState extends State<CreateCounterScreen> {
  final TextEditingController _openingBalance = TextEditingController();
  Counter? currentCounter;
  bool isLoading = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    final Counter result = await LocalCounter().counter();
    result.counterID.isEmpty || result.uid != LocalAuth.uid
        ? currentCounter = null
        : currentCounter = result;
    _openingBalance.text = (currentCounter?.openingCash ?? 0) <= 0
        ? ''
        : (currentCounter?.openingCash ?? 0).toString();
  }

  @override
  Widget build(BuildContext context) {
    final AppUser? user = LocalAuth().currentUser();
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Utilities.maxWidth,
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                const CustomAppBar(title: 'Drawer'),
                if (user != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ListTile(
                      leading: CustomCircularImage(
                        imageURL: user.imageURL,
                        placeHolder: IdGenerator.placeholder(user.name),
                      ),
                      title: Text(user.name),
                    ),
                  ),
                CustomTextFormField(
                  controller: _openingBalance,
                  hint: 'Ex: 1000',
                  label: 'Opening Balance',
                  keyboardType: TextInputType.number,
                  showSuffixIcon: false,
                  readOnly: currentCounter != null || isLoading,
                  validator: (String? value) => CustomValidator.isEmpty(value),
                ),
                Text('Cash in counter: ${currentCounter?.cashInCounter}'),
                CustomElevatedButton(
                  title: 'Start',
                  isLoading: isLoading,
                  onTap: () => onStart(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onStart() async {
    if (!_key.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });
    bool isUpdated = false;
    currentCounter ??= Counter(
      openingCash: double.tryParse(_openingBalance.text) ?? 0.0,
      cashInCounter: double.tryParse(_openingBalance.text) ?? 0.0,
    );
    final List<Counter> alreadyOpen = await CounterAPI().openCounters();
    final List<Case> cases = await LocalCase().caseByDate(DateTime.now());
    final int counterCaseLength = cases
        .where((Case element) => element.counterID == currentCounter?.counterID)
        .length;
    for (Counter element in alreadyOpen) {
      if (element.counterID == (currentCounter?.counterID ?? '')) {
        if (cases.length > element.dayCases) {
          element.dayCases = cases.length;
          element.counterCases = counterCaseLength;
        }
        await CounterAPI().update(element);
        isUpdated = true;
        await LocalCounter().add(element);
      } else {
        element.isOpened = false;
        await CounterAPI().update(element);
      }
    }
    if (!isUpdated) {
      await LocalCounter().add(currentCounter!);
    }
    setState(() {
      isLoading = false;
    });
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
  }
}
