import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_clone/models/accounts.dart';
import 'package:money_manager_clone/models/transaction.dart';
import 'package:money_manager_clone/services/database_services.dart';
import 'package:money_manager_clone/ui/home_page.dart';
import 'package:money_manager_clone/ui/theme.dart';

class UpdateAccount extends StatefulWidget {
  final Account acc;
  const UpdateAccount({super.key, required this.acc});

  @override
  State<UpdateAccount> createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  // Database Services
  final DatabaseServices _dbServices = DatabaseServices.dbInstance;

  int curgrp = 0;

  // Text Controllers
  final TextEditingController amtController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void initState() {
    curgrp = widget.acc.accountGroup - 1;
    nameController.text = widget.acc.name;
    amtController.text = widget.acc.amount.toString();
    descController.text = widget.acc.description;
    super.initState();
  }

  // void refreshAmt(String amount) {
  //   setState(() {
  //     amt = amount;
  //   });
  // }

  // void refreshAmtInp(bool amountInput) {
  //   setState(() {
  //     isAmtInp = amountInput;
  //   });
  // }

  @override
  build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(children: [
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
                const Text(
                  "Add Account",
                  style:
                      TextStyle(fontSize: 14, color: Themes.primaryTextColor),
                )
              ],
            ),
          ),

          // First Input field i.e. Account Group
          Container(
            margin: const EdgeInsets.only(top: 20, right: 20),
            child: Row(
              children: [
                Flexible(
                    fit: FlexFit.tight,
                    flex: 2,
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text("Group"))),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 7,
                  child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Themes.secondaryTextColor))),
                      child: FutureBuilder(
                          future: _dbServices.getAccountGrp(),
                          builder: (context, snapshot) {
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      alignment: Alignment.center,
                                      child: Container(
                                          color: Themes.primaryTextColor,
                                          height: size.height * 0.6,
                                          width: size.width,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 10),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10, left: 10),
                                                  child: const Text(
                                                    "Account Group",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: ListView.builder(
                                                        itemCount: snapshot
                                                            .data!.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Container(
                                                            width: size.width,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        10),
                                                            decoration: const BoxDecoration(
                                                                border: Border(
                                                                    top: BorderSide(
                                                                        color: Themes
                                                                            .secondaryTextColor,
                                                                        width:
                                                                            0.4))),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () =>
                                                                  setState(() {
                                                                curgrp = index;
                                                                Navigator.pop(
                                                                    context);
                                                              }),
                                                              child: Text(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .name),
                                                            ),
                                                          );
                                                        }))
                                              ])),
                                    );
                                  },
                                );
                              },
                              child: (snapshot.data == null)
                                  ? const Text("")
                                  : Text(snapshot.data![curgrp].name),
                            );
                          })),
                ),
              ],
            ),
          ),

          // Second Input Field i.e., Account Name
          Container(
            margin: const EdgeInsets.only(top: 20, right: 20),
            child: Row(
              children: [
                Flexible(
                    fit: FlexFit.tight,
                    flex: 2,
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text("Name"))),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 7,
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        isCollapsed: true, contentPadding: EdgeInsets.all(5)),
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

          // Third Input Value i.e., Amount
          Container(
            margin: const EdgeInsets.only(top: 20, right: 20),
            child: Row(
              children: [
                Flexible(
                    fit: FlexFit.tight,
                    flex: 2,
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text("Amount"))),
                Flexible(
                    fit: FlexFit.tight,
                    flex: 7,
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Themes.secondaryTextColor))),
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
                    )),
              ],
            ),
          ),

          // Fourth Input i.e., Description
          Container(
            margin: const EdgeInsets.only(top: 20, right: 20),
            child: Row(
              children: [
                Flexible(
                    fit: FlexFit.tight,
                    flex: 3,
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 9,
                          ),
                        ))),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 9,
                  child: TextField(
                    controller: descController,
                    decoration: const InputDecoration(
                        isCollapsed: true,
                        contentPadding: EdgeInsets.all(5),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3, color: Themes.secondaryTextColor))),
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(fontSize: 12, height: 1.0),
                    onTapOutside: (size) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 30),
            width: size.width * 0.9,
            child: ElevatedButton(
                child: const Text("Update"),
                onPressed: () {
                  var acc = Account(
                      id: widget.acc.id,
                      name: nameController.text,
                      accountGroup: curgrp + 1,
                      initialAmt: widget.acc.initialAmt,
                      amount: double.parse(amtController.text),
                      description: descController.text);

                  Map<String, Object?> values = {
                    'name': acc.name,
                    'acc_grp': acc.accountGroup,
                    'initial_amt': acc.initialAmt,
                    'amount': acc.amount,
                    'description': acc.description
                  };

                  var diffAmt =
                      double.parse(amtController.text) - widget.acc.amount;

                  var type = (diffAmt < 0) ? 1 : 0;

                  if (diffAmt != 0) {
                    Transactions trxn = Transactions(0, diffAmt, DateTime.now(),
                        type, 0, widget.acc.id, 0, "Modified", "");
                    _dbServices.addTransaction(trxn);
                  }

                  _dbServices.updateData(
                      _dbServices.accountsTable, acc.id.toString(), values);

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomePage(
                            initialIndex: 2,
                          )));
                }),
          ),
        ]),
      ],
    )));
  }
}
