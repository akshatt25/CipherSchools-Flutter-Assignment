import 'package:expense_tracker/features/auth/screens/getting_started_screen.dart';
import 'package:expense_tracker/features/auth/services/validation.dart';
import 'package:expense_tracker/features/main/widgets/bottom_nav.dart';

import 'package:expense_tracker/local/save_user.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:expense_tracker/provider/income_provider.dart';
import 'package:expense_tracker/provider/transactions_provider.dart';
import 'package:expense_tracker/provider/user_provider.dart';
import 'package:expense_tracker/router.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  validation();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => IncomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExpenseProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(0, 0, 0, 0),
      statusBarColor: Color.fromARGB(0, 0, 0, 0),
    ));
    return MaterialApp(
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: FutureBuilder(
        future: getUid(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Return a loading screen or widget while waiting for the future
            return const CircularProgressIndicator(); // Replace with your loading widget
          } else {
            if (snapshot.hasError || snapshot.data == null) {
              // Return a screen when there's an error or the data is null
              return GettingStarted(); // Replace with your error screen
            } else {
              return BottomBar(
                  uid: snapshot
                      .data!); // Replace with your screen that uses the uid
            }
          }
        },
      ),
      // const GettingStarted(),
    );
  }
}
