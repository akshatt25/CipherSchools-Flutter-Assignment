import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ExpenseProvider with ChangeNotifier {
  List<NewExpense> expensesList = [];
  late Database _database;
  static const String _expenseTable = 'expenses';
  String _totalExpense = '0';
  static const String _expenseKey =
      'expense_key'; // Added totalExpense variable

  ExpenseProvider() {
    _initDatabase(); // Initialize the database during initialization
    _loadTotalExpenseFromPrefs(); // Load totalExpense from SharedPreferences
  }

  String get totalExpense => _totalExpense; // Getter for totalExpense

  void setTotalExpense(String newBalance) {
    _totalExpense = newBalance;
    _saveTotalExpenseToPrefs(); // Save totalExpense to SharedPreferences
    notifyListeners();
  }

  Future<void> _loadTotalExpenseFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _totalExpense = prefs.getString(_expenseKey) ?? '0';
  }

  Future<void> _saveTotalExpenseToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_expenseKey, _totalExpense);
  }

  Future<void> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'expense_database.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $_expenseTable (
            id INTEGER PRIMARY KEY,
            amount TEXT,
            category TEXT,
            type TEXT,
            period TEXT,
            details TEXT,
            day TEXT,
            date TEXT,
            month TEXT,
            year TEXT,
            time TEXT
          )
        ''');
      },
    );

    await loadExpensesFromDb();
  }

  Future<void> loadExpensesFromDb() async {
    final List<Map<String, dynamic>> rows =
        await _database.query(_expenseTable);

    if (rows.isNotEmpty) {
      expensesList = rows.map((row) => NewExpense.fromMap(row)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveExpensesToDb() async {
    await _database.delete(_expenseTable); // Clear existing data
    for (final expense in expensesList) {
      await _database.insert(
        _expenseTable,
        expense.toMap(),
      );
    }
  }

  void addExpense(NewExpense expense) {
    int a = int.parse(_totalExpense) + int.parse(expense.amount);
    setTotalExpense(a.toString());
    expensesList.add(expense);
    _saveExpensesToDb();
    notifyListeners();
  }

  void removeExpenseAtIndex(int index) {
    if (index >= 0 && index < expensesList.length) {
      int a = int.parse(_totalExpense) - int.parse(expensesList[index].amount);
      setTotalExpense(a.toString());

      expensesList.removeAt(index);
      _saveExpensesToDb();
      notifyListeners();
    }
  }
}
