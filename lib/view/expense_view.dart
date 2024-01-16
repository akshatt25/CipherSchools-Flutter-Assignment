import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseView extends StatefulWidget {
  final NewExpense expense;
  const ExpenseView({super.key, required this.expense});

  @override
  State<ExpenseView> createState() => _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpenseView> {
  @override
  Widget build(BuildContext context) {
    NewExpense expense = widget.expense;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text('Expense'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        height: 400,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 239, 251, 195)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount: ${expense.amount}',
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500))),
            SizedBox(height: 10),
            Text('Category: ${expense.category}',
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500))),
            SizedBox(height: 10),
            Text('Type: ${expense.type}',
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500))),
            SizedBox(height: 10),
            Text('Period: ${expense.period}',
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500))),
            SizedBox(height: 10),
            Text('Details: ${expense.details}',
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500))),
            SizedBox(height: 10),
            Text('Day: ${expense.day}',
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500))),
            SizedBox(height: 10),
            Text('Date: ${expense.date}/${expense.month}/${expense.year}',
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500))),
            SizedBox(height: 10),
            Text('Time: ${expense.time}',
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500))),
            SizedBox(height: 10),
            // Add more Text widgets as needed for other fields
          ],
        ),
      ),
    );
  }
}
