import 'package:expense_tracker/constants/global_variables.dart';
import 'package:expense_tracker/features/auth/services/get_firestore.dart';
import 'package:expense_tracker/features/auth/services/sign_out.dart';
import 'package:expense_tracker/features/main/widgets/bottom_nav.dart';
import 'package:expense_tracker/features/main/widgets/transaction_widget.dart';
import 'package:expense_tracker/manager/screens/add_income.dart';

import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:expense_tracker/provider/income_provider.dart';
import 'package:expense_tracker/view/transaction_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../manager/screens/add_expense.dart';
import '../../../provider/transactions_provider.dart';

class HomeScreen extends StatefulWidget {
  final String uid;
  static const String routeName = '/home';
  const HomeScreen({super.key, required this.uid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedMonth = 'January';
  String currentPeriod = 'Today';
  String amount = '0';
  String income = '0';
  String expense = '0';
  String? username;
  List<NewTransaction> transactionList = [];

  bool notification = false;
  @override
  void initState() {
    // getUsername();
    //
    super.initState();
  }

  // void getUsername() async {
  //   final userData = await getFirestoreData(widget.uid);
  //   username = userData['name'];
  //   print(username);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    income = Provider.of<IncomeProvider>(context).totalIncome;
    expense = Provider.of<ExpenseProvider>(context).totalExpense;
    amount = (int.parse(income) - int.parse(expense)).toString();
    transactionList =
        Provider.of<TransactionProvider>(context).transactionsList;
    transactionList = transactionList.reversed.toList();
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              elevation: 0,
              toolbarHeight: 0,
              backgroundColor: Color(0XFFfdf6e8),
            ),
            SliverToBoxAdapter(
                // expandedHeight: 300,
                // snap: false,
                // pinned: false,
                // floating: false,
                // backgroundColor: Colors.blue,
                child: topPanel()),
            const SliverAppBar(
              elevation: 0,
              pinned: true,
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              flexibleSpace: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Transactions',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    Chip(
                        backgroundColor: GlobalVariables.lightbg,
                        label: Text(
                          'See All',
                          style: TextStyle(
                              fontSize: 16, color: GlobalVariables.voilet),
                        )),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  NewTransaction transaction = transactionList[index];

                  return buildTransactionTile(transaction, index);
                },
                childCount: transactionList.length,
              ),
            )
          ],
        ));
  }

  Widget buildTransactionTile(NewTransaction transaction, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TransactionView(transaction: transaction)));
      },
      child: TransactionTile(
        category: transaction.category,
        amount: transaction.amount,
        details: transaction.details,
        type: transaction.type,
        date: transaction.date,
        time: transaction.time,
        year: transaction.year,
        month: transaction.month,
      ),
    );
  }

  Widget topPanel() {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Color(0XFFfdf6e8),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.purple, width: 1.2),
                          color: Colors.transparent),
                      padding: EdgeInsets.all(1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset('assets/images/user_dp.png'),
                      ),
                    ),
                    DropdownButton<String>(
                      value: selectedMonth,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: GlobalVariables.voilet,
                      ),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                      underline: Container(
                        height: 0,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedMonth = newValue!;
                        });
                      },
                      items: <String>[
                        'January',
                        'February',
                        'March',
                        'April',
                        'May',
                        'June',
                        'July',
                        'August',
                        'September',
                        'October',
                        'November',
                        'December',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Icon(
                      Icons.notifications,
                      color:
                          notification ? GlobalVariables.voilet : Colors.black,
                      size: 30,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Account balance',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '₹$amount',
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  moneyBox(
                      income, 'Income', 'income', AddIncomeScreen.routeName),
                  moneyBox(expense, 'Expenses', 'expense',
                      AddExpenseScreen.routeName),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                periods('Today', currentPeriod),
                periods('Week', currentPeriod),
                periods('Month', currentPeriod),
                periods('Year', currentPeriod),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget periods(String period, value) {
    return GestureDetector(
      onTap: () {
        currentPeriod = period;
        setState(() {});
      },
      child: Chip(
        backgroundColor:
            period == value ? GlobalVariables.lyellow : Colors.white,
        label: Container(
            alignment: Alignment.center,
            width: 75,
            height: 28,
            child: Text(period,
                style: TextStyle(
                    color:
                        period == value ? GlobalVariables.yellow : Colors.grey,
                    fontWeight:
                        period == value ? FontWeight.w900 : FontWeight.w600,
                    fontSize: 15))),
      ),
    );
  }

  Widget moneyBox(String amount, String type, String icon, String route) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        height: 90,
        margin: EdgeInsets.only(left: 10, top: 18, bottom: 18, right: 5),
        decoration: BoxDecoration(
            color: icon == 'income' ? Color(0xFF00a86b) : Color(0xFFfd3c4a),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsets.only(right: 10, left: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: SvgPicture.asset(
                      'assets/images/$icon.svg',
                    ),
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 35,
                    width: 100,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "₹$amount",
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
