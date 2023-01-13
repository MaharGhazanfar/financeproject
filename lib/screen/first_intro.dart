import 'package:financeproject/screen/login_Page.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../util/const_value.dart';

class FirstIntro extends StatefulWidget {
  const FirstIntro({Key? key}) : super(key: key);

  @override
  State<FirstIntro> createState() => _FirstIntroState();
}

class _FirstIntroState extends State<FirstIntro> {
  late RiveAnimationController _controller;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = OneShotAnimation(
      'flip',
      autoplay: true,
      onStop: () => setState(() => isPlaying = false),
      onStart: () => setState(() => isPlaying = true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        RiveAnimation.asset(
          'assets/book_flip.riv',
          fit: BoxFit.fill,
          controllers: [_controller],
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: MediaQuery.of(context).size.height * .65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LoginPage(userStatus: ConstValue.admin),
                        )),
                    child: getButton(name: 'Admin')),
              )),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(
                                userStatus: ConstValue.employeeCollectionName),
                          ));
                    },
                    child: getButton(name: 'Employee')),
              )),
            ],
          ),
        ),
      ],
    ));
  }

  Widget getButton({required String name}) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 2),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Container(
            height: 50,
            width: 120,
            decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(color: Colors.black12, width: 3),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, offset: Offset(-3, 3))
                ]),
            alignment: Alignment.center,
            child: Text(
              name,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }
}
