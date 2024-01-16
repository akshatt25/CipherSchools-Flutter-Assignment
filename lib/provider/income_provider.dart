import 'package:expense_tracker/models/income.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class IncomeProvider with ChangeNotifier {
  String _totalIncome = '0';
  List<NewIncome> incomeList = [];
  late Database _database;
  static const String _incomeTable = 'income';
  static const String _incomeKey = 'income_key';

  IncomeProvider() {
    _initDatabase();
    _loadTotalIncomeFromPrefs(); // Initialize the database during initialization
  }
  String get totalIncome => _totalIncome;

  void setTotalIncome(String newBalance) {
    _totalIncome = newBalance;
    _saveTotalIncomeToPrefs();
    notifyListeners();
  }

  Future<void> _loadTotalIncomeFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _totalIncome = prefs.getString(_incomeKey) ?? "0";
  }

  Future<void> _saveTotalIncomeToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_incomeKey, _totalIncome);
  }

  Future<void> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'income_database.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $_incomeTable (
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

    await loadIncomeFromDb();
  }

  Future<void> loadIncomeFromDb() async {
    final List<Map<String, dynamic>> rows = await _database.query(_incomeTable);

    if (rows.isNotEmpty) {
      incomeList = rows.map((row) => NewIncome.fromMap(row)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveIncomeToDb() async {
    await _database.delete(_incomeTable); // Clear existing data
    for (final income in incomeList) {
      await _database.insert(
        _incomeTable,
        income.toMap(),
      );
    }
  }

  void addIncome(NewIncome income) {
    int a = int.parse(_totalIncome) + int.parse(income.amount);
    setTotalIncome(a.toString());
    incomeList.add(income);
    _saveIncomeToDb();
    notifyListeners();
  }

  void removeIncomeAtIndex(int index) {
    if (index >= 0 && index < incomeList.length) {
      int a = int.parse(_totalIncome) - int.parse(incomeList[index].amount);
      setTotalIncome(a.toString());

      incomeList.removeAt(index);
      _saveIncomeToDb();
      notifyListeners();
    }
  }
}
