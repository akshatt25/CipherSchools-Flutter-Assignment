import 'package:expense_tracker/features/auth/widgets/custom_button.dart';
import 'package:expense_tracker/models/income.dart';
import 'package:expense_tracker/provider/income_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/transaction.dart';
import '../../provider/transactions_provider.dart';
import '../../widgets/snack_bar.dart';

class AddIncomeScreen extends StatefulWidget {
  static const String routeName = '/addIncome';
  const AddIncomeScreen({super.key});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final _incomeFormKey = GlobalKey<FormState>();
  String? _selectedCategory;
  String? _selectedFrequency;
  String _selectedDayOfWeek = 'Monday';
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
    List<NewIncome> list = Provider.of<IncomeProvider>(context).incomeList;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff177E89),
      appBar: AppBar(
        title: Text(
          'Income',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _incomeFormKey,
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
                              if (_incomeFormKey.currentState!.validate()) {
                                // Form is valid, process the data
                                var enteredText = ammountController.text;
                                if (_selectedCategory == null ||
                                    _selectedFrequency == null) {
                                  showSnackBar(
                                      context: context,
                                      text: 'Select a Category & Period');
                                } else {
                                  showSnackBar(
                                      context: context, text: 'Income Added');
                                  Provider.of<TransactionProvider>(context,
                                          listen: false)
                                      .addT(NewTransaction(
                                    category: _selectedCategory!,
                                    details: detailsController.text,
                                    amount: ammountController.text,
                                    type: 'in',
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

                                  Provider.of<IncomeProvider>(context,
                                          listen: false)
                                      .addIncome(NewIncome(
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
                            color: Color(0xff177E89),
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
      items: ['Job Salary', 'Job Bonus', 'Freelancing', 'Stipend', 'Others']
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
