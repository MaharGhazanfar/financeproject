import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:financeproject/admin/add_employee.dart';
import 'package:financeproject/screen/all_customer.dart';
import 'package:financeproject/screen/search_customer.dart';
import 'package:financeproject/util/DbHandler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarForUser extends StatefulWidget {
  int currentIndex;

  BottomNavigationBarForUser({Key? key, this.currentIndex = 0})
      : super(
          key: key,
        );

  @override
  _BottomNavigationBarForUserState createState() =>
      _BottomNavigationBarForUserState();
}

class _BottomNavigationBarForUserState
    extends State<BottomNavigationBarForUser> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.currentIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('${widget.currentIndex}///////////cureent index is ');
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black87,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          SearchCustomer(),
          ALLCustomer(),
          DbHandler.user != null ? ADDEmployee() : SizedBox()
        ],
      ),
      bottomNavigationBar: DbHandler.user != null
          ? _buildTitleForAdmin()
          : _buildTitleForEmployee(),
    );
  }

/////////////////
  Widget _buildTitleForAdmin() {
    return Container(
      decoration: BoxDecoration(color: Colors.green),
      child: Padding(
        padding: const EdgeInsets.only(top: 0.5),
        child: CustomNavigationBar(
          scaleFactor: 0.2,
          iconSize: 30.0,
          elevation: 5,
          selectedColor: Colors.green,
          strokeColor: Colors.greenAccent,
          unSelectedColor: Colors.white,
          backgroundColor: Colors.black,
          opacity: 1,
          items: [
            CustomNavigationBarItem(
              icon: const Icon(Icons.explore_outlined),
              // title: const Text(
              //   "Explore",
              //   // style: CustomColors.normalTextStyleWithWhiteColor(context)
              // ),
            ),
            CustomNavigationBarItem(
              icon: const Icon(Icons.dashboard_customize_outlined),
              // title: const Text(
              //   "Favourite",
              //   // style: CustomColors.normalTextStyleWithWhiteColor(context)
              // ),
            ),
            CustomNavigationBarItem(
              icon: const Icon(CupertinoIcons.person),
              // title: const Text(
              //   "Chat Now",
              //   // style: CustomColors.normalTextStyleWithWhiteColor(context)
              // ),
            ),
          ],
          currentIndex: widget.currentIndex,
          onTap: (index) {
            setState(() {
              widget.currentIndex = index;
            });
            pageController.animateToPage(widget.currentIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn);
          },
        ),
      ),
    );
  }

  Widget _buildTitleForEmployee() {
    return Container(
      decoration: BoxDecoration(color: Colors.green),
      child: Padding(
        padding: const EdgeInsets.only(top: 0.5),
        child: CustomNavigationBar(
          scaleFactor: 0.2,
          iconSize: 30.0,
          elevation: 5,
          selectedColor: Colors.green,
          strokeColor: Colors.greenAccent,
          unSelectedColor: Colors.white,
          backgroundColor: Colors.black,
          opacity: 1,
          items: [
            CustomNavigationBarItem(
              icon: const Icon(Icons.explore_outlined),
              // title: const Text(
              //   "Explore",
              //   // style: CustomColors.normalTextStyleWithWhiteColor(context)
              // ),
            ),
            CustomNavigationBarItem(
              icon: const Icon(Icons.dashboard_customize_outlined),
              // title: const Text(
              //   "Favourite",
              //   // style: CustomColors.normalTextStyleWithWhiteColor(context)
              // ),
            ),
            // CustomNavigationBarItem(
            //   icon: const Icon(CupertinoIcons.person),
            //   // title: const Text(
            //   //   "Chat Now",
            //   //   // style: CustomColors.normalTextStyleWithWhiteColor(context)
            //   // ),
            // ),
          ],
          currentIndex: widget.currentIndex,
          onTap: (index) {
            setState(() {
              widget.currentIndex = index;
            });
            pageController.animateToPage(widget.currentIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn);
          },
        ),
      ),
    );
  }
}
