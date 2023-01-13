import 'dart:io';

import 'package:financeproject/util/const_value.dart';
import 'package:financeproject/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';

import '../model/model_employee_info.dart';
import '../model/model_info.dart';

class CustomerView extends StatefulWidget {
  final List customers;
  final void Function(void Function()) state;
  const CustomerView({Key? key, required this.customers, required this.state})
      : super(key: key);

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.customers.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, customerIndex) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    flex: 1,
                    onPressed: (context) async {
                      var localDataBase =
                          await Hive.openBox(ConstValue.customerTableName);

                      var database =
                          await Hive.openBox(ConstValue.saveDataBaseFile);
                      var path = database.get(ConstValue.saveDataBaseFile);
                      Directory? appDocDir = Directory(path);
                      String appDocPath = appDocDir.path;
                      var dir = Directory('$appDocPath/images');

                      File image = File(
                          '${dir.path}/${widget.customers[customerIndex][ModelCustomerInfo.regNoKey]}.jpg');

                      image.delete();

                      localDataBase.delete(widget.customers[customerIndex]
                              [ModelCustomerInfo.regNoKey]
                          .toString());

                      widget.state(() {});
                    },
                    backgroundColor: Colors.red,
                    spacing: 6,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: MediaQuery.of(context).size.width > 500
                  ? Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Registration Number : ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.customers[customerIndex]
                                                [ModelCustomerInfo.regNoKey]
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Name : ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.customers[customerIndex][
                                                ModelCustomerInfo
                                                    .customerNameKey]
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Phone No : ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.customers[customerIndex][
                                                ModelCustomerInfo
                                                    .customerPhoneKey]
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'CNIC : ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.customers[customerIndex][
                                                ModelCustomerInfo
                                                    .customerCNICKey]
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Total Price : ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.customers[customerIndex][
                                                ModelCustomerInfo.grandPriceKey]
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Remaining Price : ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.customers[customerIndex][
                                                ModelCustomerInfo
                                                    .remainingPriceKey]
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Monthly Installment : ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.customers[customerIndex][
                                                ModelCustomerInfo
                                                    .monthlyInstallmentKey]
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Advance Price : ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.customers[customerIndex][
                                                ModelCustomerInfo
                                                    .advancePriceKey]
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                                flex: 4,
                                child: Align(
                                    alignment: Alignment.center,
                                    child:
                                        (widget.customers[customerIndex][
                                                            ModelCustomerInfo
                                                                .empNameKey]
                                                        .toString() ==
                                                    '') &&
                                                widget.customers[customerIndex][
                                                            ModelCustomerInfo
                                                                .empRefKey]
                                                        .toString() ==
                                                    ''
                                            ? TextButton(
                                                onPressed: () async {
                                                  await showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        Center(
                                                      child: Material(
                                                        child: Container(
                                                          width: 400,
                                                          height: 500,
                                                          color: Colors.white,
                                                          child: Center(
                                                            child:
                                                                FutureBuilder(
                                                              future:
                                                                  Hive.openBox(
                                                                      'Employee'),
                                                              builder: (BuildContext
                                                                      context,
                                                                  AsyncSnapshot<
                                                                          Box<dynamic>>
                                                                      empSnapshot) {
                                                                if (empSnapshot
                                                                    .hasData) {
                                                                  return ListView
                                                                      .builder(
                                                                    itemCount: empSnapshot
                                                                        .data!
                                                                        .values
                                                                        .toList()
                                                                        .length,
                                                                    itemBuilder: (context,
                                                                            index) =>
                                                                        Center(
                                                                            child:
                                                                                Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            border:
                                                                                Border.all(color: Colors.black),
                                                                            borderRadius: BorderRadius.circular(5)),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              widget.customers[customerIndex][ModelCustomerInfo.empRefKey] = empSnapshot.data!.values.toList()[index][ModelEmployee.employeeReferenceNoKey].toString();
                                                                              widget.customers[customerIndex][ModelCustomerInfo.empNameKey] = empSnapshot.data!.values.toList()[index][ModelEmployee.employeeNameKey].toString();

                                                                              var localDataBase = await Hive.openBox(ConstValue.customerTableName);
                                                                              localDataBase.put(widget.customers[customerIndex][ModelCustomerInfo.regNoKey], widget.customers[customerIndex]);

                                                                              if (mounted) {
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                              }
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    const Text(
                                                                                      'Name : ',
                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                    Text(empSnapshot.data!.values.toList()[index][ModelEmployee.employeeNameKey].toString()),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    const Text(
                                                                                      'Reference No : ',
                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                    Text(empSnapshot.data!.values.toList()[index][ModelEmployee.employeeReferenceNoKey].toString()),
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )),
                                                                  );
                                                                } else {
                                                                  return const CircularProgressIndicator();
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );

                                                  setState(() {});
                                                },
                                                child: const Text(
                                                    'Select category'),
                                              )
                                            : Row(
                                                children: [
                                                  Flexible(
                                                    flex: 7,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'Employee Name : ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(widget
                                                                .customers[
                                                                    customerIndex]
                                                                    [
                                                                    ModelCustomerInfo
                                                                        .empNameKey]
                                                                .toString()),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'Reference Number : ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(widget
                                                                .customers[
                                                                    customerIndex]
                                                                    [
                                                                    ModelCustomerInfo
                                                                        .empRefKey]
                                                                .toString()),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  TextButton(
                                                      onPressed: () async {
                                                        await showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              Center(
                                                            child: Material(
                                                              child: Container(
                                                                width: 400,
                                                                height: 500,
                                                                color: Colors
                                                                    .white,
                                                                child: Center(
                                                                  child:
                                                                      FutureBuilder(
                                                                    future: Hive
                                                                        .openBox(
                                                                            'Employee'),
                                                                    builder: (BuildContext
                                                                            context,
                                                                        AsyncSnapshot<Box<dynamic>>
                                                                            empSnapshot) {
                                                                      if (empSnapshot
                                                                          .hasData) {
                                                                        return ListView
                                                                            .builder(
                                                                          itemCount: empSnapshot
                                                                              .data!
                                                                              .values
                                                                              .toList()
                                                                              .length,
                                                                          itemBuilder: (context, index) => Center(
                                                                              child: Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Container(
                                                                              alignment: Alignment.center,
                                                                              decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(5)),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: InkWell(
                                                                                  onTap: () async {
                                                                                    widget.customers[customerIndex][ModelCustomerInfo.empRefKey] = empSnapshot.data!.values.toList()[index][ModelEmployee.employeeReferenceNoKey].toString();
                                                                                    widget.customers[customerIndex][ModelCustomerInfo.empNameKey] = empSnapshot.data!.values.toList()[index][ModelEmployee.employeeNameKey].toString();

                                                                                    var localDataBase = await Hive.openBox(ConstValue.customerTableName);
                                                                                    localDataBase.put(widget.customers[customerIndex][ModelCustomerInfo.regNoKey], widget.customers[customerIndex]);

                                                                                    if (mounted) {
                                                                                      Navigator.pop(context);
                                                                                      setState(() {});
                                                                                    }
                                                                                  },
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          const Text(
                                                                                            'Name : ',
                                                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                                                          ),
                                                                                          Text(empSnapshot.data!.values.toList()[index][ModelEmployee.employeeNameKey].toString()),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          const Text(
                                                                                            'Reference No : ',
                                                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                                                          ),
                                                                                          Text(empSnapshot.data!.values.toList()[index][ModelEmployee.employeeReferenceNoKey].toString()),
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )),
                                                                        );
                                                                      } else {
                                                                        return const CircularProgressIndicator();
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );

                                                        setState(() {});
                                                      },
                                                      child: const Text(
                                                          'Change Category'))
                                                ],
                                              )))
                          ],
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      height: 250,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomWidget.customRow(
                                title: 'Registration Number  : ',
                                value: widget.customers[customerIndex]
                                        [ModelCustomerInfo.regNoKey]
                                    .toString()),
                            // Flexible(
                            //   flex: 4,
                            //   child: Column(
                            //     mainAxisAlignment:
                            //     MainAxisAlignment.spaceEvenly,
                            //     children: [
                            //       Row(
                            //         children: [
                            //           const Text(
                            //             'Registration Number : ',
                            //             style: TextStyle(
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //           Text(widget.customers[customerIndex]
                            //           [ModelInfo.regNoKey]
                            //               .toString()),
                            //         ],
                            //       ),
                            //       Row(
                            //         children: [
                            //           const Text(
                            //             'Name : ',
                            //             style: TextStyle(
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //           Text(widget.customers[customerIndex]
                            //           [ModelInfo.customerNameKey]
                            //               .toString()),
                            //         ],
                            //       ),
                            //       Row(
                            //         children: [
                            //           const Text(
                            //             'Phone No : ',
                            //             style: TextStyle(
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //           Text(widget.customers[customerIndex]
                            //           [ModelInfo.customerPhoneKey]
                            //               .toString()),
                            //         ],
                            //       ),
                            //       Row(
                            //         children: [
                            //           const Text(
                            //             'CNIC : ',
                            //             style: TextStyle(
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //           Text(widget.customers[customerIndex]
                            //           [ModelInfo.customerCNICKey]
                            //               .toString()),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            CustomWidget.customRow(
                                title: 'Name  : ',
                                value: widget.customers[customerIndex]
                                        [ModelCustomerInfo.customerNameKey]
                                    .toString()),
                            // Flexible(
                            //   flex: 4,
                            //   child: Column(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceEvenly,
                            //     children: [
                            //       Row(
                            //         children: [
                            //           const Text(
                            //             'Total Price : ',
                            //             style: TextStyle(
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //           Text(widget.customers[customerIndex]
                            //                   [ModelInfo.grandPriceKey]
                            //               .toString()),
                            //         ],
                            //       ),
                            //       Row(
                            //         children: [
                            //           const Text(
                            //             'Remaining Price : ',
                            //             style: TextStyle(
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //           Text(widget.customers[customerIndex]
                            //                   [ModelInfo.remainingPriceKey]
                            //               .toString()),
                            //         ],
                            //       ),
                            //       Row(
                            //         children: [
                            //           const Text(
                            //             'Monthly Installment : ',
                            //             style: TextStyle(
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //           Text(widget.customers[customerIndex]
                            //                   [ModelInfo.monthlyInstallmentKey]
                            //               .toString()),
                            //         ],
                            //       ),
                            //       Row(
                            //         children: [
                            //           const Text(
                            //             'Advance Price : ',
                            //             style: TextStyle(
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //           Text(widget.customers[customerIndex]
                            //                   [ModelInfo.advancePriceKey]
                            //               .toString()),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            CustomWidget.customRow(
                                title: 'Phone Number  : ',
                                value: widget.customers[customerIndex]
                                        [ModelCustomerInfo.customerPhoneKey]
                                    .toString()),
                            CustomWidget.customRow(
                                title: 'CNIC Number  : ',
                                value: widget.customers[customerIndex]
                                        [ModelCustomerInfo.customerCNICKey]
                                    .toString()),
                            CustomWidget.customRow(
                                title: 'Total price  : ',
                                value: widget.customers[customerIndex]
                                        [ModelCustomerInfo.grandPriceKey]
                                    .toString()),
                            CustomWidget.customRow(
                                title: 'Remaining Price  : ',
                                value: widget.customers[customerIndex]
                                        [ModelCustomerInfo.remainingPriceKey]
                                    .toString()),
                            CustomWidget.customRow(
                                title: 'Monthly Installment  : ',
                                value: widget.customers[customerIndex][
                                        ModelCustomerInfo.monthlyInstallmentKey]
                                    .toString()),
                            CustomWidget.customRow(
                                title: 'Advance Price : ',
                                value: widget.customers[customerIndex]
                                        [ModelCustomerInfo.advancePriceKey]
                                    .toString()),
                            CustomWidget.customRow(
                                title: 'Employee Name  : ',
                                value: widget.customers[customerIndex]
                                        [ModelCustomerInfo.empNameKey]
                                    .toString()),
                            CustomWidget.customRow(
                                title: 'Reference Number  : ',
                                value: widget.customers[customerIndex]
                                        [ModelCustomerInfo.empRefKey]
                                    .toString()),

                            Flexible(
                                flex: 4,
                                child: Align(
                                    alignment: Alignment.center,
                                    child:
                                        (widget.customers[customerIndex][
                                                            ModelCustomerInfo
                                                                .empNameKey]
                                                        .toString() ==
                                                    '') &&
                                                widget.customers[customerIndex][
                                                            ModelCustomerInfo
                                                                .empRefKey]
                                                        .toString() ==
                                                    ''
                                            ? TextButton(
                                                onPressed: () async {
                                                  await showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        Center(
                                                      child: Material(
                                                        child: Container(
                                                          width: 400,
                                                          height: 500,
                                                          color: Colors.white,
                                                          child: Center(
                                                            child:
                                                                FutureBuilder(
                                                              future:
                                                                  Hive.openBox(
                                                                      'Employee'),
                                                              builder: (BuildContext
                                                                      context,
                                                                  AsyncSnapshot<
                                                                          Box<dynamic>>
                                                                      empSnapshot) {
                                                                if (empSnapshot
                                                                    .hasData) {
                                                                  return ListView
                                                                      .builder(
                                                                    itemCount: empSnapshot
                                                                        .data!
                                                                        .values
                                                                        .toList()
                                                                        .length,
                                                                    itemBuilder: (context,
                                                                            index) =>
                                                                        Center(
                                                                            child:
                                                                                Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.black,
                                                                            border: Border.all(color: Colors.black),
                                                                            borderRadius: BorderRadius.circular(5)),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              widget.customers[customerIndex][ModelCustomerInfo.empRefKey] = empSnapshot.data!.values.toList()[index][ModelEmployee.employeeReferenceNoKey].toString();
                                                                              widget.customers[customerIndex][ModelCustomerInfo.empNameKey] = empSnapshot.data!.values.toList()[index][ModelEmployee.employeeNameKey].toString();

                                                                              var localDataBase = await Hive.openBox(ConstValue.customerTableName);
                                                                              localDataBase.put(widget.customers[customerIndex][ModelCustomerInfo.regNoKey], widget.customers[customerIndex]);

                                                                              if (mounted) {
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                              }
                                                                            },
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    const Text(
                                                                                      'Name : ',
                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                    Text(empSnapshot.data!.values.toList()[index][ModelEmployee.employeeNameKey].toString()),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    const Text(
                                                                                      'Reference No : ',
                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                    Text(empSnapshot.data!.values.toList()[index][ModelEmployee.employeeReferenceNoKey].toString()),
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )),
                                                                  );
                                                                } else {
                                                                  return const CircularProgressIndicator();
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );

                                                  setState(() {});
                                                },
                                                child: const Text(
                                                    'Select category'),
                                              )
                                            : Row(
                                                children: [
                                                  Flexible(
                                                    flex: 7,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'Employee Name : ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(widget
                                                                .customers[
                                                                    customerIndex]
                                                                    [
                                                                    ModelCustomerInfo
                                                                        .empNameKey]
                                                                .toString()),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'Reference Number : ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(widget
                                                                .customers[
                                                                    customerIndex]
                                                                    [
                                                                    ModelCustomerInfo
                                                                        .empRefKey]
                                                                .toString()),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  TextButton(
                                                      onPressed: () async {
                                                        await showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              Center(
                                                            child: Material(
                                                              child: Container(
                                                                width: 400,
                                                                height: 500,
                                                                color: Colors
                                                                    .white,
                                                                child: Center(
                                                                  child:
                                                                      FutureBuilder(
                                                                    future: Hive
                                                                        .openBox(
                                                                            'Employee'),
                                                                    builder: (BuildContext
                                                                            context,
                                                                        AsyncSnapshot<Box<dynamic>>
                                                                            empSnapshot) {
                                                                      if (empSnapshot
                                                                          .hasData) {
                                                                        return ListView
                                                                            .builder(
                                                                          itemCount: empSnapshot
                                                                              .data!
                                                                              .values
                                                                              .toList()
                                                                              .length,
                                                                          itemBuilder: (context, index) => Center(
                                                                              child: Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Container(
                                                                              alignment: Alignment.center,
                                                                              decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(5)),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: InkWell(
                                                                                  onTap: () async {
                                                                                    widget.customers[customerIndex][ModelCustomerInfo.empRefKey] = empSnapshot.data!.values.toList()[index][ModelEmployee.employeeReferenceNoKey].toString();
                                                                                    widget.customers[customerIndex][ModelCustomerInfo.empNameKey] = empSnapshot.data!.values.toList()[index][ModelEmployee.employeeNameKey].toString();

                                                                                    var localDataBase = await Hive.openBox(ConstValue.customerTableName);
                                                                                    localDataBase.put(widget.customers[customerIndex][ModelCustomerInfo.regNoKey], widget.customers[customerIndex]);

                                                                                    if (mounted) {
                                                                                      Navigator.pop(context);
                                                                                      setState(() {});
                                                                                    }
                                                                                  },
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          const Text(
                                                                                            'Name : ',
                                                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                                                          ),
                                                                                          Text(empSnapshot.data!.values.toList()[index][ModelEmployee.employeeNameKey].toString()),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          const Text(
                                                                                            'Reference No : ',
                                                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                                                          ),
                                                                                          Text(empSnapshot.data!.values.toList()[index][ModelEmployee.employeeReferenceNoKey].toString()),
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )),
                                                                        );
                                                                      } else {
                                                                        return const CircularProgressIndicator();
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );

                                                        setState(() {});
                                                      },
                                                      child: const Text(
                                                          'Change Category'))
                                                ],
                                              )))
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
