import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/expense_model.dart';
import 'package:expense_tracker/chart.dart';
import 'package:expense_tracker/json_formatter.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  List<Expense> _registeredexpenses = [
    /*Expense(
      title: 'Dosa',
      amount: 70,
      date: DateTime.now(),
      category: Category.food,
      payment: Payment.cash,
    ),
    Expense(
      title: 'Cinema',
      amount: 20,
      date: DateTime.now(),
      category: Category.others,
      payment: Payment.upi,
    ),
    Expense(
      title: 'Flutter course',
      amount: 500,
      date: DateTime.now(),
      category: Category.academic,
      payment: Payment.card,
    ),*/
  ];

  @override
  void initState() {
    super.initState();
    loadExpenses().then((loadedExpenses) {
      setState(() {
        _registeredexpenses = loadedExpenses;
      });
    });
  }

  void _addexpense() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return InputPage(_onaddExpense);
      },
    );
  }

  void _onaddExpense(Expense expense) {
    setState(() {
      _registeredexpenses.add(expense);
    });
    saveExpenses(_registeredexpenses);
  }

  void _removeData(Expense expense) {
    final expenseidx = _registeredexpenses.indexOf(expense);
    setState(() {
      _registeredexpenses.remove(expense);
    });
    saveExpenses(_registeredexpenses);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense removed'),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredexpenses.insert(expenseidx, expense);
            });
            saveExpenses(_registeredexpenses);
          },
        ),
      ),
    );
  }

  void onclicked(String chartype) {
    setState(() {
      chartType = chartype == 'payment' ? 'payment' : 'category';
    });
  }

  String chartType = 'category';

  @override
  Widget build(context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Widget maincontent;
    if (_registeredexpenses.isEmpty) {
      maincontent = const Center(child: Text('No expenses found.'));
    } else {
      maincontent = ExpensesList(
        expenses: _registeredexpenses,
        removeExpenses: _removeData,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        elevation: 10,
        actions: [
          IconButton(
            onPressed: _addexpense,
            icon: Icon(Icons.add),
            iconSize: 30,
            padding: EdgeInsets.all(10),
            tooltip: 'Add Expense',
          ),
        ],
      ),
      body: screenWidth < 600
          ? Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          onclicked('category');
                        },
                        child: const Text('Category'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          onclicked('payment');
                        },
                        child: const Text('Payment type'),
                      ),
                    ],
                  ),
                ),
                Chart(expenses: _registeredexpenses, chartType: chartType),
                Expanded(child: maincontent),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                onclicked('category');
                              },
                              child: const Text('Category'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                onclicked('payment');
                              },
                              child: const Text('Payment type'),
                            ),
                          ],
                        ),
                      ),
                      Chart(
                        expenses: _registeredexpenses,
                        chartType: chartType,
                      ),
                    ],
                  ),
                ),
                Expanded(child: maincontent),
              ],
            ),
    );
  }
}
