import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_clone/models/categories.dart';
import 'package:money_manager_clone/services/database_services.dart';
import 'package:money_manager_clone/ui/theme.dart';

class CategoryInput extends StatefulWidget {
  final dynamic updateParentCattInp;
  final dynamic updateParentCat;
  final int curTrxnType;

  const CategoryInput(
      {super.key,
      required this.updateParentCattInp,
      required this.updateParentCat,
      required this.curTrxnType});

  @override
  State<CategoryInput> createState() => _CategoryInputState();
}

class _CategoryInputState extends State<CategoryInput> {
  int curCat = 0;

  @override
  void initState() {
    curCat = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseServices dbServices = DatabaseServices.dbInstance;

    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: dbServices.getCategories(), // Get all Categories Details
        builder: (context, snapshot) {
          List<Categories> catList = [];
          List<Categories> subCatList = [];

          if (snapshot.hasData) {
            catList = snapshot.data!
                .where((e) => e.parentId == 0 && e.type == widget.curTrxnType)
                .toList();
            subCatList =
                snapshot.data!.where((e) => e.parentId == curCat).toList();
          }

          return Column(
            children: [
              // Input Box border
              Container(
                color: Colors.black,
                height: 30,
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Category",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    IconButton(
                        icon: const FaIcon(
                          FontAwesomeIcons.xmark,
                          size: 12,
                          color: Themes.secondaryTextColor,
                        ),
                        onPressed: () {
                          widget.updateParentCattInp(false);
                        })
                  ],
                ),
              ),

              Row(
                children: [
                  SizedBox(
                    height: size.height * 0.3,
                    width: size.width * 0.5,
                    child: ListView.builder(
                      itemCount: catList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              curCat = catList[index].id;
                            });
                          },
                          onDoubleTap: () {
                            widget.updateParentCat(catList[index]);
                            widget.updateParentCattInp(false);
                          },
                          child: Container(
                            height: size.height * 0.3 / 5,
                            decoration: const BoxDecoration(
                                border: Border(
                              left: BorderSide(color: Colors.black, width: 0.5),
                              right:
                                  BorderSide(color: Colors.black, width: 0.5),
                              bottom:
                                  BorderSide(color: Colors.black, width: 0.5),
                            )),
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              catList[index].description,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.3,
                    width: size.width * 0.5,
                    child: ListView.builder(
                      itemCount: subCatList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            widget.updateParentCat(subCatList[index]);
                            widget.updateParentCattInp(false);
                          },
                          child: Container(
                            height: size.height * 0.3 / 5,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                border: Border(
                              left: BorderSide(color: Colors.black, width: 0.5),
                              right:
                                  BorderSide(color: Colors.black, width: 0.5),
                              bottom:
                                  BorderSide(color: Colors.black, width: 0.5),
                            )),
                            child: Text(
                              subCatList[index].description,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}
