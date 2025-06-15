import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, academic, travel, others }

enum Payment { cash, card, upi }

const paymenticons = {
  Payment.cash: Icons.account_balance_wallet_rounded,
  Payment.card: Icons.credit_card_outlined,
  Payment.upi: Icons.qr_code_scanner,
};

const categoryicons = {
  Category.food: Icons.dining_rounded,
  Category.academic: Icons.school,
  Category.travel: Icons.train_rounded,
  Category.others: Icons.shopping_cart,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.payment,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  final Payment payment;

  String get formattedDate {
    return formatter.format(date);
  }

  // ✅ Convert to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'amount': amount,
    'date': date.toIso8601String(),
    'category': category.name,
    'payment': payment.name,
  };

  // ✅ Convert from JSON
  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    title: json['title'],
    amount: json['amount'],
    date: DateTime.parse(json['date']),
    category: Category.values.byName(json['category']),
    payment: Payment.values.byName(json['payment']),
  );
}

class Expensebucket {
  Expensebucket.forCategory(List<Expense> allexpenses, this.category)
    : expenses = allexpenses
          .where((expense) => expense.category == category)
          .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}

class Paymentbucket {
  Paymentbucket.forPaymentType(List<Expense> allexpenses, this.payment)
    : expenses = allexpenses
          .where((expense) => expense.payment == payment)
          .toList();

  final Payment payment;
  final List<Expense> expenses;

  double get paycount {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
