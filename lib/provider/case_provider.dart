import 'package:flutter/foundation.dart';

import '../models/case/case_item.dart';
import '../models/core/department.dart';
import '../models/patient/patient.dart';
import '../models/user/app_user.dart';

class CaseProvider extends ChangeNotifier {
  onSave() {
    // Business Logic

    //
    reset();
  }

  void reset() {
    // _tokenID
    _patient = null;
    _items.clear();
    onDiscountInPercent('0');
    onPaidAmountUpdate('0');
    _calculation();
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
    _items.add(value);
    _calculation();
  }

  void onRemoveItem(CaseItem? value) {
    if (value == null) return;
    _items.remove(value);
    _calculation();
  }

  void onDiscountInPercent(String? value) {
    if (value == null) return;
    _discountInPercent = double.tryParse(value) ?? 0.0;
    _onDiscountInRupees();
  }

  void onPaidAmountUpdate(String? value) {
    if (value == null) return;
    _paidAmount = double.tryParse(value) ?? 0.0;
    notifyListeners();
  }

  void _onDiscountInRupees() {
    _discountInRupees = _payable * (_discountInPercent / 100);
    notifyListeners();
  }

  void _calculation() {
    double amount = 0;
    for (CaseItem element in _items) {
      amount += element.total;
    }
    amount -= _discountInRupees;
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
}
