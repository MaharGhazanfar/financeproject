import 'package:shared_preferences/shared_preferences.dart';

class ModelEmployee {
  late String _employeeName;
  late String _employeePhoneNO;
  late String _employeeCNIC;
  late String _employeeReferenceNo;

  static SharedPreferences? info;
  static const String employeeNameKey = 'employeeName';
  static const String employeePhoneNoKey = 'employeePhoneNo';
  static const String employeeCNICKey = 'employeeCNIC';
  static const String employeeReferenceNoKey = 'employeeReferenceNo';

  ModelEmployee({
    required String employeeName,
    required String employeePhoneNo,
    required String employeeCNIC,
    required String employeeReferenceNo,
  })  : _employeeName = employeeName,
        _employeePhoneNO = employeePhoneNo,
        _employeeCNIC = employeeCNIC,
        _employeeReferenceNo = employeeReferenceNo;

  String get employeeReferenceNo => _employeeReferenceNo;

  set employeeReferenceNo(String value) {
    _employeeReferenceNo = value;
  }

  String get employeeCNIC => _employeeCNIC;

  set employeeCNIC(String value) {
    _employeeCNIC = value;
  }

  String get employeePhoneNO => _employeePhoneNO;

  set employeePhoneNO(String value) {
    _employeePhoneNO = value;
  }

  String get employeeName => _employeeName;

  set employeeName(String value) {
    _employeeName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      employeeNameKey: employeeName,
      employeeCNICKey: employeeCNIC,
      employeePhoneNoKey: employeePhoneNO,
      employeeReferenceNoKey: employeeReferenceNo
    };
  }

  factory ModelEmployee.fromMap(Map<String, dynamic> map) {
    return ModelEmployee(
      employeeCNIC: map[ModelEmployee.employeeCNICKey],
      employeeName: map[ModelEmployee.employeeNameKey],
      employeeReferenceNo: map[ModelEmployee.employeeReferenceNoKey],
      employeePhoneNo: map[ModelEmployee.employeePhoneNoKey],
    );
  }
}
