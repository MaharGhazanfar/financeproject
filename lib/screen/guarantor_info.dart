import 'dart:io';

import 'package:financeproject/screen/bottom_navigationBar_screen.dart';
import 'package:financeproject/util/DbHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/model_info.dart';
import '../util/const_value.dart';
import '../widget/custom_textfield.dart';

class GuarantorInfo extends StatefulWidget {
  final String registrationNumber;
  final String customerName;
  final String customerPhone;
  final String customerCNIC;
  final String customerAddress;
  final File? customerImage;
  final List productDetails;
  final String price;
  final String interest;
  final String grandPrice;
  final String advancePrice;
  final String monthlyInstallment;
  final String remainingPrice;
  final String EngineNo;
  final String FrameNo;
  final String date;
  final String expDate;

  const GuarantorInfo({
    Key? key,
    required this.registrationNumber,
    required this.customerName,
    required this.customerPhone,
    required this.monthlyInstallment,
    required this.customerCNIC,
    required this.customerAddress,
    required this.customerImage,
    required this.productDetails,
    required this.price,
    required this.interest,
    required this.advancePrice,
    required this.grandPrice,
    required this.remainingPrice,
    required this.EngineNo,
    required this.FrameNo,
    required this.date,
    required this.expDate,
  }) : super(key: key);

  @override
  State<GuarantorInfo> createState() => _GuarantorInfoState();
}

class _GuarantorInfoState extends State<GuarantorInfo> {
  final globalKey = GlobalKey<FormState>();
  late TextEditingController guaranterNameController;
  late TextEditingController guaranterPhoneController;
  List<double> payableInstallment = [];
  List<double> remainingInstallment = [];
  List<String> paidStatus = [];
  bool isLoading = false;
  double opacity = 1;

  @override
  void initState() {
    super.initState();
    guaranterNameController = TextEditingController();
    guaranterPhoneController = TextEditingController();
  }

  @override
  void dispose() {
    guaranterNameController.dispose();
    guaranterPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Guarantor Information'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              AnimatedOpacity(
                opacity: opacity,
                duration: Duration(milliseconds: 500),
                child: Form(
                  key: globalKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CustomWidget.customTextFormField(
                          controller: guaranterNameController,
                          titleName: 'Guarantor Name',
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'required';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CustomWidget.customTextFormField(
                            controller: guaranterPhoneController,
                            textInputType: TextInputType.number,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'required';
                              } else if (value.length < 11) {
                                return 'phone number must be 11 digits';
                              } else {
                                return null;
                              }
                            },
                            maxLength: 11,
                            titleName: 'Guarantor Phone Number'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: ConstValue.buttonWidth,
                          height: ConstValue.buttonHeight,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (globalKey.currentState!.validate()) {
                                  paidStatus.clear();
                                  payableInstallment.clear();
                                  remainingInstallment.clear();
                                  setState(() {
                                    isLoading = true;
                                    opacity = 0.5;
                                  });

                                  double monthlyInstallment = double.parse(
                                      widget.monthlyInstallment.toString());
                                  double totalAmount =
                                      double.parse(widget.remainingPrice);

                                  double months =
                                      totalAmount / monthlyInstallment;

                                  for (int i = 0; i < months.round(); i++) {
                                    paidStatus.add('unpaid');

                                    double installmentPaid =
                                        i < months.round() - 1
                                            ? (monthlyInstallment)
                                            : ((totalAmount) -
                                                (monthlyInstallment) *
                                                    (months.round() - 1));

                                    payableInstallment.add(installmentPaid);
                                    remainingInstallment.add(installmentPaid);
                                  }
                                  var imagePath =
                                      await uploadImage(widget.customerImage!);

                                  var modelCustomerInfo = ModelCustomerInfo(
                                      imagePath: imagePath,
                                      registerN0: widget.registrationNumber,
                                      empRefN0: '',
                                      empName: '',
                                      date: widget.date,
                                      expDate: widget.expDate,
                                      customerName: widget.customerName,
                                      customerPhone: widget.customerPhone,
                                      customerCNIC: widget.customerCNIC,
                                      address: widget.customerAddress,
                                      productName: widget.productDetails,
                                      totalPrice: widget.price,
                                      remainingPrice: totalAmount,
                                      monthlyInstallment:
                                          widget.monthlyInstallment,
                                      engineNo: widget.EngineNo,
                                      framNo: widget.FrameNo,
                                      guaranterName: guaranterNameController
                                          .text
                                          .toString(),
                                      guaranterPhoneNO: guaranterPhoneController
                                          .text
                                          .toString(),
                                      interest: widget.interest,
                                      advancePrice: widget.advancePrice,
                                      grandPrice: widget.grandPrice,
                                      paidStatus: paidStatus,
                                      maxInstallment: payableInstallment.length,
                                      payableInstallment: payableInstallment,
                                      remainingInstallment:
                                          remainingInstallment);

                                  DbHandler.customerCollection()
                                      .doc(widget.registrationNumber)
                                      .set(modelCustomerInfo.toMap());
                                  guaranterNameController.clear();
                                  guaranterPhoneController.clear();
                                  setState(() {
                                    isLoading = false;
                                    opacity = 1;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Successful Added')));
                                  });
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigationBarForUser(
                                                currentIndex: 1,
                                              )),
                                      (Route<dynamic> route) => false);
                                }
                              },
                              child: const Text(
                                'SAVE',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              isLoading
                  ? Positioned(
                      left: MediaQuery.of(context).size.width * 0.4,
                      top: MediaQuery.of(context).size.width * 0.55,
                      child: CircularProgressIndicator())
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
