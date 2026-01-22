import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_clone/models/accounts.dart';
import 'package:money_manager_clone/models/categories.dart';
import 'package:money_manager_clone/models/transaction.dart';
import 'package:money_manager_clone/services/database_services.dart';
import 'package:money_manager_clone/ui/home_page.dart';
import 'package:money_manager_clone/ui/theme.dart';
import 'package:money_manager_clone/widgets/account_input.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_clone/widgets/category_input.dart';

class UpdateTransactions extends StatefulWidget {
  final Transactions tran;
  final Account acc;
  final Account subAcc;
  final Categories cat;

  const UpdateTransactions(
      {super.key,
      required this.tran,
      required this.acc,
      required this.subAcc,
      required this.cat});

  @override
  State<UpdateTransactions> createState() => _UpdateTransactionsState();
}

class _UpdateTransactionsState extends State<UpdateTransactions> {
  // DB instance
  final DatabaseServices dbservice = DatabaseServices.dbInstance;

  // Initial Defualt Values

  // Transaction type --> { 0 : "Income", 1 : "Expense", 2 : "Transfer" }
  int curTrxnType = 1;
  Account selAcc = Account.blankAcc;
  Account selSubAcc = Account.blankAcc;
  Categories selCat = Categories.blankCat;
  DateTime curDate = DateTime.now();

  // Input Boxes indicators
  bool isAcctInp = false;
  bool isSubAcctInp = false;
  bool isCatInp = false;

  // Text Controllers
  final amtController = TextEditingController();
  final noteController = TextEditingController();

  // Account and Category list
  List<Account> accList = [];
  List<Categories> catList = [];

  @override
  void initState() {
    curTrxnType = widget.tran.type;
    curDate = widget.tran.date;
    amtController.text = "₹ ${widget.tran.amount}";
    noteController.text = widget.tran.note;
    selAcc = widget.acc;
    selSubAcc = widget.subAcc;
    selCat = widget.cat;

    super.initState();
  }

  @override
  void dispose() {
    amtController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void refreshAcctInp(bool accountInput) {
    setState(() {
      isAcctInp = accountInput;
    });
  }

  void refreshSubAcctInp(bool accountInput) {
    setState(() {
      isSubAcctInp = accountInput;
    });
  }

  void refreshAcc(Account acc) {
    setState(() {
      selAcc = acc;
    });
  }

  void refreshSubAcc(Account acc) {
    setState(() {
      selSubAcc = acc;
    });
  }

  void refreshCatInp(bool categoryInput) {
    setState(() {
      isCatInp = categoryInput;
    });
  }

  void refreshCat(Categories cat) {
    setState(() {
      selCat = cat;
    });
  }

  @override
  build(BuildContext context) {
    List<String> trxnTypes = ["Income", "Expense", "Transfer"];
    Size size = MediaQuery.of(context).size;

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
                            isAcctInp = false;
                            isCatInp = false;
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
                              child: Row(children: [
                                GestureDetector(
                                  child: Text(DateFormat('dd/MM/yyyy (EEE)')
                                      .format(curDate)
                                      .toString()),
                                  onTap: () async {
                                    // Need to change this date picker
                                    final DateTime? pickedDate =
                                        await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1999, 05, 28),
                                      lastDate: DateTime(2999, 05, 28),
                                      initialDate: DateTime.now(),
                                    );

                                    if (pickedDate != null) {
                                      setState(() {
                                        curDate = DateTime(
                                            pickedDate.year,
                                            pickedDate.month,
                                            pickedDate.day,
                                            curDate.hour,
                                            curDate.minute);
                                      });
                                    }
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  child: Text(DateFormat()
                                      .add_jm()
                                      .format(curDate)
                                      .toString()),
                                  onTap: () async {
                                    // Need to change this date picker
                                    final TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime:
                                          TimeOfDay.fromDateTime(curDate),
                                    );

                                    if (pickedTime != null) {
                                      setState(() {
                                        curDate = DateTime(
                                            curDate.year,
                                            curDate.month,
                                            curDate.day,
                                            pickedTime.hour,
                                            pickedTime.minute);
                                      });
                                    }
                                  },
                                ),
                              ]))),
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
                        child: TextField(
                          controller: amtController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              isCollapsed: true,
                              contentPadding: EdgeInsets.all(5)),
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(fontSize: 12, height: 1.0),
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Category Section
                (curTrxnType != 2)
                    ? Container(
                        margin: const EdgeInsets.only(top: 20, right: 20),
                        child: Row(
                          children: [
                            Flexible(
                                fit: FlexFit.tight,
                                flex: 3,
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: const Text("Category"))),
                            Flexible(
                                fit: FlexFit.tight,
                                flex: 9,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color:
                                                  Themes.secondaryTextColor))),
                                  child: GestureDetector(
                                    child: Text(selCat.description),
                                    onTap: () {
                                      setState(() {
                                        isAcctInp = false;
                                        isCatInp = true;
                                      });
                                    },
                                  ),
                                )),
                          ],
                        ),
                      )
                    : Container(),

                // Primary Account Section
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
                              child: (curTrxnType == 2)
                                  ? const Text("From")
                                  : const Text("Account"))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 7,
                          child: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Themes.secondaryTextColor))),
                            child: GestureDetector(
                              child: Text(selAcc.name),
                              onTap: () {
                                setState(() {
                                  isCatInp = false;
                                  isAcctInp = true;
                                });
                              },
                            ),
                          )),
                    ],
                  ),
                ),

                // Secondary Account Section
                (curTrxnType == 2)
                    ? Container(
                        margin: const EdgeInsets.only(top: 20, right: 20),
                        child: Row(
                          children: [
                            Flexible(
                                fit: FlexFit.tight,
                                flex: 2,
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: const Text("To"))),
                            Flexible(
                                fit: FlexFit.tight,
                                flex: 7,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color:
                                                  Themes.secondaryTextColor))),
                                  child: GestureDetector(
                                    child: Text(selSubAcc.name),
                                    onTap: () {
                                      setState(() {
                                        isCatInp = false;
                                        isAcctInp = false;
                                        isSubAcctInp = true;
                                      });
                                    },
                                  ),
                                )),
                          ],
                        ),
                      )
                    : Container(),

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
                          controller: noteController,
                          decoration: const InputDecoration(
                              isCollapsed: true,
                              contentPadding: EdgeInsets.all(5)),
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(fontSize: 12, height: 1.0),
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Update Button
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: size.width * 0.9,
                  child: ElevatedButton(
                      child: const Text("Update"),
                      onPressed: () {
                        var trxn = Transactions(
                            widget.tran.id,
                            double.parse(amtController.text.substring(2)),
                            curDate,
                            curTrxnType,
                            selCat.id,
                            selAcc.id,
                            selSubAcc.id,
                            noteController.text,
                            "");

                        Map<String, Object?> values = {
                          'amount': trxn.amount,
                          'date': trxn.date.toIso8601String(),
                          'type': trxn.type,
                          'categoryId': trxn.categoryId,
                          'accountId': trxn.accountId,
                          'toAccountId': trxn.toAccountID,
                          'note': trxn.note,
                          'description': trxn.description
                        };

                        dbservice.updateData(
                            dbservice.trxnTable, trxn.id.toString(), values);

                        double newAccAmt = 0.00;
                        double newSubAccAmt = 0.00;

                        // Removing old trxn amount record from Account table
                        if (widget.tran.type == 0) {
                          newAccAmt = widget.acc.amount - trxn.amount;
                        } else if (widget.tran.type == 1) {
                          newAccAmt = widget.acc.amount + trxn.amount;
                        } else if (widget.tran.type == 2) {
                          newAccAmt = widget.acc.amount + trxn.amount;
                          newSubAccAmt = widget.subAcc.amount - trxn.amount;

                          dbservice.updateAccountData(
                              "amount",
                              newSubAccAmt.toString(),
                              widget.subAcc.id.toString());
                        }

                        dbservice.updateAccountData("amount",
                            newAccAmt.toString(), widget.acc.id.toString());

                        double temp = newAccAmt;

                        if (selAcc.id == widget.subAcc.id) {
                          newAccAmt = newSubAccAmt;
                        } else if (selAcc.id != widget.acc.id) {
                          newAccAmt = selAcc.amount;
                        }

                        if (selSubAcc.id == widget.acc.id) {
                          newSubAccAmt = temp;
                        } else if (selSubAcc.id != widget.subAcc.id) {
                          newSubAccAmt = selSubAcc.amount;
                        }

                        // Adding new trxn amount record from Account table
                        if (trxn.type == 0) {
                          newAccAmt = newAccAmt + trxn.amount;
                        } else if (trxn.type == 1) {
                          newAccAmt = (newAccAmt - trxn.amount);
                        } else if (trxn.type == 2) {
                          newAccAmt = newAccAmt - trxn.amount;
                          newSubAccAmt = newSubAccAmt + trxn.amount;

                          dbservice.updateAccountData("amount",
                              newSubAccAmt.toString(), selSubAcc.id.toString());
                        }

                        dbservice.updateAccountData("amount",
                            newAccAmt.toString(), selAcc.id.toString());

                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HomePage(initialIndex: 0)));
                      }),
                ),
              ],
            ),

            // Account Input
            SizedBox(
              child: (isAcctInp)
                  ? AccountInput(
                      updateParentAcctInp: refreshAcctInp,
                      updateParentAcct: refreshAcc)
                  : null,
            ),

            SizedBox(
              child: (isSubAcctInp)
                  ? AccountInput(
                      updateParentAcctInp: refreshSubAcctInp,
                      updateParentAcct: refreshSubAcc)
                  : null,
            ),

            // Category Input
            SizedBox(
              child: (isCatInp)
                  ? CategoryInput(
                      updateParentCattInp: refreshCatInp,
                      updateParentCat: refreshCat,
                      curTrxnType: curTrxnType)
                  : null,
            ),
          ])),
    );
  }
}
