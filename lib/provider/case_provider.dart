import 'package:flutter/material.dart';

import '../database/apis/auth_api.dart';
import '../database/apis/case_api.dart';
import '../database/local/local_auth.dart';
import '../database/local/local_counter.dart';
import '../models/case/case_item.dart';
import '../models/case/case.dart';
import '../models/case/counter.dart';
import '../models/core/department.dart';
import '../models/patient/patient.dart';
import '../models/user/app_user.dart';
import '../widgets/custom/custom_toast.dart';

class CaseProvider extends ChangeNotifier {
  onSave(BuildContext context) async {
    // Business Logic
    if (_discountInPercent > 100) {
      CustomToast.errorSnackBar(
          context: context, text: 'Max Discount Can be 100%');
      return;
    }
    if (_items.isEmpty) {
      CustomToast.errorSnackBar(context: context, text: 'No Item Selected Yet');
      return;
    }
    onLoading(true);
    final Counter counter = await LocalCounter().counter();
    Case result = Case(
      caseID: DateTime.now().millisecondsSinceEpoch.toString(),
      tokenID: 'tokenID',
      patientID: patient?.patientID ?? '',
      departmentID: _department?.departmentID ?? '',
      doctorID: _doctor?.uid ?? LocalAuth.uid,
      operatorID: AuthAPI.uid,
      counterID: counter.counterID,
      items: _items,
      discountInPercent: _discountInPercent,
      discountInRupees: _discountInRupees,
      payable: _payable,
      paidAmount: _paidAmount,
    );
    await CaseAPI().create(result);

    //
    reset();
  }

  void reset() {
    // _tokenID
    _noOfPrints.text = '1';
    _discountController.clear();
    _paidController.clear();
    _patient = null;
    _items.clear();
    _isLoading = false;
    onDiscountInPercent('0');
    onPaidAmountUpdate('0');
    _calculation();
  }

  onLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  int totalItemsQty() {
    int result = 0;
    for (CaseItem element in _items) {
      result += element.quantity;
    }
    return result;
  }

  void onDepartmentUpdate(Department? value) {
    _department = value;
    notifyListeners();
  }

  void onPatientUpdate(Patient? value) {
    if (value == null) return;
    _patient = value;
    notifyListeners();
  }

  void onDoctorUpdate(AppUser? value) {
    if (value == null) return;
    _doctor = value;
    notifyListeners();
  }

  void onAddItem(CaseItem? value) {
    if (value == null) return;
    _items.any((CaseItem element) => element.id == value.id)
        ? _items
            .firstWhere((CaseItem element) => element.id == value.id)
            .quantity++
        : _items.add(value);
    _calculation();
  }

  void onRemoveItem(CaseItem? value) {
    if (value == null) return;
    _items.remove(value);
    _calculation();
  }

  double itemsTotal() {
    double result = 0;
    for (CaseItem element in _items) {
      result += element.total;
    }
    return result;
  }

  void onDiscountInPercent(String? value) {
    if (value == null) return;
    _discountInPercent = double.tryParse(value) ?? 0.0;
    _calculation();
    _onDiscountInRupees();
  }

  void onPaidAmountUpdate(String? value) {
    if (value == null) return;
    _paidAmount = double.tryParse(value) ?? 0.0;
    notifyListeners();
  }

  double get remainingAmount => _payable - _paidAmount;

  void _onDiscountInRupees() {
    _discountInRupees = _payable * (_discountInPercent / 100);
  }

  void _calculation() {
    double amount = itemsTotal();
    amount -= (amount * (_discountInPercent / 100));
    _payable = amount;
    notifyListeners();
  }

  // GETTERS
  String? get tokenID => _tokenID;
  Department? get department => _department;
  Patient? get patient => _patient;
  AppUser? get doctor => _doctor;
  List<CaseItem> get items => <CaseItem>[..._items];
  double get discountInPercent => _discountInPercent;
  double get discountInRupees => _discountInRupees;
  double get payable => _payable;
  double get paidAmount => _paidAmount;
  bool get isLoading => _isLoading;
  TextEditingController get noOfPrints => _noOfPrints;
  TextEditingController get discountController => _discountController;
  TextEditingController get paidController => _paidController;

  // VARIABLES
  String? _tokenID;
  Department? _department;
  Patient? _patient;
  AppUser? _doctor;
  final List<CaseItem> _items = <CaseItem>[];
  double _discountInPercent = 0;
  double _discountInRupees = 0;
  double _payable = 0;
  double _paidAmount = 0;
  bool _isLoading = false;
  final TextEditingController _noOfPrints = TextEditingController(text: '1');
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _paidController = TextEditingController();
}
