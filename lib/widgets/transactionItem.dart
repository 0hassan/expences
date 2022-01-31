// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionItem extends StatefulWidget {
  final Transactions userTransaction;
  final Function deletetransaction;

  // ignore: use_key_in_widget_constructors
  const TransactionItem(
      {required this.userTransaction,
      required this.deletetransaction,
      Key? key})
      : super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;
  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.blue,
      Colors.yellow,
      Colors.pink
    ];
    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).backgroundColor,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _bgColor,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child:
                FittedBox(child: Text('\$${widget.userTransaction.expense}')),
          ),
        ),
        title: Text(
          widget.userTransaction.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(widget.userTransaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 450
            ? TextButton.icon(
                onPressed: () {
                  widget.deletetransaction(widget.userTransaction.id);
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
                  widget.deletetransaction(widget.userTransaction.id);
                },
              ),
      ),
    );
  }
}
