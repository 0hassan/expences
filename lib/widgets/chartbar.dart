import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String lable;
  final double totalAmount;
  final double spendingTotalPercent;
  const ChartBar(
      {Key? key,
      required this.lable,
      required this.totalAmount,
      required this.spendingTotalPercent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                    child: Text('\$${totalAmount.toStringAsFixed(0)}')),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              SizedBox(
                height: constraints.maxHeight * 0.6,
                width: 10,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        color: const Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: spendingTotalPercent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              SizedBox(
                  height: constraints.maxHeight * 0.15, child: Text(lable)),
            ],
          ),
        );
      },
    );
  }
}
