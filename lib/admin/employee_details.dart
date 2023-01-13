import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financeproject/model/model_employee_info.dart';
import 'package:financeproject/util/DbHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EmployeeDetails extends StatefulWidget {
  const EmployeeDetails({Key? key}) : super(key: key);

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Employee Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: DbHandler.EmployeeCollection().snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> doc = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
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
                                  DbHandler.EmployeeCollection()
                                      .doc(snapshot.data!.docs[index].id)
                                      .delete();

                                  setState(() {});
                                },
                                backgroundColor: Colors.red,
                                spacing: 6,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: Platform.isAndroid
                              ? Container(
                                  alignment: Alignment.center,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Name : ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(doc[ModelEmployee
                                                    .employeeNameKey]
                                                .toString()),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Phone No : ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(doc[ModelEmployee
                                                    .employeePhoneNoKey]
                                                .toString()),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'CNIC : ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(doc[ModelEmployee
                                                    .employeeCNICKey]
                                                .toString()),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Reference No : ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(doc[ModelEmployee
                                                    .employeeReferenceNoKey]
                                                .toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Flexible(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Name : ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(doc[ModelEmployee
                                                          .employeeNameKey]
                                                      .toString()),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Phone No : ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(doc[ModelEmployee
                                                          .employeePhoneNoKey]
                                                      .toString()),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    'CNIC : ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(doc[ModelEmployee
                                                          .employeeCNICKey]
                                                      .toString()),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Reference No : ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(doc[ModelEmployee
                                                          .employeeReferenceNoKey]
                                                      .toString()),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
