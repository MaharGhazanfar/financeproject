import 'package:financeproject/model/model_admin_login_info.dart';
import 'package:flutter/material.dart';

import '../util/DbHandler.dart';
import '../widget/custom_textfield.dart';
import 'bottom_navigationBar_screen.dart';

class EmailLoginPage extends StatefulWidget {
  const EmailLoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<EmailLoginPage> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  bool _isObscure = true;
  bool isLoading = false;
  double opacity = 1;
  var globalKey = GlobalKey<FormState>();
  double? width;
  double? height;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'SignUp',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              AnimatedOpacity(
                opacity: 0.5,
                duration: Duration(milliseconds: 500),
                child: Form(
                  key: globalKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        SizedBox(
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: CustomWidget.customTextFormField(
                                titleName: 'Name',
                                controller: nameController,
                                textInputType: TextInputType.text,
                                validate: (value) {
                                  if (value!.isNotEmpty) {
                                    return null;
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
                                titleName: 'Phone Number',
                                controller: phoneController,
                                textInputType: TextInputType.phone,
                                maxLength: 11,
                                validate: (value) {
                                  if (value!.isNotEmpty) {
                                    if (value.length == 11) {
                                      return null;
                                    } else {
                                      return 'InValid phone Number';
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
                                titleName: 'Email',
                                controller: emailController,
                                textInputType: TextInputType.emailAddress,
                                validate: (value) {
                                  if (value!.isNotEmpty) {
                                    if (value.contains('@gmail.com') ||
                                        value.contains('@yahoo.com')) {
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
                              textInputType: TextInputType.visiblePassword,
                              controller: passwordController,
                              validate: (value) {
                                if (value!.isNotEmpty) {
                                  if (value.length == 8) {
                                    return null;
                                  } else {
                                    return 'Password Must be 8 characters';
                                  }
                                } else {
                                  return 'required';
                                }
                              },
                              suffix: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
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
                                      print('$_isObscure/////////////////');
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: CustomWidget.customTextFormField(
                              titleName: 'ConfirmPassword',
                              obscureText: _isObscure,
                              textInputType: TextInputType.visiblePassword,
                              controller: confirmPasswordController,
                              validate: (value) {
                                if (value!.isNotEmpty) {
                                  if (value.toString() ==
                                      passwordController.text.toString()) {
                                    return null;
                                  } else {
                                    return 'Password Not Match';
                                  }
                                } else {
                                  return 'required';
                                }
                              },
                              suffix: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
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
                                      print('$_isObscure/////////////////');
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
                              var status = await SignUpWithEmailPas(
                                  password: passwordController.text.toString(),
                                  email: emailController.text.toString());
                              setState(() {
                                isLoading = true;
                                opacity = 0.5;
                              });
                              var modelLoginInfo = ModelLoginInfo(
                                  adminName: nameController.text,
                                  adminPhoneNo: phoneController.text,
                                  adminEmail: emailController.text);
                              if (status == 'Login Successful') {
                                DbHandler.adminCollection()
                                    .doc(DbHandler.user!.uid)
                                    .set(modelLoginInfo.toMap());
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    status,
                                  ),
                                  backgroundColor: Colors.green,
                                ));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BottomNavigationBarForUser(),
                                    ));
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.06),
                                          offset: const Offset(
                                            0,
                                            2,
                                          ),
                                          spreadRadius: 3,
                                          blurRadius: 1),
                                    ]),
                                child: Text(
                                  'Create Account',
                                )),
                          ),
                        )
                      ],
                    ),
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
