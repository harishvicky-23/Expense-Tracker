import 'package:flutter/material.dart';
import 'package:expense_tracker/expense_model.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;

  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  categoryicons[expense.category],
                  //size: 25,
                ),
                const SizedBox(width: 10),
                Text(
                  expense.formattedDate,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Spacer(),
                Text(
                  '₹ ${expense.amount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.end,
                ),
                const SizedBox(width: 5),
                Icon(paymenticons[expense.payment]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
