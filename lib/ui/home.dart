import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:personal_expense_tracker/models/transaction.dart';
import 'package:personal_expense_tracker/ui/chart.dart';
import 'package:personal_expense_tracker/ui/transaction_list_item.dart';

import 'new_transaction.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction>? get _recentTransactions {
    return _transactions
        .where((element) => element.date!
            .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Expense Tracker",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return GestureDetector(
                  onTap: () {},
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .9,
                    child: NewTransaction(
                      addTransaction: _addNewTransaction,
                    ),
                  ),
                );
              });
        },
      ),
      body: Column(
        children: [
          Chart(recentTransactions: _transactions),
          Expanded(
            child: _transactions.isEmpty
                ? Column(
                    children: [
                      Text(
                        'No transactions added yet',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(child: Image.asset('assets/images/waiting.png'))
                    ],
                  )
                : ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return TransactionItem(
                        transaction: _transactions[index],
                        removeTransaction: _deleteTransaction,
                      );
                    },
                    itemCount: _transactions.length,
                  ),
          )
        ],
      ),
    );
  }

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    setState(() {
      final newTransaction = Transaction(
          date: selectedDate,
          title: title,
          amount: amount,
          id: DateTime.now().microsecondsSinceEpoch.toString());
      _transactions.add(newTransaction);
    });
  }

  void _deleteTransaction(Transaction transaction) {
    setState(() {
      _transactions.remove(transaction);
    });
  }
}
