import 'package:expense_tracker/features/auth/screens/signup_screen.dart';
import 'package:expense_tracker/features/main/screens/home_screen.dart';
import 'package:expense_tracker/features/main/widgets/bottom_nav.dart';
import 'package:expense_tracker/manager/screens/add_transaction.dart';
import 'package:flutter/material.dart';

import 'features/auth/screens/signin_screen.dart';
import 'manager/screens/add_expense.dart';
import 'manager/screens/add_income.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignupScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SignupScreen());
    case BottomBar.routeName:
      var id = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => BottomBar(
                uid: id,
              ));
    case SigninScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SigninScreen());
    case AddTransactionScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const AddTransactionScreen());
    case AddExpenseScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddExpenseScreen());
    case AddIncomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddIncomeScreen());
    case HomeScreen.routeName:
      var id = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => HomeScreen(
                uid: id,
              ));

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Screen does not exist"),
          ),
        ),
      );
  }
}
