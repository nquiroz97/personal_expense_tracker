import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Function removeTransaction;
  final Transaction transaction;
  const TransactionItem(
      {Key? key, required this.transaction, required this.removeTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Dismissible(
        direction: DismissDirection.endToStart,
        key: Key(transaction.id!),
        onDismissed: (_) => removeTransaction(transaction),
        background: Container(),
        secondaryBackground: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.red),
          child: const Align(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.delete),
            ),
            alignment: Alignment.centerRight,
          ),
        ),
        child: ListTile(
          minLeadingWidth: 50,
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text(
                  '\$${transaction.amount!.toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          title: Text(
            transaction.title!,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            DateFormat.yMMMEd().add_jm().format(transaction.date!),
            style: TextStyle(color: Colors.grey.shade400),
          ),
        ),
      ),
    );
  }
}
