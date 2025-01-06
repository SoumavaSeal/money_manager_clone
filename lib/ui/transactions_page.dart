import 'package:flutter/material.dart';
import 'package:money_manager_clone/models/transaction.dart';
import 'package:money_manager_clone/services/database_services.dart';
import 'package:money_manager_clone/ui/theme.dart';
import 'package:money_manager_clone/widgets/daily_tran_list.dart';
import 'package:money_manager_clone/widgets/header.dart';

class TransactionsPage extends StatefulWidget {
  final DateTime date;

  const TransactionsPage({super.key, required this.date});

  @override
  State<TransactionsPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionsPage> {
  DateTime date = DateTime.now();

  // Callback Function to update this widget whenever any changes in the date
  void refresh(DateTime selDate) {
    setState(() {
      date = selDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseServices dbservices = DatabaseServices.dbInstance;

    return FutureBuilder(
        future: dbservices.getTransactions(),
        builder: (context, snapshot) {
          List<Transactions> selMonTrxn = [];

          if (snapshot.hasData == true) {
            selMonTrxn = snapshot.data!
                .where((e) => e.date.month == date.month)
                .toList();
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

          return SafeArea(
            child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  Header(
                    date: date,
                    updateParent: refresh,
                  ),
                  Container(
                    color: Themes.primaryColor,
                    height: 30,
                    child: const TabBar(
                      tabs: [
                        Tab(
                          text: "Daily",
                        ),
                        Tab(
                          text: "Calander",
                        ),
                        Tab(
                          text: "Monthly",
                        ),
                        Tab(
                          text: "Total",
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Income",
                            style: Themes.amtType,
                          ),
                          Text(totalIncome.toStringAsFixed(2),
                              style: Themes.amtIncome),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "Expenses",
                            style: Themes.amtType,
                          ),
                          Text(
                            totalExpense.toStringAsFixed(2),
                            style: Themes.amtExpense,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "Total",
                            style: Themes.amtType,
                          ),
                          Text(
                            (totalIncome - totalExpense).toStringAsFixed(2),
                            style: Themes.amtType,
                          ),
                        ],
                      )
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        DailyTranList(date: date),
                        const Text("Tab2"),
                        const Text("Tab3"),
                        const Text("Tab4"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
