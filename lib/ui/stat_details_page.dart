import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_clone/models/categories.dart';
import 'package:money_manager_clone/models/date_controller.dart';
import 'package:money_manager_clone/models/transaction.dart';
import 'package:money_manager_clone/services/database_services.dart';
import 'package:money_manager_clone/ui/theme.dart';
import 'package:money_manager_clone/widgets/tran_list.dart';

/*
    I want the selectedNode details and need to fetch all the transactions for the last
    five motnhs for the selectedNode
*/

class StatDetailsPage extends StatefulWidget {
  final List<Transactions> data;
  final Categories selectedNode;
  final double initialBalance;
  final List<Categories> allCategories;

  const StatDetailsPage(
      {super.key,
      required this.data,
      required this.selectedNode,
      required this.initialBalance,
      required this.allCategories});

  @override
  State<StatDetailsPage> createState() {
    return _StatDetailPageState();
  }
}

class _StatDetailPageState extends State<StatDetailsPage> {
  DateTime date = DateTime.now();
  int curNode = -1;
  final DateController _dateController = DateController();

  @override
  void initState() {
    _dateController.setDate(date);
    date = _dateController.getDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double totalBalance = 0;
    Map<int, double> dat = {};

    // List<Transactions> selData = widget.data.where((d) {
    //   int curNode = d.categoryId;
    //   int parentNode =
    //       widget.allCategories.where((c) => c.id == curNode).first.parentId;

    //   parentNode = parentNode == 0 ? curNode : parentNode;
    //   return parentNode == widget.selectedNode.id;
    // }).toList();

    // print(widget.selectedNode.description);

    List<Transactions> selData = widget.data;

    for (Transactions t in selData) {
      totalBalance += t.amount;
      dat[t.categoryId] = (dat[t.categoryId] ?? 0) + t.amount;
    }

    dat[-1] = totalBalance;
    widget.allCategories.add(Categories(-1, 0, 0, "All"));

    final DatabaseServices dbservice = DatabaseServices.dbInstance;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
                          widget.selectedNode.description,
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

            Expanded(
              child: FutureBuilder(
                  future: dbservice.getTransactions(),
                  builder: (context, snapshot) {
                    // if snapshot has no data
                    if (snapshot.hasData == false) {
                      return const Center(
                        child: Text("No Data"),
                      );
                    }

                    List<Transactions> allTrxn = [];
                    List<Transactions> relevantTrxn = [];
                    List<Transactions> selMonTrxn = [];
                    Map<int, double> groupCategories = {};
                    Map<String, double> groupPeriods = {};
                    double allBalance = 0;
                    double totalBalance = 0;
                    final spots = <FlSpot>[];

                    // Snapshot has valid data
                    if (snapshot.hasData == true &&
                        snapshot.data.toString() != "[]") {
                      allTrxn = snapshot.data!.where((t) {
                        int curCatId = t.categoryId;
                        int parentId = widget.allCategories
                            .where((c) => c.id == curCatId)
                            .first
                            .parentId;

                        parentId = (parentId == 0) ? curCatId : parentId;

                        return parentId == widget.selectedNode.id;
                      }).toList();

                      // selectedNode transactions
                      relevantTrxn = allTrxn.where((t) {
                        if (curNode == -1) return true;

                        return t.categoryId == curNode;
                      }).toList();

                      // Aggregate in period level
                      for (Transactions t in relevantTrxn) {
                        String key =
                            "${t.date.year}-${t.date.month.toString().padLeft(2, '0')}";

                        groupPeriods[key] = (groupPeriods[key] ?? 0) + t.amount;
                      }

                      // filter out for current month
                      selMonTrxn = allTrxn
                          .where((t) =>
                              t.date.month == date.month &&
                              t.date.year == date.year)
                          .toList();

                      groupCategories = {-1: totalBalance};

                      // Aggregate at sub categories level
                      for (Transactions t in selMonTrxn) {
                        totalBalance += t.amount;
                        groupCategories[t.categoryId] =
                            groupCategories[t.categoryId] ?? 0.0 + t.amount;
                      }

                      // Prepare data for trend Chart
                      int ind = 0;

                      for (var entry in groupPeriods.entries) {
                        spots.add(FlSpot(ind.toDouble(), entry.value));
                        ind++;
                      }

                      groupCategories[-1] = totalBalance;

                      allBalance = groupCategories[curNode] ?? 0;
                    }

                    return Column(
                      children: [
                        // Display Total Balance
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 15, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Balance",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "₹ $allBalance",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        const Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),

                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: groupCategories.length,
                          separatorBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            );
                          },
                          itemBuilder: (context, index) {
                            return Container(
                              height: 30,
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    curNode =
                                        groupCategories.keys.elementAt(index);
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        widget.allCategories
                                            .where((c) =>
                                                c.id ==
                                                groupCategories.keys
                                                    .elementAt(index))
                                            .first
                                            .description,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "${(groupCategories[groupCategories.keys.elementAt(index)]! / totalBalance * 100).toStringAsFixed(2)}%",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        groupCategories[groupCategories.keys
                                                .elementAt(index)]!
                                            .toStringAsFixed(2),
                                        style: TextStyle(fontSize: 14),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        const Divider(
                          thickness: 2,
                        ),

                        SizedBox(
                          height: 260,
                          child: LineChart(LineChartData(
                              lineBarsData: [LineChartBarData(spots: spots)])),
                        ),

                        Expanded(child: TranList(trans: relevantTrxn))
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
