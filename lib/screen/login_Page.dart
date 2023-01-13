import 'package:financeproject/screen/email_login_page.dart';
import 'package:financeproject/util/DbHandler.dart';
import 'package:financeproject/util/const_value.dart';
import 'package:financeproject/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/model_employee_info.dart';
import 'bottom_navigationBar_screen.dart';

class LoginPage extends StatefulWidget {
  final userStatus;

  const LoginPage({Key? key, required this.userStatus}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final globalKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool isLoading = false;
  double opacity = 1;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Login',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                AnimatedOpacity(
                  opacity: opacity,
                  duration: Duration(milliseconds: 500),
                  child: widget.userStatus == ConstValue.admin
                      ? Form(
                          key: globalKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                              ),
                              SizedBox(
                                height: 80,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: CustomWidget.customTextFormField(
                                      titleName: 'Email',
                                      controller: emailController,
                                      textInputType: TextInputType.emailAddress,
                                      validate: (value) {
                                        if (value!.isNotEmpty) {
                                          if (value.contains('@gmail.com')) {
                                            return null;
                                          } else {
                                            return 'InValid gmail';
                                          }
                                        } else {
                                          return 'required';
                                        }
                                      }),
                                ),
                              ),
                              SizedBox(
                                height: 80,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: CustomWidget.customTextFormField(
                                    titleName: 'Password',
                                    obscureText: _isObscure,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    controller: passwordController,
                                    validate: (value) {
                                      if (value!.isNotEmpty) {
                                        return null;
                                      } else {
                                        return 'required';
                                      }
                                    },
                                    suffix: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: IconButton(
                                        icon: Icon(
                                          _isObscure
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (globalKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                      opacity = 0.5;
                                    });
                                    var status = await signInWithEmail(
                                        password: passwordController.text,
                                        email: emailController.text);
                                    setState(() {
                                      isLoading = false;
                                      opacity = 1;
                                    });
                                    if (status == 'Login Successful') {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNavigationBarForUser()),
                                          (Route<dynamic> route) => false);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          status,
                                        ),
                                        backgroundColor: Colors.green,
                                      ));
                                    }
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 24.0),
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.06),
                                                offset: const Offset(
                                                  0,
                                                  2,
                                                ),
                                                spreadRadius: 3,
                                                blurRadius: 1),
                                          ]),
                                      child: Text('Login',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))),
                                ),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("Don't have account?"),
                                    TextButton(
                                        onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const EmailLoginPage(),
                                            )),
                                        child: Text(
                                          'Sign up',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ))
                                  ])
                            ],
                          ),
                        )
                      : Form(
                          key: globalKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                              ),
                              SizedBox(
                                height: 80,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: CustomWidget.customTextFormField(
                                      titleName: 'CNIC',
                                      controller: emailController,
                                      textInputType: TextInputType.number,
                                      maxLength: 13,
                                      validate: (value) {
                                        if (value!.isNotEmpty) {
                                          if (value.length == 13) {
                                            return null;
                                          } else {
                                            return 'CNIC must be 13 digits';
                                          }
                                        } else {
                                          return 'required';
                                        }
                                      }),
                                ),
                              ),
                              SizedBox(
                                height: 80,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: CustomWidget.customTextFormField(
                                    titleName: 'Reference No',
                                    obscureText: _isObscure,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    controller: passwordController,
                                    validate: (value) {
                                      if (value!.isNotEmpty) {
                                        // if (value.toString() ==
                                        //     passwordController.text.toString()) {
                                        //   return null;
                                        // } else {
                                        //   return 'Password Not Match';
                                        // }
                                        return null;
                                      } else {
                                        return 'required';
                                      }
                                    },
                                    suffix: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: IconButton(
                                        icon: Icon(
                                          _isObscure
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                            print(
                                                '$_isObscure/////////////////');
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (globalKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                      opacity = 0.5;
                                    });
                                    var empDocs =
                                        await DbHandler.EmployeeCollection()
                                            .get();
                                    if (empDocs.size != 0) {
                                      var status = false;
                                      for (var element in empDocs.docs) {
                                        var doc = element.data()
                                            as Map<String, dynamic>;
                                        if (doc[ModelEmployee
                                                    .employeeCNICKey] ==
                                                emailController.text &&
                                            doc[ModelEmployee
                                                    .employeeReferenceNoKey] ==
                                                passwordController.text) {
                                          ModelEmployee.info =
                                              await SharedPreferences
                                                  .getInstance();
                                          ModelEmployee.info!.setString(
                                            ConstValue.employeeData,
                                            doc[ModelEmployee.employeeCNICKey],
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                              'Login Successful',
                                            ),
                                            backgroundColor: Colors.green,
                                          ));

                                          Navigator.of(context).pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BottomNavigationBarForUser()),
                                              (Route<dynamic> route) => false);
                                          status = false;
                                          break;
                                        } else {
                                          status = true;
                                        }
                                      }
                                      if (status) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            'No User Found for that CNIC',
                                          ),
                                          backgroundColor: Colors.green,
                                        ));
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          'There is No employee Present',
                                        ),
                                        backgroundColor: Colors.green,
                                      ));
                                    }
                                    setState(() {
                                      isLoading = false;
                                      opacity = 1;
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 24.0),
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.06),
                                                offset: const Offset(
                                                  0,
                                                  2,
                                                ),
                                                spreadRadius: 3,
                                                blurRadius: 1),
                                          ]),
                                      child: Text('Login',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))),
                                ),
                              ),
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
      ),
    );
  }
}
