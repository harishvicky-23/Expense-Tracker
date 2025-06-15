import 'package:expense_tracker/expense_model.dart';
import 'package:expense_tracker/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.removeExpenses,
  });
  final void Function(Expense expense) removeExpenses;
  final List<Expense> expenses;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withAlpha(120),
          margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          )
        ),
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          removeExpenses(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
