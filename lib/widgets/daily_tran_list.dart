import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_clone/models/transaction.dart';
import 'package:money_manager_clone/services/database_services.dart';
import 'package:money_manager_clone/ui/theme.dart';
import 'package:money_manager_clone/widgets/transaction_entry.dart';

class DailyTranList extends StatefulWidget {
  final DateTime date;

  const DailyTranList({super.key, required this.date});

  @override
  State<DailyTranList> createState() => _DailyTranList();
}

class _DailyTranList extends State<DailyTranList> {
  // Initializing database services
  final DatabaseServices dbservice = DatabaseServices.dbInstance;

  List<Transactions> tranList = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dbservice.getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.hasData == true && snapshot.data.toString() != "[]") {
            tranList = snapshot.data!
                .where((e) =>
                    e.date.month == widget.date.month &&
                    e.date.year == widget.date.year)
                .toList();

            if (tranList.isNotEmpty) {
              List<DateTime> dateList = tranList
                  .map((e) => DateTime(e.date.year, e.date.month, e.date.day))
                  .toSet()
                  .toList();

              return ListView.builder(
                itemCount: dateList.length,
                itemBuilder: (context, index) {
                  List<Transactions> selDateTrxn = tranList
                      .where((e) => e.date.day == dateList[index].day)
                      .toList();

                  double income = 0.00;
                  double expense = 0.00;

                  for (var e in selDateTrxn) {
                    if (e.type == 0) {
                      income += e.amount;
                    } else if (e.type == 1) {
                      expense += e.amount;
                    }
                  }

                  return Column(
                    children: [
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    DateFormat("dd").format(dateList[index]),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Themes.satColor,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  margin: const EdgeInsets.only(right: 5),
                                  child: Text(
                                    DateFormat("EEE").format(dateList[index]),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Themes.primaryTextColor),
                                  )),
                              Text(
                                DateFormat("MM.yyyy").format(dateList[index]),
                                style: const TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                          Text(
                            income.toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 12, color: Themes.satColor),
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                expense.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 12, color: Themes.primaryColor),
                              ))
                        ],
                      ),
                      const Divider(),
                      for (var i = 0; i < selDateTrxn.length; i++)
                        TransactionEntry(tran: selDateTrxn[i])
                    ],
                  );
                },
              );
            } else {
              return const Center(child: Text("No Data"));
            }
          } else {
            return const Center(child: Text("No Data"));
          }
        });
  }
}
