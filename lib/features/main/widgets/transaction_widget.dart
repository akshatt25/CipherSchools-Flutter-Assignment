import 'package:expense_tracker/constants/global_variables.dart';
import 'package:expense_tracker/features/main/widgets/category_icon.dart';
import 'package:expense_tracker/view/transaction_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatefulWidget {
  final String category;
  final String amount;
  final String details;
  final String type;
  final String time;
  final String date;
  final String month;
  final String year;
  const TransactionTile(
      {super.key,
      required this.category,
      required this.amount,
      required this.details,
      required this.type,
      required this.time,
      required this.date,
      required this.month,
      required this.year});

  @override
  State<TransactionTile> createState() => _TransactionState();
}

class _TransactionState extends State<TransactionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: Row(
        children: [
          CategoryIcon(category: widget.category),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.category,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.details,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, bottom: 5, top: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                widget.type == 'in'
                    ? Text(
                        '+ ₹${widget.amount}',
                        style: TextStyle(
                            fontSize: 20,
                            color: GlobalVariables.green,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1),
                      )
                    : Text(
                        '- ₹${widget.amount}',
                        style: TextStyle(
                            fontSize: 20,
                            color: GlobalVariables.red,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1),
                      ),
                Text(
                  widget.time,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
