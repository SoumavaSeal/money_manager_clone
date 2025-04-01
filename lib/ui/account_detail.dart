import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_clone/models/accounts.dart';
import 'package:money_manager_clone/models/date_controller.dart';
import 'package:money_manager_clone/models/transaction.dart';
import 'package:money_manager_clone/services/database_services.dart';
import 'package:money_manager_clone/ui/theme.dart';
import 'package:money_manager_clone/ui/update_account.dart';
import 'package:money_manager_clone/widgets/transactions_list.dart';

class AccountDetail extends StatefulWidget {
  final Account acc;

  const AccountDetail({super.key, required this.acc});

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  DateTime date = DateTime.now();
  final DateController _dateController = DateController();

  @override
  void initState() {
    _dateController.setDate(date);
    date = _dateController.getDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Account account = widget.acc;
    final DatabaseServices dbservice = DatabaseServices.dbInstance;

    DateTime fromDate = DateTime(date.year, date.month, 1);
    DateTime toDate = DateTime(date.year, date.month + 1, 0);

    return Scaffold(
        body: SafeArea(
      child: FutureBuilder(
          future: dbservice.getTransactions(),
          builder: (context, snapshot) {
            List<Transactions> trxnList = [];
            double deposit = 0.00;
            double withdrawn = 0.00;

            if (snapshot.hasData == true && snapshot.data.toString() != "[]") {
              trxnList = snapshot.data!
                  .where((e) =>
                      e.date.month == date.month &&
                      e.date.year == date.year &&
                      e.accountId == widget.acc.id)
                  .toList();

              for (Transactions trxn in trxnList) {
                if (trxn.type == 0) {
                  deposit += trxn.amount;
                } else if (trxn.type == 1) {
                  withdrawn += trxn.amount;
                } else {
                  if (trxn.accountId == widget.acc.id) {
                    withdrawn += trxn.amount;
                  } else if (trxn.toAccountID == widget.acc.id) {
                    deposit += trxn.amount;
                  }
                }
              }
            }

            return Column(children: [
              // Header
              Container(
                  height: 40,
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.arrowLeft,
                              size: 12,
                              color: Themes.primaryTextColor,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            account.name,
                            style:
                                const TextStyle(color: Themes.primaryTextColor),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 0),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _dateController.prevMonth();
                                    date = _dateController.getDate();
                                  });
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.angleLeft,
                                  size: 12,
                                  color: Theme.of(context).secondaryHeaderColor,
                                )),
                          ),
                          Text(
                            "${_dateController.months[date.month - 1]} ${date.year}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _dateController.nextMonth();
                                    date = _dateController.getDate();
                                  });
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.angleRight,
                                  size: 12,
                                  color: Theme.of(context).secondaryHeaderColor,
                                )),
                          ),
                        ],
                      ),
                    ],
                  )),

              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Statement",
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        Text(
                          "${fromDate.day.toString().padLeft(2, "0")}.${fromDate.month.toString().padLeft(2, "0")}.${fromDate.year} ~ ${toDate.day}.${toDate.month.toString().padLeft(2, "0")}.${toDate.year}",
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    UpdateAccount(acc: account))),
                        child: const FaIcon(
                          FontAwesomeIcons.pen,
                          size: 12,
                        ))
                  ],
                ),
              ),

              const Divider(
                height: 5,
                thickness: 0.5,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            const Text(
                              "Deposit",
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(deposit.toString())
                          ],
                        )),
                    Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            const Text(
                              "Withdrawn",
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(withdrawn.toString())
                          ],
                        )),
                    Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            const Text(
                              "Total",
                              style: TextStyle(fontSize: 10),
                            ),
                            Text((deposit - withdrawn).toString())
                          ],
                        )),
                  ],
                ),
              ),

              Expanded(child: TransactionsList(tranList: trxnList))
            ]);
          }),
    ));
  }
}
