import 'package:flutter/material.dart';

import 'package:personal_expense_tracker/models/transaction.dart';
import 'package:personal_expense_tracker/ui/transaction_list_item.dart';

import 'new_transaction.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        date: DateTime.now(), title: 'New Shoes', amount: 69.99, id: 't1'),
    Transaction(
        date: DateTime.now(), title: 'Groceries', amount: 75.99, id: 't2'),
    Transaction(
        date: DateTime.now(), title: 'Dumbbells', amount: 120.99, id: 't3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Flutter App"),
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
          Card(
            color: Colors.blue,
            child: Container(
              height: 100,
              width: double.infinity,
              child: const Text('Chart'),
            ),
            elevation: 5,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return TransactionItem(transaction: _transactions[index]);
              },
              itemCount: _transactions.length,
            ),
          )
        ],
      ),
    );
  }

  void _addNewTransaction(String title, double amount) {
    setState(() {
      final newTransaction = Transaction(
          date: DateTime.now(),
          title: title,
          amount: amount,
          id: DateTime.now().microsecondsSinceEpoch.toString());
      _transactions.add(newTransaction);
    });
  }
}
