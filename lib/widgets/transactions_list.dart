import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_clone/models/transaction.dart';
import 'package:money_manager_clone/ui/theme.dart';
import 'package:money_manager_clone/widgets/transaction_entry.dart';

class TransactionsList extends StatelessWidget {
  final List<Transactions> tranList;

  const TransactionsList({super.key, required this.tranList});

  @override
  Widget build(BuildContext context) {
    if (tranList.isNotEmpty) {
      List<DateTime> dateList = tranList
          .map((e) => DateTime(e.date.year, e.date.month, e.date.day))
          .toSet()
          .toList();

      return ListView.builder(
        itemCount: dateList.length,
        itemBuilder: (context, index) {
          List<Transactions> selDateTrxn =
              tranList.where((e) => e.date.day == dateList[index].day).toList();

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
              const Divider(
                height: 5,
                thickness: 0.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            DateFormat("dd").format(dateList[index]),
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
                                fontSize: 8, color: Themes.primaryTextColor),
                          )),
                      Text(
                        DateFormat("MM.yyyy").format(dateList[index]),
                        style: const TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  Text(
                    income.toStringAsFixed(2),
                    style:
                        const TextStyle(fontSize: 12, color: Themes.satColor),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        expense.toStringAsFixed(2),
                        style: const TextStyle(
                            fontSize: 12, color: Themes.primaryColor),
                      ))
                ],
              ),
              const Divider(
                height: 5,
                thickness: 0.5,
              ),
              for (var i = 0; i < selDateTrxn.length; i++)
                TransactionEntry(tran: selDateTrxn[i])
            ],
          );
        },
      );
    } else {
      return const Center(child: Text("No Data"));
    }
  }
}
