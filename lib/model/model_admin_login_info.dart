class ModelLoginInfo {
  late String _adminName;
  late String _adminPhoneNO;
  late String _adminEmail;

  String get adminName => _adminName;

  set adminName(String value) {
    _adminName = value;
  }

  String get adminPhoneNO => _adminPhoneNO;

  set adminPhoneNO(String value) {
    _adminPhoneNO = value;
  }

  String get adminEmail => _adminEmail;

  set adminEmail(String value) {
    _adminEmail = value;
  }

  static const String adminNameKey = 'AdminName';
  static const String adminPhoneNoKey = 'AdminPhoneNo';
  static const String adminEmailKey = 'AdminEmailKey';

  ModelLoginInfo({
    required String adminName,
    required String adminPhoneNo,
    required String adminEmail,
  })  : _adminName = adminName,
        _adminPhoneNO = adminPhoneNo,
        _adminEmail = adminEmail;

  Map<String, dynamic> toMap() {
    return {
      adminNameKey: adminName,
      adminPhoneNoKey: adminPhoneNO,
      adminEmailKey: adminEmail
    };
  }

  factory ModelLoginInfo.fromMap(Map<String, dynamic> map) {
    return ModelLoginInfo(
      adminName: map[ModelLoginInfo.adminNameKey],
      adminPhoneNo: map[ModelLoginInfo.adminPhoneNoKey],
      adminEmail: map[ModelLoginInfo.adminEmailKey],
    );
  }
}
