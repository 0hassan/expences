// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionItem extends StatelessWidget {
  final Transactions userTransaction;
  final Function _deletetransaction;

  // ignore: use_key_in_widget_constructors
  const TransactionItem(
    this.userTransaction,
    this._deletetransaction,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).backgroundColor,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(child: Text('\$${userTransaction.expense}')),
          ),
        ),
        title: Text(
          userTransaction.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(userTransaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 450
            ? TextButton.icon(
                onPressed: () {
                  _deletetransaction(userTransaction.id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                label: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ))
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  _deletetransaction(userTransaction.id);
                },
              ),
      ),
    );
  }
}
