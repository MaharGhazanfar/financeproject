import 'dart:io';

import 'package:financeproject/screen/product_info.dart';
import 'package:financeproject/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';

import '../util/const_value.dart';
import '../util/pickfile.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final globalKey = GlobalKey<FormState>();
  final globalKeyProduct = GlobalKey<FormState>();

  late TextEditingController dateCtl;
  late TextEditingController expDateCtl;
  TextEditingController registerNoController = TextEditingController();
  TextEditingController empRefController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerPhoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController addProductController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController totalPriceController = TextEditingController();
  TextEditingController advancePriceController = TextEditingController();
  TextEditingController remainingPriceController = TextEditingController();
  TextEditingController monthlyInstallmentController = TextEditingController();
  TextEditingController engineNoController = TextEditingController();
  TextEditingController framNoController = TextEditingController();
  TextEditingController guaranterNameController = TextEditingController();
  TextEditingController guaranterPhoneController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  TextEditingController grandPriceController = TextEditingController();
  TextEditingController cnicController = TextEditingController();

  List<double> payableInstallment = [];
  List<double> remainingInstallment = [];
  List<String> paidStatus = [];
  File? _image;
  List productDetails = [];

  @override
  void initState() {
    super.initState();
    dateCtl = TextEditingController(text: DateTime.now().toString());
    expDateCtl = TextEditingController(text: DateTime.now().toString());
  }

  @override
  void dispose() {
    dateCtl.dispose();
    expDateCtl.dispose();
    registerNoController.dispose();
    customerNameController.dispose();
    customerPhoneController.dispose();
    addressController.dispose();
    addProductController.dispose();
    totalPriceController.dispose();
    advancePriceController.dispose();
    remainingPriceController.dispose();
    monthlyInstallmentController.dispose();
    engineNoController.dispose();
    framNoController.dispose();
    guaranterNameController.dispose();
    guaranterPhoneController.dispose();
    interestController.dispose();
    grandPriceController.dispose();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text('Personal Information'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    var status = await Permission.storage.request();
                    if (status.isGranted) {
                      _image = await pickImageFromMedia();
                      setState(() {});
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                        ),
                        child: _image == null
                            ? const Icon(
                                Icons.add_a_photo,
                                color: Colors.green,
                                size: 50,
                              )
                            : Image.file(
                                _image!,
                                fit: BoxFit.fill,
                              )),
                  ),
                ),
                Form(
                  key: globalKey,
                  child: GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 16,
                            mainAxisExtent: 70),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CustomWidget.customTextFormField(
                            controller: registerNoController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'required';
                              } else {
                                return null;
                              }
                            },
                            titleName: 'Registration No',
                            textInputType: TextInputType.number),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CustomWidget.customTextFormField(
                            controller: customerNameController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'required';
                              } else {
                                return null;
                              }
                            },
                            titleName: 'Customer Name'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CustomWidget.customTextFormField(
                            controller: customerPhoneController,
                            maxLength: 11,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'required';
                              } else {
                                return null;
                              }
                            },
                            textInputType: TextInputType.number,
                            titleName: 'Customer Phone'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CustomWidget.customTextFormField(
                            controller: cnicController,
                            textInputType: TextInputType.number,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'required';
                              } else if (value.length < 13) {
                                return 'CNIC number must be 13 digits';
                              } else {
                                return null;
                              }
                            },
                            maxLength: 13,
                            titleName: 'Customer CNIC'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CustomWidget.customTextFormField(
                            controller: addressController,
                            titleName: 'Customer Address',
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'required';
                              } else {
                                return null;
                              }
                            },
                            textInputType: TextInputType.streetAddress),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: ConstValue.buttonWidth,
                    height: ConstValue.buttonHeight,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_image != null) {
                            if (globalKey.currentState!.validate()) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProductInfo(
                                  registrationNumber: registerNoController.text,
                                  customerName: customerNameController.text,
                                  customerPhone: customerPhoneController.text,
                                  customerCNIC: cnicController.text,
                                  customerAddress: addressController.text,
                                  customerImage: _image,
                                ),
                              ));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('Pick Image from gallery')));
                          }
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
