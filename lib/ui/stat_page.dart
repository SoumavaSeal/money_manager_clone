import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_clone/models/date_controller.dart';
import 'package:money_manager_clone/models/transaction.dart';
import 'package:money_manager_clone/services/database_services.dart';
import 'package:money_manager_clone/widgets/header.dart';
import 'package:money_manager_clone/widgets/stat_details.dart';

class StatPage extends StatefulWidget {
  const StatPage({super.key});

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  DateTime date = DateTime.now();
  final DateController _dateController = DateController();

  @override
  void initState() {
    _dateController.setDate(date);
    date = _dateController.getDate();
    super.initState();
  }

  void refresh(DateTime selDate) {
    setState(() {
      date = selDate;
    });
  }

  @override
  Widget build(context) {
    DatabaseServices dbservices = DatabaseServices.dbInstance;

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: FutureBuilder(
            future: dbservices.getTransactions(),
            builder: (context, snapshot) {
              List<Transactions> selMonTrxn = [];
              List<Transactions> selMonIncome = [];
              List<Transactions> selMonExpense = [];

              if (snapshot.hasData == false) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasData == true) {
                selMonTrxn = snapshot.data!
                    .where((e) => (e.date.month == date.month &&
                        e.date.year == date.year))
                    .toList();

                selMonIncome = snapshot.data!
                    .where((e) =>
                        e.date.month == date.month &&
                        e.date.year == date.year &&
                        e.type == 0)
                    .toList();

                selMonIncome.sort((i1, i2) => i2.amount.compareTo(i1.amount));

                selMonExpense = snapshot.data!
                    .where((e) =>
                        e.date.month == date.month &&
                        e.date.year == date.year &&
                        e.type == 1)
                    .toList();

                selMonExpense.sort((i1, i2) => i2.amount.compareTo(i1.amount));
              }

              double totalIncome = 0.00;
              double totalExpense = 0.00;

              for (Transactions e in selMonTrxn) {
                if (e.type == 0) {
                  totalIncome += e.amount;
                } else if (e.type == 1) {
                  totalExpense += e.amount;
                }
              }

              return Column(
                children: [
                  Container(
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      children: [
                        Header(date: date, updateParent: refresh),
                        TabBar(tabs: [
                          Tab(child: Text("Income $totalIncome")),
                          Tab(
                            child: Text("Expenses $totalExpense"),
                          )
                        ]),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      (selMonIncome.isEmpty)
                          ? const Center(
                              child: Text("No data"),
                            )
                          : StatDetails(
                              data: selMonIncome,
                              totalAmount: totalIncome,
                            ),
                      (selMonExpense.isEmpty)
                          ? const Center(
                              child: Text("No data"),
                            )
                          : StatDetails(
                              data: selMonExpense,
                              totalAmount: totalExpense,
                            ),
                    ]),
                  )
                ],
              );
            }),
      ),
    );
  }
}
