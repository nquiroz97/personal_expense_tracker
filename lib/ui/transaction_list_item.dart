import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({Key? key, required this.transaction})
      : super(key: key);
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        minLeadingWidth: 50,
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.blue,
          child: Text(
            '\$${transaction.amount!.toStringAsFixed(2)}',
            style: const TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          transaction.title!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat.yMMMEd().add_jm().format(transaction.date!),
          style: TextStyle(color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
