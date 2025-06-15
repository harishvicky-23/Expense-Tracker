import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker/expense_model.dart';

const String _storageKey = 'expenses_data';

Future<void> saveExpenses(List<Expense> expenses) async {
  final prefs = await SharedPreferences.getInstance();
  final expenseListJson = expenses.map((e) => e.toJson()).toList();
  prefs.setString(_storageKey, jsonEncode(expenseListJson));
}

Future<List<Expense>> loadExpenses() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString(_storageKey);
  if (jsonString == null) return [];
  final decoded = jsonDecode(jsonString) as List<dynamic>;
  return decoded.map((e) => Expense.fromJson(e)).toList();
}
