import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionView extends StatefulWidget {
  final NewTransaction transaction;
  const TransactionView({super.key, required this.transaction});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  @override
  Widget build(BuildContext context) {
    NewTransaction transaction = widget.transaction;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: transaction.deletedTime == '0'
            ? Text('Transaction')
            : Text(transaction.category),
        elevation: 0,
        centerTitle: true,
      ),
      body: transaction.deletedTime != '0'
          ? Container(
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
                  Text('Amount: ${transaction.amount}',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500))),
                  SizedBox(height: 10),
                  Text('Period: ${transaction.period}',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500))),
                  SizedBox(height: 10),
                  Text(
                      'Date Created: ${transaction.date}/${transaction.month}/${transaction.year}',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500))),
                  SizedBox(height: 10),
                  Text('Date Deleted: ${transaction.deletedTime}',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500))),
                  SizedBox(height: 10),
                ],
              ),
            )
          : Container(
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
                  Text('Amount: ${transaction.amount}',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500))),
                  SizedBox(height: 10),
                  Text('Category: ${transaction.category}',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500))),
                  SizedBox(height: 10),
                  Text('Type: ${transaction.type}',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500))),
                  SizedBox(height: 10),
                  Text('Period: ${transaction.period}',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500))),
                  SizedBox(height: 10),
                  Text('Details: ${transaction.details}',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500))),
                  SizedBox(height: 10),

                  Text(
                      'Date: ${transaction.date}/${transaction.month}/${transaction.year}',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500))),
                  SizedBox(height: 10),
                  Text('Time: ${transaction.time}',
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
