import 'package:financeproject/admin/employee_details.dart';
import 'package:financeproject/model/model_employee_info.dart';
import 'package:financeproject/util/DbHandler.dart';
import 'package:financeproject/widget/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../util/const_value.dart';

class ADDEmployee extends StatefulWidget {
  const ADDEmployee({Key? key}) : super(key: key);

  @override
  State<ADDEmployee> createState() => _ADDEmployeeState();
}

class _ADDEmployeeState extends State<ADDEmployee> {
  TextEditingController employeeName = TextEditingController();
  TextEditingController employeePhoneNO = TextEditingController();
  TextEditingController employeeCNIC = TextEditingController();
  TextEditingController employeeReferenceNo = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    employeeName.dispose();
    employeeReferenceNo.dispose();
    employeePhoneNO.dispose();
    employeeCNIC.dispose();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Add Employee'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmployeeDetails(),
                    ));
              },
              icon: const Icon(CupertinoIcons.person_2)),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 600 ? 2 : 1,
                        crossAxisSpacing: 16,
                        mainAxisExtent: 70),
                    children: [
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
                          titleName: 'Employee Name',
                          controller: employeeName,
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
                          controller: employeePhoneNO,
                          textInputType: TextInputType.number,
                          maxLength: 11,
                          titleName: 'Employee Phone No',
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
                          controller: employeeCNIC,
                          maxLength: 13,
                          titleName: 'Employee CNIC',
                          textInputType: TextInputType.number,
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
                          controller: employeeReferenceNo,
                          titleName: 'Employee Reference No',
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: ConstValue.buttonHeight,
                      width: ConstValue.buttonWidth,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (globalKey.currentState!.validate()) {
                              var employeeInfo = ModelEmployee(
                                  employeeName: employeeName.text.toString(),
                                  employeeCNIC: employeeCNIC.text.toString(),
                                  employeePhoneNo:
                                      employeePhoneNO.text.toString(),
                                  employeeReferenceNo:
                                      employeeReferenceNo.text.toString());

                              DbHandler.EmployeeCollection()
                                  .doc()
                                  .set(employeeInfo.toMap());

                              setState(() {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Employee Added')));
                              });

                              employeeName.clear();
                              employeeReferenceNo.clear();
                              employeePhoneNO.clear();
                              employeeCNIC.clear();
                            }
                          },
                          child: const Text('ADD')),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
