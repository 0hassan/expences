import 'package:flutter/material.dart';
import 'package:myapp/widgets/newTransaction.dart';
import 'package:myapp/widgets/transactionList.dart';
import './models/transactions.dart';
import './widgets/chart.dart';
//import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EXPENSE BOOK',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Quicksand',
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transactions> transactions = [];

  bool _showChart = false;

  // @override
  // void initState() {
  //   WidgetsBinding.instance?.addObserver(this);
  //   super.initState();
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   print(state);
  // }

  // @override
  // dispose() {
  //   WidgetsBinding.instance?.removeObserver(this);
  //   super.dispose();
  // }

  _addNewTransaction(String title, double expense, DateTime selectedDate) {
    Transactions t = Transactions(
      id: DateTime.now().toString(),
      title: title,
      expense: expense,
      date: selectedDate,
    );
    setState(() {
      transactions.add(t);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return AddNewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar = AppBar(
      title: const Text(
        'EXPENSE BOOK',
      ),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(),
          icon: const Icon(Icons.add),
        )
      ],
    );
    final transactionList = SizedBox(
        height: (MediaQuery.of(context).size.height -
                appbar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.75,
        child: TransactionList(transactions, _deleteTransaction));
    return Scaffold(
      appBar: appbar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Show Chart"),
                  Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      }),
                ],
              ),
            if (!isLandscape)
              SizedBox(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.25,
                width: double.infinity,
                child: Chart(resentTransactions: resentTransaction),
              ),
            if (!isLandscape) transactionList,
            if (isLandscape)
              _showChart
                  ? SizedBox(
                      height: (MediaQuery.of(context).size.height -
                              appbar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.8,
                      width: double.infinity,
                      child: Chart(resentTransactions: resentTransaction),
                    )
                  : transactionList,
          ],
        ),
      ),
    );
  }

  List<Transactions> get resentTransaction {
    return transactions.where(
      (element) {
        return element.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        );
      },
    ).toList();
  }
}
