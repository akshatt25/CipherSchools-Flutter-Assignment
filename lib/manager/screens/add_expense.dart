import 'package:expense_tracker/features/auth/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/expense.dart';
import '../../models/transaction.dart';
import '../../provider/expense_provider.dart';
import '../../provider/transactions_provider.dart';
import '../../widgets/snack_bar.dart';

class AddExpenseScreen extends StatefulWidget {
  static const String routeName = '/addExpense';
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _expenseFormKey = GlobalKey<FormState>();
  String? _selectedCategory;
  String? _selectedFrequency;

  DateTime selectedDate = DateTime.now();

  final ammountController = TextEditingController();
  final detailsController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<NewExpense> list = Provider.of<ExpenseProvider>(context).expensesList;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff084c61),
      appBar: AppBar(
        title: Text(
          'Expense',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _expenseFormKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 250,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How Much?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white60,
                            fontSize: 20),
                      ),
                      Row(
                        children: [
                          Text(
                            '₹ ',
                            style: TextStyle(fontSize: 75, color: Colors.white),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextFormField(
                              cursorColor: Colors.grey,
                              maxLength: 20,
                              style:
                                  TextStyle(fontSize: 60, color: Colors.white),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '0',
                                  counterText: '',
                                  alignLabelWithHint: true,
                                  hintStyle: TextStyle(
                                      fontSize: 60, color: Colors.white)),
                              keyboardType: TextInputType.number,
                              controller: ammountController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 20, left: 25, right: 25),
                    color: Colors.white,
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              label: Text(
                                'Enter Details',
                                style: TextStyle(color: Colors.grey),
                              ),
                              labelStyle: TextStyle(color: Colors.black)),
                          controller: detailsController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        buildCategoryDropDown(),
                        SizedBox(
                          height: 30,
                        ),
                        buildFrequencyDropDown(),
                        Spacer(),
                        CustomButton(
                            onPressed: () {
                              if (_expenseFormKey.currentState!.validate()) {
                                // Form is valid, process the data
                                var enteredText = ammountController.text;
                                if (_selectedCategory == null ||
                                    _selectedFrequency == null) {
                                  showSnackBar(
                                      context: context,
                                      text: 'Select a Category & Period');
                                } else {
                                  showSnackBar(
                                      context: context, text: 'Expense Added');
                                  Provider.of<TransactionProvider>(context,
                                          listen: false)
                                      .addT(NewTransaction(
                                    category: _selectedCategory!,
                                    details: detailsController.text,
                                    amount: ammountController.text,
                                    type: 'out',
                                    period: _selectedFrequency!,
                                    day: DateTime.now().day.toString(),
                                    date: DateTime.now().day.toString(),
                                    month: DateTime.now().month.toString(),
                                    year: DateTime.now().year.toString(),
                                    time:
                                        '${DateFormat('hh:mm a').format(DateTime.now())}',
                                  ));
                                  print(Provider.of<TransactionProvider>(
                                          context,
                                          listen: false)
                                      .transactionsList
                                      .length);

                                  Provider.of<ExpenseProvider>(context,
                                          listen: false)
                                      .addExpense(NewExpense(
                                    category: _selectedCategory!,
                                    details: detailsController.text,
                                    amount: ammountController.text,
                                    period: _selectedFrequency!,
                                    day: DateTime.now().day.toString(),
                                    date: DateTime.now().day.toString(),
                                    month: DateTime.now().month.toString(),
                                    year: DateTime.now().year.toString(),
                                    time:
                                        '${DateFormat('hh:mm a').format(DateTime.now())}',
                                  ));
                                }
                                print('Entered Text: $enteredText');
                              }
                            },
                            color: Color(0xff084c61),
                            text: 'Submit'),
                        Spacer(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCategoryDropDown() {
    return DropdownButtonFormField(
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Colors.grey,
      ),
      decoration: InputDecoration.collapsed(hintText: 'Select Category'),
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
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Colors.grey,
      ),
      decoration: InputDecoration.collapsed(hintText: 'Select Period'),
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

  // Widget buildDaysOfWeekDropDown() {
  //   return DropdownButtonFormField(
  //     value: _selectedDayOfWeek,
  //     items: [
  //       'Monday',
  //       'Tuesday',
  //       'Wednesday',
  //       'Thursday',
  //       'Friday',
  //       'Saturday',
  //       'Sunday'
  //     ].map((dayOfWeek) {
  //       return DropdownMenuItem(
  //         value: dayOfWeek,
  //         child: Text(dayOfWeek),
  //       );
  //     }).toList(),
  //     onChanged: (value) {
  //       setState(() {
  //         _selectedDayOfWeek = value.toString();
  //       });
  //     },
  //   );
  // }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(selectedDate.year, selectedDate.month, 1),
  //     lastDate: DateTime(selectedDate.year, selectedDate.month + 1, 0),
  //   );

  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }

  // Widget buildDateDropDown() {
  //   String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);

  //   return ListTile(
  //     title: Text('Selected Date: $formattedDate'),
  //     trailing: Icon(Icons.arrow_drop_down),
  //     onTap: () => _selectDate(context),
  //   );
  // }

  // Future<void> _selectMonthAndDate(BuildContext context) async {
  //   DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(selectedDate.year),
  //     lastDate: DateTime(selectedDate.year + 1),
  //   );

  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }

  // Widget buildMonthDateDropDown() {
  //   String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);

  //   return ListTile(
  //     title: Text('Selected Date: $formattedDate'),
  //     trailing: Icon(Icons.arrow_drop_down),
  //     onTap: () {
  //       _selectMonthAndDate(context);
  //     },
  //   );
  // }
}
