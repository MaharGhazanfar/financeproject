import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:financeproject/screen/guarantor_info.dart';
import 'package:flutter/material.dart';

import '../util/const_value.dart';
import '../widget/custom_textfield.dart';

class ProductInfo extends StatefulWidget {
  final String registrationNumber;
  final String customerName;
  final String customerPhone;
  final String customerCNIC;
  final String customerAddress;
  final File? customerImage;

  const ProductInfo(
      {Key? key,
      required this.registrationNumber,
      required this.customerName,
      required this.customerPhone,
      required this.customerCNIC,
      required this.customerAddress,
      required this.customerImage})
      : super(key: key);

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  final globalKey = GlobalKey<FormState>();
  final globalKeyProduct = GlobalKey<FormState>();
  late TextEditingController dateCtl;
  late TextEditingController expDateCtl;
  TextEditingController addProductController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController totalPriceController = TextEditingController();
  TextEditingController advancePriceController = TextEditingController();
  TextEditingController remainingPriceController = TextEditingController();
  TextEditingController monthlyInstallmentController = TextEditingController();
  TextEditingController engineNoController = TextEditingController();
  TextEditingController framNoController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  TextEditingController grandPriceController = TextEditingController();

  List<double> payableInstallment = [];
  List<double> remainingInstallment = [];
  List<String> paidStatus = [];
  List productDetails = [];

  @override
  void initState() {
    super.initState();
    dateCtl = TextEditingController(text: DateTime.now().toString());
    expDateCtl = TextEditingController(text: DateTime.now().toString());
  }

  @override
  void dispose() {
    addProductController.dispose();
    totalPriceController.dispose();
    advancePriceController.dispose();
    remainingPriceController.dispose();
    monthlyInstallmentController.dispose();
    engineNoController.dispose();
    framNoController.dispose();
    dateCtl.dispose();
    expDateCtl.dispose();
    interestController.dispose();
    grandPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Product Information'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: DateTimePicker(
                    controller: dateCtl,
                    dateHintText: 'dd-mm-yyyy',
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.date_range_outlined,
                        color: Colors.white,
                      ),
                      label: const Text('Date'),
                      labelStyle: const TextStyle(color: Colors.white),
                      constraints: BoxConstraints(maxHeight: 50),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: DateTimePicker(
                    controller: expDateCtl,
                    dateHintText: 'dd-mm-yyyy',
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.date_range_outlined,
                        color: Colors.white,
                      ),
                      label: const Text('Expiry Date'),
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomWidget.customTextFormField(
                    readOnly: true,
                    controller: addProductController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'required';
                      } else {
                        return null;
                      }
                    },
                    titleName: 'Add Product',
                    suffix: IconButton(
                        onPressed: () {
                          productNameController.clear();
                          productPriceController.clear();

                          showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: Material(
                                    child: SizedBox(
                                      height: 220,
                                      width: 350,
                                      child: Form(
                                        key: globalKeyProduct,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: CustomWidget
                                                    .customTextFormField(
                                                  controller:
                                                      productNameController,
                                                  validate: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'required';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  titleName: 'Product Name',
                                                  styleColor: Colors.black,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: CustomWidget
                                                    .customTextFormField(
                                                        controller:
                                                            productPriceController,
                                                        validate: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'required';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        textInputType:
                                                            TextInputType
                                                                .number,
                                                        styleColor:
                                                            Colors.black,
                                                        titleName:
                                                            'Product Price'),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            'Cancel')),
                                                    TextButton(
                                                        onPressed: () {
                                                          if (globalKeyProduct
                                                              .currentState!
                                                              .validate()) {
                                                            Map map = {
                                                              'productName':
                                                                  productNameController
                                                                      .text
                                                                      .toString(),
                                                              'productPrice':
                                                                  productPriceController
                                                                      .text
                                                                      .toString()
                                                            };

                                                            productDetails
                                                                .add(map);

                                                            addProductController
                                                                    .text =
                                                                '${addProductController.text.toString()}${productNameController.text.toString()},';

                                                            double amount =
                                                                double.parse(
                                                                    productPriceController
                                                                        .text
                                                                        .toString());

                                                            if (totalPriceController
                                                                .text
                                                                .toString()
                                                                .isEmpty) {
                                                              totalPriceController
                                                                      .text =
                                                                  '$amount';
                                                            } else {
                                                              double
                                                                  totalAmount =
                                                                  double.parse(
                                                                      totalPriceController
                                                                          .text
                                                                          .toString());

                                                              double
                                                                  grandTotal =
                                                                  amount +
                                                                      totalAmount;

                                                              totalPriceController
                                                                      .text =
                                                                  grandTotal
                                                                      .toString();
                                                            }

                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        },
                                                        child:
                                                            const Text('Add')),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomWidget.customTextFormField(
                    readOnly: true,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'required';
                      } else {
                        return null;
                      }
                    },
                    controller: totalPriceController,
                    textInputType: TextInputType.number,
                    titleName: 'Total Price',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomWidget.customTextFormField(
                    controller: interestController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'required';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      double totalPrice =
                          double.parse(totalPriceController.text.toString());

                      if (value.toString().isEmpty) {
                        grandPriceController.text = totalPrice.toString();

                        remainingPriceController.text =
                            grandPriceController.text.toString();
                      } else {
                        double percent = double.parse(value.toString());

                        double percentInDec = percent / 100;
                        double grandPrice = percentInDec * totalPrice;
                        grandPriceController.text =
                            (grandPrice + totalPrice).toString();
                        remainingPriceController.text =
                            grandPriceController.text.toString();
                      }
                    },
                    textInputType: TextInputType.number,
                    titleName: 'Interest',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomWidget.customTextFormField(
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'required';
                      } else {
                        return null;
                      }
                    },
                    readOnly: true,
                    titleName: 'Grand Price',
                    controller: grandPriceController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomWidget.customTextFormField(
                    controller: advancePriceController,
                    textInputType: TextInputType.number,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'required';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      if (value.toString().isNotEmpty) {
                        double grandPrice =
                            double.parse(grandPriceController.text.toString());
                        double remaining =
                            (grandPrice - double.parse(value.toString()));

                        remainingPriceController.text = remaining.toString();
                      } else {
                        remainingPriceController.text =
                            grandPriceController.text.toString();
                      }
                    },
                    titleName: 'Advance Price',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomWidget.customTextFormField(
                    readOnly: true,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'required';
                      } else {
                        return null;
                      }
                    },
                    controller: remainingPriceController,
                    titleName: 'Remaining Price',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomWidget.customTextFormField(
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'required';
                      } else {
                        return null;
                      }
                    },
                    titleName: 'Monthly Installment',
                    controller: monthlyInstallmentController,
                    textInputType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomWidget.customTextFormField(
                    titleName: 'Engine No',
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'required';
                      } else {
                        return null;
                      }
                    },
                    controller: engineNoController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomWidget.customTextFormField(
                    controller: framNoController,
                    titleName: 'Frame No',
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'required';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: ConstValue.buttonWidth,
                    height: ConstValue.buttonHeight,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (globalKey.currentState!.validate()) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GuarantorInfo(
                                productDetails: productDetails,
                                price: productPriceController.text,
                                interest: interestController.text,
                                advancePrice: advancePriceController.text,
                                grandPrice: grandPriceController.text,
                                remainingPrice: remainingPriceController.text,
                                monthlyInstallment:
                                    monthlyInstallmentController.text,
                                EngineNo: engineNoController.text,
                                FrameNo: framNoController.text,
                                date: dateCtl.text,
                                expDate: expDateCtl.text,
                                registrationNumber: widget.registrationNumber,
                                customerName: widget.customerName,
                                customerPhone: widget.customerPhone,
                                customerCNIC: widget.customerCNIC,
                                customerAddress: widget.customerAddress,
                                customerImage: widget.customerImage,
                              ),
                            ));
                          }
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
