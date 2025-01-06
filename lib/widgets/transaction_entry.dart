import 'package:flutter/material.dart';
import 'package:money_manager_clone/models/accounts.dart';
import 'package:money_manager_clone/models/categories.dart';
import 'package:money_manager_clone/models/transaction.dart';
import 'package:money_manager_clone/services/database_services.dart';
import 'package:money_manager_clone/ui/theme.dart';
import 'package:money_manager_clone/ui/update_transactions.dart';

class TransactionEntry extends StatefulWidget {
  final Transactions tran;
  const TransactionEntry({super.key, required this.tran});

  @override
  State<TransactionEntry> createState() => _TransactionEntryState();
}

class _TransactionEntryState extends State<TransactionEntry> {
  @override
  build(BuildContext context) {
    final DatabaseServices dbServices = DatabaseServices.dbInstance;

    return FutureBuilder(
        future: Future.wait([
          dbServices.getAccount(), // Get all Account Details
          dbServices.getCategories()
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData == true) {
            List<Account> accList = snapshot.data![0];
            List<Categories> catList = snapshot.data![1];
            catList.add(Categories.blankCat);

            Categories subCat =
                catList.firstWhere((e) => e.id == widget.tran.categoryId);
            Categories cat = catList.firstWhere((e) => e.id == subCat.parentId);

            String primaryAcc =
                accList.firstWhere((e) => e.id == widget.tran.accountId).name;
            String secondaryAcc = "";

            if (widget.tran.type == 2) {
              secondaryAcc = accList
                  .firstWhere((e) => e.id == widget.tran.toAccountID)
                  .name;
            }

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UpdateTransactions(
                          tran: widget.tran,
                          acc: accList[widget.tran.accountId - 1],
                          subAcc: (widget.tran.type == 2)
                              ? accList[widget.tran.toAccountID - 1]
                              : Account.blankAcc,
                          cat: (widget.tran.categoryId == 0)
                              ? Categories.blankCat
                              : catList[widget.tran.categoryId - 1],
                        )));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (widget.tran.type == 2)
                                ? "Transfer"
                                : (cat.description == "")
                                    ? subCat.description
                                    : cat.description,
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            (cat.description == "") ? "" : subCat.description,
                            style: const TextStyle(fontSize: 8),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.tran.note,
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            (widget.tran.type == 2)
                                ? "$primaryAcc → $secondaryAcc"
                                : primaryAcc,
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              widget.tran.amount.toStringAsFixed(2),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: (widget.tran.type == 1)
                                      ? Themes.primaryColor
                                      : (widget.tran.type == 0)
                                          ? Themes.satColor
                                          : Colors.black),
                            ))),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text("No Data"));
          }
        });
  }
}
