import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/provider/transactions_provider.dart';
import 'package:expense_tracker/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class AddTransactionScreen extends StatefulWidget {
  static const String routeName = '/addTransaction';
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedCategory = 'Others';
  String _selectedFrequency = 'Once';
  String _selectedDayOfWeek = 'Monday';
  String _selectedTransactionType = '';

  final ammountController = TextEditingController();
  final detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter Amount:'),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: ammountController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Text('Enter Details'),
            TextFormField(
              controller: detailsController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            buildInOutRadioButtons(),
            buildCategoryDropDown(),
            buildFrequencyDropDown(),
            _selectedFrequency == 'Weekly'
                ? buildDaysOfWeekDropDown()
                : SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Form is valid, process the data
                  var enteredText = ammountController.text;
                  if (_selectedTransactionType == '') {
                    showSnackBar(
                        context: context, text: 'Select Credit or Debit');
                  } else {
                    print('here');
                    Provider.of<TransactionProvider>(context, listen: false)
                        .addT(NewTransaction(
                      category: _selectedCategory,
                      details: detailsController.text,
                      amount: ammountController.text,
                      type: _selectedTransactionType,
                      period: _selectedFrequency,
                      day: DateTime.now().day.toString(),
                      date: DateTime.now().day.toString(),
                      month: DateTime.now().month.toString(),
                      year: DateTime.now().year.toString(),
                      time: '${DateFormat('hh:mm a').format(DateTime.now())}',
                    ));
                    print(
                        Provider.of<TransactionProvider>(context, listen: false)
                            .transactionsList
                            .length);
                  }
                  print('Entered Text: $enteredText');
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryDropDown() {
    return DropdownButtonFormField(
      value: _selectedCategory,
      items: ['Travel', 'Shopping', 'Subscriptions', 'Food', 'Others']
          .map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value.toString();
        });
      },
    );
  }

  Widget buildFrequencyDropDown() {
    return DropdownButtonFormField(
      value: _selectedFrequency,
      items:
          ['Once', 'Daily', 'Weekly', 'Monthly', 'Annually'].map((frequency) {
        return DropdownMenuItem(
          value: frequency,
          child: Text(frequency),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedFrequency = value.toString();
        });
      },
    );
  }

  Widget buildDaysOfWeekDropDown() {
    return DropdownButtonFormField(
      value: _selectedDayOfWeek,
      items: [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ].map((dayOfWeek) {
        return DropdownMenuItem(
          value: dayOfWeek,
          child: Text(dayOfWeek),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedDayOfWeek = value.toString();
        });
      },
    );
  }

  Widget buildInOutRadioButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Transaction Type:'),
        Row(
          children: [
            Radio(
              value: 'in',
              groupValue: _selectedTransactionType,
              onChanged: (value) {
                setState(() {
                  _selectedTransactionType = value.toString();
                });
              },
            ),
            Text('Credit'),
            SizedBox(width: 20),
            Radio(
              value: 'out',
              groupValue: _selectedTransactionType,
              onChanged: (value) {
                setState(() {
                  _selectedTransactionType = value.toString();
                });
              },
            ),
            Text('Debit'),
          ],
        ),
      ],
    );
  }
}
