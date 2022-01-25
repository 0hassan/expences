import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/transactions.dart';
import 'package:myapp/widgets/chartbar.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.resentTransactions}) : super(key: key);
  final List<Transactions> resentTransactions;

  List<Map<String, Object>> get totalexpenses {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalAmount = 0;
      for (int i = 0; i < resentTransactions.length; i++) {
        if (resentTransactions[i].date.day == weekday.day &&
            resentTransactions[i].date.month == weekday.month &&
            resentTransactions[i].date.year == weekday.year) {
          totalAmount += resentTransactions[i].expense;
        }
      }
      return {
        'day': DateFormat.E().format(weekday),
        'amount': totalAmount,
      };
    }).reversed.toList();
  }

  double get totalSpendings {
    return totalexpenses.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      //margin: const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: totalexpenses.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                lable: e['day'].toString(),
                totalAmount: double.parse(e['amount'].toString()),
                spendingTotalPercent: totalSpendings == 0
                    ? 0.0
                    : (e['amount'] as double) / totalSpendings,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
