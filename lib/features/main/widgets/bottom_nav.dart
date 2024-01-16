// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expense_tracker/constants/global_variables.dart';
import 'package:expense_tracker/features/main/screens/budget_saver_scree.dart';

import 'package:expense_tracker/features/main/screens/profile_screen.dart';
import 'package:expense_tracker/features/main/screens/transaction_screen.dart';
import 'package:expense_tracker/manager/screens/add_expense.dart';
import 'package:expense_tracker/manager/screens/add_income.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:expense_tracker/features/main/screens/home_screen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/bottom';
  final String uid;
  const BottomBar({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      // Your pages go here
      // Example:
      HomeScreen(uid: widget.uid),
      const AllTransactions(),
      const Center(),
      const BudgetSaverScreen(),
      ProfilePage(uid: widget.uid)
    ];
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: GlobalVariables.voilet,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(fontSize: 13),
        selectedLabelStyle: const TextStyle(fontSize: 13),
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        onTap: (index) {
          if (index != 2) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/home_grey.svg'),
            activeIcon: SvgPicture.asset('assets/images/home.svg'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/transaction_grey.svg'),
            activeIcon: SvgPicture.asset('assets/images/transaction.svg'),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 1,
                color: Colors.transparent,
              ),
              label: ''),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/budget_grey.svg'),
            activeIcon: SvgPicture.asset('assets/images/budget.svg'),
            label: 'Budget',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/profile_grey.svg'),
            activeIcon: SvgPicture.asset('assets/images/profile.svg'),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          elevation: 0,
          onPressed: () {
            showOptionsPopup(context);
          },
          backgroundColor: GlobalVariables.voilet,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void showOptionsPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                title: Text('Add Income'),
                onTap: () {
                  // Handle Option One
                  Navigator.pushNamed(
                      context, AddIncomeScreen.routeName); // Close the modal
                  // Do something for Option One
                },
              ),
              ListTile(
                title: Text('Add Expense'),
                onTap: () {
                  // Handle Option Two
                  Navigator.pushNamed(
                      context, AddExpenseScreen.routeName); // Close the modal
                  // Do something for Option Two
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
