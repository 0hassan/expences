// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import '../models/transactions.dart';
import '../widgets/TransactionItem.dart';
//import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> _userTransactions;
  final Function _deletetransaction;
  const TransactionList(this._userTransactions, this._deletetransaction,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //elevation: 0,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: _userTransactions.isEmpty
            ? Column(
                children: [
                  Text(
                    'No Transaction is Added Yet!',
                    style: Theme.of(context).appBarTheme.titleTextStyle,
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Image.asset('assets/images/gym4.jpg')),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return TransactionItem(
                    _userTransactions[index],
                    _deletetransaction,
                  );
                },
                itemCount: _userTransactions.length,
              ),
      ),
    );
  }
}
