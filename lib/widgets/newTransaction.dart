// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewTransaction extends StatefulWidget {
  Function funHandler;
  AddNewTransaction(this.funHandler, {Key? key}) : super(key: key);

  @override
  State<AddNewTransaction> createState() => _AddNewTransactionState();
}

class _AddNewTransactionState extends State<AddNewTransaction> {
  final titleInput = TextEditingController();

  final amountInput = TextEditingController();

  void addTransaction() {
    final title = titleInput.text;
    double amount = double.parse(amountInput.text);
    if (title.isEmpty || amount <= 0 || _selectedDate == null) return;
    widget.funHandler(title, amount, _selectedDate);
    Navigator.of(context).pop();
  }

  DateTime? _selectedDate;
  void _showDateTable() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
        top: 0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 10,
      ),
      child: Card(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
                controller: titleInput,
                onSubmitted: (_) => addTransaction(),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Amount'),
                ),
                controller: amountInput,
                onSubmitted: (_) => addTransaction(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    _selectedDate != null
                        ? DateFormat.yMd().format(_selectedDate!)
                        : "Date is Not Chosen!",
                  ),
                  TextButton(
                    onPressed: _showDateTable,
                    child: const Text(
                      'Chose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                addTransaction();
              },
              child: const Text('Add Expence'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.blue),
                backgroundColor:
                    MaterialStateProperty.all(Colors.lightGreen[50]),
                // backgroundColor: MaterialStateProperty.all(Colors.orange[300]),
                overlayColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.blue.withOpacity(0.04);
                  }
                  if (states.contains(MaterialState.focused) ||
                      states.contains(MaterialState.pressed)) {
                    return Colors.pink.withOpacity(0.12);
                  }
                  return null; // Defer to the widget's default.
                }),
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
      ),
    );
  }
}
