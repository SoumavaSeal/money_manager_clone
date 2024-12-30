import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_clone/ui/theme.dart';
import 'package:money_manager_clone/widgets/account_input.dart';
import 'package:money_manager_clone/widgets/amount_input.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int curTrxnType =
      1; // Transaction type --> { 0 : "Income", 1 : "Expense", 2 : "Transfer" }
  bool isAmtInp = false;
  bool isAcctInp = false;

  String amt = "";
  String category = "";
  String accGrp = "";

  @override
  void initState() {
    amt = "₹ 0.00";
    super.initState();
  }

  void refreshAmt(String amount) {
    setState(() {
      amt = amount;
    });
  }

  void refreshAmtInp(bool amountInput) {
    setState(() {
      isAmtInp = amountInput;
    });
  }

  @override
  build(BuildContext context) {
    List<String> trxnTypes = ["Income", "Expense", "Transfer"];

    return Scaffold(
      body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Column(
              children: [
                // Header Area
                Container(
                  height: 40,
                  color: Theme.of(context).primaryColor,
                  child: Row(
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
                        trxnTypes[curTrxnType],
                        style: const TextStyle(
                            fontSize: 14, color: Themes.primaryTextColor),
                      )
                    ],
                  ),
                ),

                // Transaction Type selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            curTrxnType = 0;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 2),
                          decoration: (curTrxnType == 0)
                              ? BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Themes.primaryColor))
                              : BoxDecoration(border: Border.all(width: 1)),
                          child: Text(
                            "Income",
                            style: TextStyle(
                                color: (curTrxnType == 0)
                                    ? Themes.primaryColor
                                    : Colors.black),
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          setState(() {
                            curTrxnType = 1;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 2),
                          decoration: (curTrxnType == 1)
                              ? BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Themes.primaryColor))
                              : BoxDecoration(border: Border.all(width: 1)),
                          child: Text(
                            "Expense",
                            style: TextStyle(
                                color: (curTrxnType == 1)
                                    ? Themes.primaryColor
                                    : Colors.black),
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          setState(() {
                            curTrxnType = 2;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 2),
                          decoration: (curTrxnType == 2)
                              ? BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Themes.primaryColor))
                              : BoxDecoration(border: Border.all(width: 1)),
                          child: Text(
                            "Transfer",
                            style: TextStyle(
                                color: (curTrxnType == 2)
                                    ? Themes.primaryColor
                                    : Colors.black),
                          ),
                        ))
                  ],
                ),

                // Date selection
                Container(
                  margin: const EdgeInsets.only(top: 20, right: 20),
                  child: Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Text("Date"))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 7,
                          child: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Themes.secondaryTextColor))),
                            child: GestureDetector(
                              child: Text(DateTime.now().toString()),
                              onTap: () {
                                // Need to change this date picker
                                showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1999, 05, 28),
                                  lastDate: DateTime(2999, 05, 28),
                                  initialDate: DateTime.now(),
                                );
                              },
                            ),
                          )),
                    ],
                  ),
                ),

                // Amount Section
                Container(
                  margin: const EdgeInsets.only(top: 20, right: 20),
                  child: Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Text("Amount"))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 7,
                          child: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Themes.secondaryTextColor))),
                            child: GestureDetector(
                              child: Text(amt),
                              onTap: () {
                                setState(() {
                                  isAmtInp = true;
                                });
                              },
                            ),
                          )),
                    ],
                  ),
                ),

                // Category Section
                Container(
                  margin: const EdgeInsets.only(top: 20, right: 20),
                  child: Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 3,
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Text("Category"))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 9,
                          child: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Themes.secondaryTextColor))),
                            child: GestureDetector(
                              child: Text(category),
                              onTap: () {
                                setState(() {
                                  isAmtInp = true;
                                });
                              },
                            ),
                          )),
                    ],
                  ),
                ),

                // Account Section
                Container(
                  margin: const EdgeInsets.only(top: 20, right: 20),
                  child: Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Text("Account"))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 7,
                          child: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Themes.secondaryTextColor))),
                            child: GestureDetector(
                              child: Text(accGrp),
                              onTap: () {
                                setState(() {
                                  isAmtInp = false;
                                  isAcctInp = true;
                                });
                              },
                            ),
                          )),
                    ],
                  ),
                ),

                // Note Section
                Container(
                  margin: const EdgeInsets.only(top: 20, right: 20),
                  child: Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Text("Note"))),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 7,
                        child: TextField(
                          decoration: const InputDecoration(
                              isCollapsed: true,
                              contentPadding: EdgeInsets.all(5)),
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(fontSize: 12, height: 1.0),
                          onSubmitted: (value) {},
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Amount Input keypad
            SizedBox(
              child: (isAmtInp)
                  ? AmountInput(
                      updateParentAmt: refreshAmt,
                      updateParentAmtInp: refreshAmtInp,
                      amt: amt,
                    )
                  : null,
            ),

            // Account Input
            SizedBox(
              child: (isAcctInp) ? const AccountInput() : null,
            )
          ])),
    );
  }
}
