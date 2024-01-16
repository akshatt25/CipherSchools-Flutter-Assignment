import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/transaction.dart';
import '../../../provider/transactions_provider.dart';
import '../../../view/transaction_view.dart';
import '../widgets/transaction_widget.dart';

class AllTransactions extends StatefulWidget {
  const AllTransactions({super.key});

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  List<NewTransaction> transactionList = [];

  @override
  Widget build(BuildContext context) {
    transactionList =
        Provider.of<TransactionProvider>(context).transactionsList;
    transactionList = transactionList.reversed.toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'All Transactions',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
          itemCount: transactionList.length,
          itemBuilder: (context, index) {
            NewTransaction transaction = transactionList[index];

            return buildTransactionTile(transaction, index);
          }),
    );
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
}
