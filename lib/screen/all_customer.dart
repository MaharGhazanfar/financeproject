import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financeproject/model/model_info.dart';
import 'package:financeproject/util/DbHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../model/model_employee_info.dart';
import '../widget/custom_textfield.dart';

class ALLCustomer extends StatefulWidget {
  const ALLCustomer({Key? key}) : super(key: key);

  @override
  State<ALLCustomer> createState() => _ALLCustomerState();
}

class _ALLCustomerState extends State<ALLCustomer> {
  List customerFilterList = [];
  List<Map<String, dynamic>> customerList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    controller: searchController,
                    style: TextStyle(color: Colors.white70),
                    decoration: const InputDecoration(
                      constraints: BoxConstraints(maxHeight: 50),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      hintText:
                          'Enter Registration and Employee Reference Number',
                      hintStyle: TextStyle(color: Colors.white),
                      label: Text(
                        'Search',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: DbHandler.customerCollection().snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> customerSnapshot) {
                  if (customerSnapshot.hasData) {
                    return ListView.builder(
                      itemCount: customerSnapshot.data!.docs.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, customerIndex) {
                        Map<String, dynamic> doc =
                            customerSnapshot.data!.docs[customerIndex].data()
                                as Map<String, dynamic>;
                        return searchController.text.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Slidable(
                                    endActionPane: ActionPane(
                                      motion: const StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          flex: 1,
                                          onPressed: (context) async {
                                            if (DbHandler.user != null) {
                                              DbHandler.customerCollection()
                                                  .doc(customerSnapshot.data!
                                                      .docs[customerIndex].id)
                                                  .delete();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Deleted Successfully'),
                                                backgroundColor: Colors.green,
                                              ));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content:
                                                    Text('Your not allowed'),
                                                backgroundColor: Colors.green,
                                              ));
                                            }
                                          },
                                          backgroundColor: Colors.red,
                                          spacing: 6,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 220,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.green),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CustomWidget.customRow(
                                                title:
                                                    'Registration Number  : ',
                                                value: doc[ModelCustomerInfo
                                                        .regNoKey]
                                                    .toString()),
                                            CustomWidget.customRow(
                                                title: 'Name  : ',
                                                value: doc[ModelCustomerInfo
                                                        .customerNameKey]
                                                    .toString()),
                                            CustomWidget.customRow(
                                                title: 'Phone Number  : ',
                                                value: doc[ModelCustomerInfo
                                                        .customerPhoneKey]
                                                    .toString()),
                                            CustomWidget.customRow(
                                                title: 'CNIC Number  : ',
                                                value: doc[ModelCustomerInfo
                                                        .customerCNICKey]
                                                    .toString()),
                                            CustomWidget.customRow(
                                                title: 'Total price  : ',
                                                value: doc[ModelCustomerInfo
                                                        .grandPriceKey]
                                                    .toString()),
                                            CustomWidget.customRow(
                                                title: 'Remaining Price  : ',
                                                value: doc[ModelCustomerInfo
                                                        .remainingPriceKey]
                                                    .toString()),
                                            CustomWidget.customRow(
                                                title:
                                                    'Monthly Installment  : ',
                                                value: doc[ModelCustomerInfo
                                                        .monthlyInstallmentKey]
                                                    .toString()),
                                            CustomWidget.customRow(
                                                title: 'Advance Price : ',
                                                value: doc[ModelCustomerInfo
                                                        .advancePriceKey]
                                                    .toString()),
                                            CustomWidget.customRow(
                                                title: 'Employee Name  : ',
                                                value: doc[ModelCustomerInfo
                                                        .empNameKey]
                                                    .toString()),
                                            CustomWidget.customRow(
                                                title: 'Reference Number  : ',
                                                value: doc[ModelCustomerInfo
                                                        .empRefKey]
                                                    .toString()),
                                            DbHandler.user != null
                                                ? Flexible(
                                                    flex: 4,
                                                    child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: TextButton(
                                                          onPressed: () async {
                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      Center(
                                                                child: Material(
                                                                  child:
                                                                      Container(
                                                                    width: 400,
                                                                    height: 500,
                                                                    color: Colors
                                                                        .white,
                                                                    child:
                                                                        Center(
                                                                      child: StreamBuilder<
                                                                          QuerySnapshot>(
                                                                        stream:
                                                                            DbHandler.EmployeeCollection().snapshots(),
                                                                        builder: (BuildContext
                                                                                context,
                                                                            AsyncSnapshot<QuerySnapshot>
                                                                                empSnapshot) {
                                                                          // if (empSnapshot
                                                                          //         .data!
                                                                          //         .size ==
                                                                          //     0) {
                                                                          //   return Text(
                                                                          //       'There is no employee added');
                                                                          // } else
                                                                          if (empSnapshot
                                                                              .hasData) {
                                                                            return ListView.builder(
                                                                              itemCount: empSnapshot.data!.docs.length,
                                                                              itemBuilder: (context, index) {
                                                                                Map<String, dynamic> empDoc = empSnapshot.data!.docs[index].data() as Map<String, dynamic>;
                                                                                return Center(
                                                                                    child: Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Container(
                                                                                    alignment: Alignment.center,
                                                                                    decoration: BoxDecoration(color: Colors.black, border: Border.all(color: Colors.green), borderRadius: BorderRadius.circular(5)),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: InkWell(
                                                                                        onTap: () async {
                                                                                          DbHandler.customerCollection().doc(doc[ModelCustomerInfo.regNoKey]).update({
                                                                                            ModelCustomerInfo.empNameKey: empDoc[ModelEmployee.employeeNameKey],
                                                                                            ModelCustomerInfo.empRefKey: empDoc[ModelEmployee.employeeReferenceNoKey]
                                                                                          });
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: Column(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          children: [
                                                                                            Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                const Text(
                                                                                                  'Name : ',
                                                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                                                                ),
                                                                                                Text(empDoc[ModelEmployee.employeeNameKey].toString()),
                                                                                              ],
                                                                                            ),
                                                                                            Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                const Text(
                                                                                                  'Reference No : ',
                                                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                                                                ),
                                                                                                Text(empDoc[ModelEmployee.employeeReferenceNoKey].toString()),
                                                                                              ],
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ));
                                                                              },
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
                                                          child: Text((doc[ModelCustomerInfo
                                                                              .empNameKey]
                                                                          .toString() ==
                                                                      '') &&
                                                                  (doc[ModelCustomerInfo
                                                                              .empRefKey]
                                                                          .toString() ==
                                                                      '')
                                                              ? 'Select Employee'
                                                              : 'Change Employee'),
                                                        )))
                                                : SizedBox()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : (doc[ModelCustomerInfo.regNoKey]
                                        .toLowerCase()
                                        .contains(searchController.text
                                            .toLowerCase()) ||
                                    doc[ModelCustomerInfo.empRefKey]
                                        .toLowerCase()
                                        .contains(searchController.text
                                            .toLowerCase()))
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Slidable(
                                        endActionPane: ActionPane(
                                          motion: const StretchMotion(),
                                          children: [
                                            SlidableAction(
                                              flex: 1,
                                              onPressed: (context) async {
                                                DbHandler.customerCollection()
                                                    .doc(customerSnapshot.data!
                                                        .docs[customerIndex].id)
                                                    .delete();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Deleted Successfully'),
                                                  backgroundColor: Colors.green,
                                                ));
                                              },
                                              backgroundColor: Colors.red,
                                              spacing: 6,
                                              icon: Icons.delete,
                                              label: 'Delete',
                                            ),
                                          ],
                                        ),
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 220,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.green),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                CustomWidget.customRow(
                                                    title:
                                                        'Registration Number  : ',
                                                    value: doc[ModelCustomerInfo
                                                            .regNoKey]
                                                        .toString()),
                                                CustomWidget.customRow(
                                                    title: 'Name  : ',
                                                    value: doc[ModelCustomerInfo
                                                            .customerNameKey]
                                                        .toString()),
                                                CustomWidget.customRow(
                                                    title: 'Phone Number  : ',
                                                    value: doc[ModelCustomerInfo
                                                            .customerPhoneKey]
                                                        .toString()),
                                                CustomWidget.customRow(
                                                    title: 'CNIC Number  : ',
                                                    value: doc[ModelCustomerInfo
                                                            .customerCNICKey]
                                                        .toString()),
                                                CustomWidget.customRow(
                                                    title: 'Total price  : ',
                                                    value: doc[ModelCustomerInfo
                                                            .grandPriceKey]
                                                        .toString()),
                                                CustomWidget.customRow(
                                                    title:
                                                        'Remaining Price  : ',
                                                    value: doc[ModelCustomerInfo
                                                            .remainingPriceKey]
                                                        .toString()),
                                                CustomWidget.customRow(
                                                    title:
                                                        'Monthly Installment  : ',
                                                    value: doc[ModelCustomerInfo
                                                            .monthlyInstallmentKey]
                                                        .toString()),
                                                CustomWidget.customRow(
                                                    title: 'Advance Price : ',
                                                    value: doc[ModelCustomerInfo
                                                            .advancePriceKey]
                                                        .toString()),
                                                CustomWidget.customRow(
                                                    title: 'Employee Name  : ',
                                                    value: doc[ModelCustomerInfo
                                                            .empNameKey]
                                                        .toString()),
                                                CustomWidget.customRow(
                                                    title:
                                                        'Reference Number  : ',
                                                    value: doc[ModelCustomerInfo
                                                            .empRefKey]
                                                        .toString()),
                                                DbHandler.user != null
                                                    ? Flexible(
                                                        flex: 4,
                                                        child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: TextButton(
                                                              onPressed:
                                                                  () async {
                                                                await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          Center(
                                                                    child:
                                                                        Material(
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            400,
                                                                        height:
                                                                            500,
                                                                        color: Colors
                                                                            .white,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              StreamBuilder<QuerySnapshot>(
                                                                            stream:
                                                                                DbHandler.EmployeeCollection().snapshots(),
                                                                            builder:
                                                                                (BuildContext context, AsyncSnapshot<QuerySnapshot> empSnapshot) {
                                                                              // if (empSnapshot
                                                                              //         .data!
                                                                              //         .size ==
                                                                              //     0) {
                                                                              //   return Text(
                                                                              //       'There is no employee added');
                                                                              // } else
                                                                              if (empSnapshot.hasData) {
                                                                                return ListView.builder(
                                                                                  itemCount: empSnapshot.data!.docs.length,
                                                                                  itemBuilder: (context, index) {
                                                                                    Map<String, dynamic> empDoc = empSnapshot.data!.docs[index].data() as Map<String, dynamic>;
                                                                                    return Center(
                                                                                        child: Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Container(
                                                                                        alignment: Alignment.center,
                                                                                        decoration: BoxDecoration(color: Colors.black, border: Border.all(color: Colors.green), borderRadius: BorderRadius.circular(5)),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: InkWell(
                                                                                            onTap: () async {
                                                                                              DbHandler.customerCollection().doc(doc[ModelCustomerInfo.regNoKey]).update({
                                                                                                ModelCustomerInfo.empNameKey: empDoc[ModelEmployee.employeeNameKey],
                                                                                                ModelCustomerInfo.empRefKey: empDoc[ModelEmployee.employeeReferenceNoKey]
                                                                                              });
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                            child: Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                  children: [
                                                                                                    const Text(
                                                                                                      'Name : ',
                                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                                    ),
                                                                                                    Text(empDoc[ModelEmployee.employeeNameKey].toString()),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                  children: [
                                                                                                    const Text(
                                                                                                      'Reference No : ',
                                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                                    ),
                                                                                                    Text(empDoc[ModelEmployee.employeeReferenceNoKey].toString()),
                                                                                                  ],
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ));
                                                                                  },
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
                                                              child: Text((doc[ModelCustomerInfo.empNameKey]
                                                                              .toString() ==
                                                                          '') &&
                                                                      (doc[ModelCustomerInfo.empRefKey]
                                                                              .toString() ==
                                                                          '')
                                                                  ? 'Select Employee'
                                                                  : 'Change Employee'),
                                                            )))
                                                    : SizedBox()
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox();
                      },
                    );
                  } else {
                    return Center(child: const CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

// getSearchList(String value) {
//   List<Map<String, dynamic>> tempList = [];
//   for (Map<String, dynamic> element in customerList) {
//     if (element[ModelCustomerInfo.regNoKey]
//             .toString()
//             .toLowerCase()
//             .contains(value.toLowerCase()) ||
//         element[ModelCustomerInfo.empRefKey]
//             .toString()
//             .toLowerCase()
//             .contains(value.toLowerCase())) {
//       tempList.add(element);
//     }
//   }
//   customerFilterList = tempList;
// }
}
