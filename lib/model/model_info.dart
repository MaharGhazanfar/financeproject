class ModelCustomerInfo {
  late String _registerNo;
  late String _empRefNo;
  late String _empName;
  late String _imagePath;
  late String _date;
  late String _expDate;
  late String _customerName;
  late String _customerPhone;
  late String _customerCNIC;
  late String _address;
  late List _productName;
  late String _totalPrice;
  late String _advanceRice;
  late double _remainingPrice;
  late String _monthlyInstallment;
  late String _engineNO;
  late String _framNumber;
  late String _guranterName;
  late String _guranterPhoneNO;
  late String _interest;
  late String _grandPrice;
  late List<double> _payableInstallment;
  late List<String> _paidStatus;
  late List<double> _remainingInstallment;
  late int _maxInstallment;

  static const String regNoKey = 'regNo';
  static const String empRefKey = 'empRef';
  static const String empNameKey = 'empName';
  static const String imagePathKey = 'imagePath';
  static const String dateKey = 'date';
  static const String expDateKey = 'expDate';
  static const String customerNameKey = 'customerName';
  static const String customerPhoneKey = 'customerPhone';
  static const String customerCNICKey = 'customerCNIC';
  static const String addressKey = 'address';
  static const String productNameKey = 'productName';
  static const String totalPriceKey = 'totalPrice';
  static const String advancePriceKey = 'advancePrice';
  static const String remainingPriceKey = 'remainingPrice';
  static const String monthlyInstallmentKey = 'monthlyInstallment';
  static const String engineNoKey = 'engineNo';
  static const String framNoKey = 'framNo';
  static const String guranterNameKey = 'guranterName';
  static const String guranterPhoneNoKey = 'guranterPhoneNo';
  static const String interestKey = 'interest';
  static const String grandPriceKey = 'grandPrice';
  static const String payableInstallmentKey = 'payableInstallment';
  static const String paidStatusKey = 'paidStatus';
  static const String remainingInstallmentKey = 'remainingInstallment';
  static const String maxInstallmentKey = 'maxInstallment';

  ModelCustomerInfo({
    required String registerN0,
    required String empRefN0,
    required String empName,
    required String imagePath,
    required String date,
    required String expDate,
    required String customerName,
    required String customerPhone,
    required String customerCNIC,
    required String address,
    required List productName,
    required String totalPrice,
    required String advancePrice,
    required double remainingPrice,
    required String monthlyInstallment,
    required String engineNo,
    required String framNo,
    required String guaranterName,
    required String guaranterPhoneNO,
    required String interest,
    required String grandPrice,
    required List<double> payableInstallment,
    required List<String> paidStatus,
    required List<double> remainingInstallment,
    required int maxInstallment,
  })  : _registerNo = registerN0,
        _empRefNo = empRefN0,
        _empName = empName,
        _imagePath = imagePath,
        _date = date,
        _expDate = expDate,
        _customerName = customerName,
        _customerPhone = customerPhone,
        _customerCNIC = customerCNIC,
        _address = address,
        _advanceRice = advancePrice,
        _productName = productName,
        _totalPrice = totalPrice,
        _remainingPrice = remainingPrice,
        _monthlyInstallment = monthlyInstallment,
        _engineNO = engineNo,
        _framNumber = framNo,
        _guranterName = guaranterName,
        _guranterPhoneNO = guaranterPhoneNO,
        _interest = interest,
        _grandPrice = grandPrice,
        _payableInstallment = payableInstallment,
        _paidStatus = paidStatus,
        _remainingInstallment = remainingInstallment,
        _maxInstallment = maxInstallment;

  Map<String, dynamic> toMap() {
    return {
      regNoKey: registerNo,
      empRefKey: empRefNo,
      empNameKey: empName,
      imagePathKey: imagePath,
      dateKey: date,
      expDateKey: expDate,
      customerNameKey: customerName,
      customerPhoneKey: customerPhone,
      customerCNICKey: customerCNIC,
      addressKey: address,
      productNameKey: productName,
      totalPriceKey: totalPrice,
      advancePriceKey: advanceRice,
      remainingPriceKey: remainingPrice,
      monthlyInstallmentKey: monthlyInstallment,
      engineNoKey: engineNO,
      framNoKey: framNumber,
      guranterNameKey: guranterName,
      guranterPhoneNoKey: guranterPhoneNO,
      interestKey: interest,
      grandPriceKey: grandPrice,
      payableInstallmentKey: payableInstallment,
      paidStatusKey: paidStatus,
      remainingInstallmentKey: remainingInstallment,
      maxInstallmentKey: maxInstallment
    };
  }

  factory ModelCustomerInfo.fromMap(Map<String, dynamic> map) {
    return ModelCustomerInfo(
      registerN0: map[regNoKey],
      empRefN0: map[empRefKey],
      empName: map[empNameKey],
      imagePath: map[imagePathKey],
      date: map[dateKey],
      expDate: map[expDateKey],
      customerName: map[customerNameKey],
      customerPhone: map[customerPhoneKey],
      customerCNIC: map[customerCNICKey],
      address: map[addressKey],
      advancePrice: map[advancePriceKey],
      productName: map[productNameKey],
      totalPrice: map[totalPriceKey],
      remainingPrice: map[remainingPriceKey],
      monthlyInstallment: map[monthlyInstallmentKey],
      engineNo: map[engineNoKey],
      framNo: map[framNoKey],
      guaranterName: map[guranterNameKey],
      guaranterPhoneNO: map[guranterPhoneNoKey],
      interest: map[interestKey],
      grandPrice: map[grandPriceKey],
      payableInstallment: map[payableInstallmentKey],
      paidStatus: map[paidStatusKey],
      remainingInstallment: map[remainingInstallmentKey],
      maxInstallment: map[maxInstallmentKey],
    );
  }

  String get empName => _empName;

  set empName(String value) {
    _empName = value;
  }

  String get empRefNo => _empRefNo;

  set empRefNo(String value) {
    _empRefNo = value;
  }

  String get imagePath => _imagePath;

  set imagePath(String value) {
    _imagePath = value;
  }

  String get customerCNIC => _customerCNIC;

  set customerCNIC(String value) {
    _customerCNIC = value;
  }

  String get grandPrice => _grandPrice;

  set grandPrice(String value) {
    _grandPrice = value;
  }

  String get interest => _interest;

  set interest(String value) {
    _interest = value;
  }

  String get guranterPhoneNO => _guranterPhoneNO;

  set guranterPhoneNO(String value) {
    _guranterPhoneNO = value;
  }

  String get guranterName => _guranterName;

  set guranterName(String value) {
    _guranterName = value;
  }

  String get customerPhone => _customerPhone;

  set customerPhone(String value) {
    _customerPhone = value;
  }

  String get framNumber => _framNumber;

  set framNumber(String value) {
    _framNumber = value;
  }

  String get engineNO => _engineNO;

  set engineNO(String value) {
    _engineNO = value;
  }

  String get monthlyInstallment => _monthlyInstallment;

  set monthlyInstallment(String value) {
    _monthlyInstallment = value;
  }

  double get remainingPrice => _remainingPrice;

  set remainingPrice(double value) {
    _remainingPrice = value;
  }

  String get advanceRice => _advanceRice;

  set advanceRice(String value) {
    _advanceRice = value;
  }

  String get totalPrice => _totalPrice;

  set totalPrice(String value) {
    _totalPrice = value;
  }

  List get productName => _productName;

  set productName(List value) {
    _productName = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get customerName => _customerName;

  set customerName(String value) {
    _customerName = value;
  }

  String get expDate => _expDate;

  set expDate(String value) {
    _expDate = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get registerNo => _registerNo;

  set registerNo(String value) {
    _registerNo = value;
  }

  List<double> get remainingInstallment => _remainingInstallment;

  set remainingInstallment(List<double> value) {
    _remainingInstallment = value;
  }

  List<String> get paidStatus => _paidStatus;

  set paidStatus(List<String> value) {
    _paidStatus = value;
  }

  List<double> get payableInstallment => _payableInstallment;

  set payableInstallment(List<double> value) {
    _payableInstallment = value;
  }

  int get maxInstallment => _maxInstallment;

  set maxInstallment(int value) {
    _maxInstallment = value;
  }
}
