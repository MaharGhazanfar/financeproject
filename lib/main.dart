import 'package:financeproject/screen/bottom_navigationBar_screen.dart';
import 'package:financeproject/screen/first_intro.dart';
import 'package:financeproject/util/DbHandler.dart';
import 'package:financeproject/util/const_value.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'firebase_options.dart';
import 'model/model_employee_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ModelEmployee.info = await SharedPreferences.getInstance();
  var adminDocs = await DbHandler.adminCollection().get();
  DbHandler.userUid = adminDocs.docs[0].id.toString();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: Typography(platform: TargetPlatform.android).white,
        ),
        home: SplashScreenView(
          navigateRoute:
              ModelEmployee.info!.getString(ConstValue.employeeData) == null
                  ? StreamBuilder(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) => snapshot.hasData
                          ? BottomNavigationBarForUser()
                          : FirstIntro())
                  : BottomNavigationBarForUser(),
          backgroundColor: Colors.black54,
          text: "Installia",
          imageSrc: 'assets/i.png',
          textType: TextType.ColorizeAnimationText,
          colors: const [
            Colors.purple,
            Colors.blue,
            Colors.yellow,
            Colors.red,
          ],
          textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              fontStyle: FontStyle.italic),
          speed: 2,
          pageRouteTransition: PageRouteTransition.Normal,
          duration: 4000,
        ));
  }
}
