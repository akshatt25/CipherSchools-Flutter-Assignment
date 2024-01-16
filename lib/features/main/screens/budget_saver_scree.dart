import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/view/expense_view.dart';
import 'package:expense_tracker/view/income_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/expense.dart';
import '../../../models/income.dart';
import '../../../provider/expense_provider.dart';
import '../../../provider/income_provider.dart';
import '../../../provider/transactions_provider.dart';
import '../widgets/transaction_widget.dart';

class BudgetSaverScreen extends StatefulWidget {
  static const String routeName = '/budgetsaverscreen';
  const BudgetSaverScreen({super.key});

  @override
  State<BudgetSaverScreen> createState() => _BudgetSaverScreenState();
}

class _BudgetSaverScreenState extends State<BudgetSaverScreen> {
  int value = 0;
  List<NewIncome> IncomeList = [];
  List<NewExpense> ExpenseList = [];

  @override
  Widget build(BuildContext context) {
    IncomeList = Provider.of<IncomeProvider>(context).incomeList;
    ExpenseList = Provider.of<ExpenseProvider>(context).expensesList;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: topPanel()),
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            elevation: 0,
            toolbarHeight: 75,
            flexibleSpace: Container(
              height: 80,
              padding: EdgeInsets.only(top: 30, bottom: 0),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      value = 0;
                      setState(() {});
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          color: value == 0
                              ? Color.fromARGB(255, 197, 232, 197)
                              : Color.fromARGB(255, 237, 237, 237),
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      child: Text("Income",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      value = 1;
                      setState(() {});
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          color: value == 1
                              ? Color.fromARGB(255, 242, 202, 199)
                              : Color.fromARGB(255, 237, 237, 237),
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      child: Text(
                        "Expense",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          value == 0 ? getIncomeView(IncomeList) : getExpenseView(ExpenseList)
        ],
      ),
    );
  }

  Widget topPanel() {
    String income = Provider.of<IncomeProvider>(context).totalIncome;
    String expense = Provider.of<ExpenseProvider>(context).totalExpense;
    String perc =
        (((int.parse(income) - int.parse(expense)) / int.parse(income)) * 100)
            .toString();
    return Container(
      height: 125,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color.fromARGB(132, 178, 243, 220),
            borderRadius: BorderRadius.circular(20)),
        height: 60,
        width: 250,
        padding: EdgeInsets.all(2),
        child: perc == 'NaN'
            ? Text(
                'Current Savings : 0',
                style: TextStyle(fontSize: 20),
              )
            : perc == '-Infinity'
                ? Text('No Savings')
                : Text(
                    'Current Savings: $perc %',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
      ),
    );
  }

  Widget getIncomeView(List list) {
    list = list.reversed.toList();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          NewIncome income = list[index];

          return buildIncomeTile(income, index);
        },
        childCount: list.length,
      ),
    );
  }

  Widget getExpenseView(List list) {
    list = list.reversed.toList();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          NewExpense expense = list[index];

          return buildExpenseTile(expense, index);
        },
        childCount: list.length,
      ),
    );
  }

  Widget buildIncomeTile(NewIncome income, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IncomeView(income: income)));
      },
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
          color: const Color.fromARGB(225, 244, 67, 54),
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: Icon(
              Icons.delete_outline_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        onDismissed: (direction) {
          DateTime now = DateTime.now();
          String currentDateTime =
              '${now.hour}:${now.minute} on ${now.day}/${now.month}/${now.year}';
          Provider.of<TransactionProvider>(context, listen: false).addT(
              NewTransaction(
                  category: 'Deleted Income',
                  details: "Tap to View Details",
                  amount: income.amount,
                  type: 'out',
                  period: income.period,
                  date: income.date,
                  day: income.day,
                  month: income.month,
                  year: income.year,
                  time: '${DateFormat('hh:mm a').format(DateTime.now())}',
                  deletedTime: currentDateTime));
          Provider.of<IncomeProvider>(context, listen: false)
              .removeIncomeAtIndex(index);

          // setState(() {
          //   transactionList.removeAt(index);
          // });
          // Handle the delete action here
          // Example: deleteTransaction(income.id);
        },
        child: TransactionTile(
          category: income.category,
          amount: income.amount,
          details: income.details,
          type: income.type,
          date: income.date,
          time: income.time,
          year: income.year,
          month: income.month,
        ),
      ),
    );
  }

  Widget buildExpenseTile(NewExpense expense, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ExpenseView(expense: expense)));
      },
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
          color: const Color.fromARGB(225, 244, 67, 54),
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: Icon(
              Icons.delete_outline_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        onDismissed: (direction) {
          DateTime now = DateTime.now();
          String currentDateTime =
              '${now.hour}:${now.minute} on ${now.day}/${now.month}/${now.year}';
          Provider.of<TransactionProvider>(context, listen: false).addT(
              NewTransaction(
                  category: 'Deleted Expense',
                  details: "Tap to View Details",
                  amount: expense.amount,
                  type: 'in',
                  period: expense.period,
                  date: expense.date,
                  day: DateTime.now().day.toString(),
                  month: DateTime.now().month.toString(),
                  year: DateTime.now().year.toString(),
                  time: '${DateFormat('hh:mm a').format(DateTime.now())}',
                  deletedTime: currentDateTime));
          Provider.of<ExpenseProvider>(context, listen: false)
              .removeExpenseAtIndex(index);

          // setState(() {
          //   transactionList.removeAt(index);
          // });
          // Handle the delete action here
          // Example: deleteTransaction(expense.id);
        },
        child: TransactionTile(
          category: expense.category,
          amount: expense.amount,
          details: expense.details,
          type: expense.type,
          date: expense.date,
          time: expense.time,
          year: expense.year,
          month: expense.month,
        ),
      ),
    );
  }
}
