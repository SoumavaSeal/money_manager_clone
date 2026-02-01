import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:money_manager_clone/models/categories.dart';
import 'package:money_manager_clone/models/transaction.dart';
import 'package:money_manager_clone/services/database_services.dart';
import 'package:money_manager_clone/ui/stat_details_page.dart';

class StatDetails extends StatelessWidget {
  final List<Transactions> data;
  final double totalAmount;

  const StatDetails({super.key, required this.data, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    Map<int, double> dat = {};

    // for (Transactions d in data) {
    //   dat[d.categoryId] = (dat[d.categoryId] ?? 0) + d.amount;
    // }

    DatabaseServices dbservices = DatabaseServices.dbInstance;

    return FutureBuilder(
        future: dbservices.getCategories(),
        builder: (context, snapshot) {
          List<Categories> cat = [];

          List<Color> colors = [
            Colors.red,
            Colors.purple,
            Colors.blueAccent,
            Colors.yellow,
            Colors.green
          ];

          if (snapshot.hasData == false) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasData == true) {
            dat = {};
            cat = snapshot.data!.toList();

            for (Transactions d in data) {
              int catID = d.categoryId;
              int parentID = cat.where((c) => c.id == catID).first.parentId;
              parentID = (parentID == 0)
                  ? catID
                  : parentID; // When there is no parent then this is the root node
              dat[parentID] = (dat[parentID] ?? 0) + d.amount;
            }
          }

          return Column(
            children: [
              Container(
                  height: 210,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  // color: Colors.white,
                  // width: 150,
                  child: PieChart(
                    PieChartData(
                      sections: dat.entries.indexed
                          .map((e) => PieChartSectionData(
                                title: "",
                                // (cat.isEmpty)
                                // ? ""
                                // : cat
                                //     .where((c) => c.id == e.$2.key)
                                //     .first
                                //     .description,
                                value: e.$2.value,
                                radius: 30,
                                color: colors[e.$1],
                                // titlePositionPercentageOffset: 0.5
                              ))
                          .toList(),
                      pieTouchData: PieTouchData(enabled: true),
                      // startDegreeOffset: 0,
                      sectionsSpace: 5,
                    ),
                    duration: const Duration(milliseconds: 150), // Optional
                    curve: Curves.linear, // Optional
                  )),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemBuilder: ((context, index) => GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => StatDetailsPage(
                                      data: data.where((d) {
                                        int catId = d.categoryId;
                                        int parentId = cat
                                            .where((c) => c.id == catId)
                                            .first
                                            .parentId;
                                        parentId =
                                            parentId == 0 ? catId : parentId;

                                        return parentId ==
                                            dat.keys.elementAt(index);
                                      }).toList(),
                                      selectedNode: cat
                                          .where((c) =>
                                              c.id == dat.keys.elementAt(index))
                                          .first,
                                      allCategories: cat,
                                    ))),
                        child: Container(
                          // height: 25,

                          decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 0.5, color: Colors.grey)),
                            // color: Colors.white
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    color: colors[index],
                                    child: Text(
                                      '${(dat[(dat.keys).elementAt(index)]! * 100 / totalAmount).round()}%',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(cat
                                      .where((c) =>
                                          c.id == (dat.keys).elementAt(index))
                                      .first
                                      .description),
                                ],
                              ),
                              // Text("₹ ${data[index].amount.round()}")
                              Text("₹ ${dat[(dat.keys).elementAt(index)]}")
                            ],
                          ),
                        ),
                      )),
                  itemCount: dat.length,
                ),
              )
            ],
          );
        });
  }
}
