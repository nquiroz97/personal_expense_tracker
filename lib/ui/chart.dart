import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/ui/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  final bool isLandscape;

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, item) {
      return previousValue + (item['amount'] as double);
    });
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date!.day == weekday.day &&
            recentTransactions[i].date!.month == weekday.month &&
            recentTransactions[i].date!.year == weekday.year) {
          totalSum += recentTransactions[i].amount!;
        }
      }

      return {'day': DateFormat.E().format(weekday), 'amount': totalSum};
    }).reversed.toList();
  }

  const Chart(
      {Key? key, required this.recentTransactions, required this.isLandscape})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isLandscape
          ? MediaQuery.of(context).size.height * 0.60
          : MediaQuery.of(context).size.height * 0.30,
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.loose,
              child: ChartBar(
                  label: e['day'].toString(),
                  spendingAmount: e['amount'] as double,
                  percentage: totalSpending == 0.0
                      ? 0.0
                      : (e['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
