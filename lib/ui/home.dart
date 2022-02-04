import 'dart:io';

import 'package:flutter/cupertino.dart';
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [];
  late Platform platform;

  List<Transaction>? get _recentTransactions {
    return _transactions
        .where((element) => element.date!
            .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  bool _showChart = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final dynamic _appBar =
        Platform.isIOS ? _buildCupertinoAppBar() : _buildMaterialAppBar();
    final _pageBody = SafeArea(
        child: _isLandscape
            ? _buildLandscapeContent(_isLandscape)
            : _buildPortraitContent(_isLandscape));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            resizeToAvoidBottomInset: true,
            child: _pageBody,
            navigationBar: _appBar,
          )
        : Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: _appBar,
            floatingActionButton: Platform.isAndroid
                ? FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () {
                      _displayBottomSheet(context);
                    },
                  )
                : Container(),
            body: _pageBody,
          );
  }

  Widget _buildCupertinoAppBar() {
    return CupertinoNavigationBar(
      trailing: CupertinoButton(
          child: const Icon(CupertinoIcons.add),
          onPressed: () => _displayBottomSheet(context)),
      middle: const Text(
        "Expense Tracker",
      ),
    );
  }

  Widget _buildMaterialAppBar() {
    return AppBar(
      title: const Text(
        "Expense Tracker",
      ),
    );
  }

  Widget _buildLandscapeContent(bool isLandscape) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Show Chart',
              style: Theme.of(context).textTheme.headline6,
            ),
            Switch(
                value: _showChart,
                onChanged: (value) {
                  setState(() {
                    _showChart = value;
                  });
                })
          ],
        ),
        _showChart
            ? Chart(
                recentTransactions: _recentTransactions!,
                isLandscape: isLandscape,
              )
            : Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: _transactions.isEmpty
                    ? Column(
                        children: [
                          FittedBox(
                            child: Text(
                              'No transactions added yet',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Image.asset('assets/images/waiting.png'),
                          )
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
    );
  }

  Widget _buildPortraitContent(bool isLandscape) {
    return Column(
      children: [
        Chart(
          recentTransactions: _recentTransactions!,
          isLandscape: isLandscape,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: _transactions.isEmpty
              ? Column(
                  children: [
                    FittedBox(
                      child: Text(
                        'No transactions added yet',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Image.asset('assets/images/waiting.png'),
                    )
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
    );
  }

  void _displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: MediaQuery.of(context).size.height * .7,
              child: NewTransaction(
                addTransaction: _addNewTransaction,
              ),
            ),
          );
        });
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
