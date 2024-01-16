import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TransactionProvider with ChangeNotifier {
  List<NewTransaction> transactionsList = [];
  late Database _database;
  static const String _transactionTable = 'transactions';

  TransactionProvider() {
    _initDatabase();
    // Initialize the database during initialization
  }

  Future<void> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'transaction_database.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $_transactionTable (
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

    await loadTransactionsFromDb();
  }

  Future<void> loadTransactionsFromDb() async {
    final List<Map<String, dynamic>> rows =
        await _database.query(_transactionTable);

    if (rows.isNotEmpty) {
      transactionsList =
          rows.map((row) => NewTransaction.fromMap(row)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveTransactionsToDb() async {
    await _database.delete(_transactionTable); // Clear existing data
    for (final transaction in transactionsList) {
      await _database.insert(
        _transactionTable,
        transaction.toMap(),
      );
    }
  }

  void addT(NewTransaction transaction) {
    transactionsList.add(transaction);
    _saveTransactionsToDb();
    notifyListeners();
  }
}
