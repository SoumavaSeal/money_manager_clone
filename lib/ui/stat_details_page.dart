import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_clone/models/categories.dart';
import 'package:money_manager_clone/models/date_controller.dart';
import 'package:money_manager_clone/models/transaction.dart';
import 'package:money_manager_clone/ui/theme.dart';

class StatDetailsPage extends StatefulWidget {
  final List<Transactions> data;
  final Categories selectedNode;
  final List<Categories> allCategories;

  const StatDetailsPage(
      {super.key,
      required this.data,
      required this.selectedNode,
      required this.allCategories});

  @override
  State<StatDetailsPage> createState() {
    return _StatDetailPageState();
  }
}

class _StatDetailPageState extends State<StatDetailsPage> {
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
    double totalBalance = 0;
    Map<int, double> dat = {};

    List<Transactions> selData = widget.data.where((d) {
      int curNode = d.categoryId;
      int parentNode =
          widget.allCategories.where((c) => c.id == curNode).first.parentId;

      parentNode = parentNode == 0 ? curNode : parentNode;
      return parentNode == widget.selectedNode.id;
    }).toList();

    for (Transactions t in selData) {
      totalBalance += t.amount;
      dat[t.categoryId] = (dat[t.categoryId] ?? 0) + t.amount;
    }

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
                    "₹ $totalBalance",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

            Expanded(
              child: ListView.separated(
                itemCount: dat.length,
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
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.allCategories
                                .where((c) => c.id == dat.keys.elementAt(index))
                                .first
                                .description,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "${(dat[dat.keys.elementAt(index)]! / totalBalance * 100).toStringAsFixed(2)}%",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            dat[dat.keys.elementAt(index)]!.toStringAsFixed(2),
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Text("Hello")
          ],
        ),
      ),
    );
  }
}
