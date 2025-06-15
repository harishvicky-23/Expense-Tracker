import 'package:flutter/material.dart';
import 'package:expense_tracker/chart_bar.dart';
import 'package:expense_tracker/expense_model.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses, required this.chartType});

  final List<Expense> expenses;
  final String chartType;

  List<Expensebucket> get buckets {
    return [
      Expensebucket.forCategory(expenses, Category.food),
      Expensebucket.forCategory(expenses, Category.academic),
      Expensebucket.forCategory(expenses, Category.travel),
      Expensebucket.forCategory(expenses, Category.others),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  List<Paymentbucket> get paytypes {
    return [
      Paymentbucket.forPaymentType(expenses, Payment.cash),
      Paymentbucket.forPaymentType(expenses, Payment.card),
      Paymentbucket.forPaymentType(expenses, Payment.upi),
    ];
  }

  double get totalPaymentsMade {
    double totalPaymentsMade = 0;
    for (final paytype in paytypes) {
      if (paytype.paycount > totalPaymentsMade) {
        totalPaymentsMade = paytype.paycount;
      }
    }
    return totalPaymentsMade;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    final chartbars = chartType == 'category'
        ? buckets.map(
            (bucket) => ChartBar(
              fill: bucket.totalExpenses == 0
                  ? 0
                  : bucket.totalExpenses / maxTotalExpense,
            ),
          )
        : paytypes.map(
            (paytype) => ChartBar(
              fill: paytype.paycount == 0
                  ? 0
                  : paytype.paycount / totalPaymentsMade,
            ),
          );
    final filltexts = chartType == 'category'
        ? buckets.map((bucket) {
            final text = bucket.totalExpenses == 0 ? 0 : bucket.totalExpenses;
            return Expanded(
              child: Center(
                child: Text(
                  '₹ ${text.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            );
          })
        : paytypes.map((paytype) {
            final text = paytype.paycount == 0 ? 0 : paytype.paycount;
            return Expanded(
              child: Center(
                child: Text(
                  '₹ ${text.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            );
          });

    final charticon = chartType == 'category'
        ? buckets
              .map(
                (bucket) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      categoryicons[bucket.category],
                      color: isDarkMode
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer.withAlpha(230),
                    ),
                  ),
                ),
              )
              .toList()
        : paytypes
              .map(
                (paytype) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      size: 23,
                      paymenticons[paytype.payment],
                      color: isDarkMode
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer.withAlpha(230),
                    ),
                  ),
                ),
              )
              .toList();

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 1, 12, 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.onInverseSurface.withAlpha(200),
            Theme.of(context).colorScheme.primary.withAlpha(170),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [...chartbars],
            ),
          ),
          const SizedBox(height: 5),
          Row(children: [...filltexts]),
          const SizedBox(height: 5),
          Row(children: [...charticon]),
        ],
      ),
    );
  }
}
