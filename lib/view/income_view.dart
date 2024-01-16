import 'package:expense_tracker/models/income.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IncomeView extends StatefulWidget {
  final NewIncome income;
  const IncomeView({super.key, required this.income});

  @override
  State<IncomeView> createState() => _IncomeViewState();
}

class _IncomeViewState extends State<IncomeView> {
  @override
  Widget build(BuildContext context) {
    NewIncome income = widget.income;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text('Income'),
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
            Text('Amount: ${income.amount}',
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500))),
            SizedBox(height: 10),
            Text('Source: ${income.category}',
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500))),
            SizedBox(height: 10),
            Text('Type: ${income.type}',
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500))),
            SizedBox(height: 10),
            Text('Details: ${income.details}',
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500))),
            SizedBox(height: 10),
            Text('Day: ${income.day}',
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500))),
            SizedBox(height: 10),
            Text('Date: ${income.date}/${income.month}/${income.year}',
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500))),
            SizedBox(height: 10),
            Text('Time: ${income.time}',
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
