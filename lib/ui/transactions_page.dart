import 'package:flutter/material.dart';
import 'package:money_manager_clone/ui/theme.dart';
import 'package:money_manager_clone/widgets/daily_tran_list.dart';
import 'package:money_manager_clone/widgets/header.dart';

class TransactionsPage extends StatefulWidget{
    
    final DateTime date;

    const TransactionsPage({
        super.key,
        required this.date

    });
    
    @override
    State<TransactionsPage> createState() => _TransactionPageState(); 
}

class _TransactionPageState extends State<TransactionsPage> {
    
    DateTime date = DateTime.now();
    
    // Callback Function to update this widget whenever any changes in the date
    void refresh(DateTime selDate){
        setState(() {
            date = selDate;
        });
    }

    @override
    Widget build(BuildContext context) {
        return SafeArea(
            child: DefaultTabController(
                length: 4,
                child: Column(
                    children: [
                        Header(
                            date: widget.date,
                            updateParent: refresh,
                        ),
                        
                        Container(
                            color: Themes.primaryColor,
                            height: 30,
                            child: const TabBar(
                                tabs: [
                                    Tab(
                                        text: "Daily", 
                                    ),
                                    Tab(
                                        text: "Calander",
                                    ),
                                    Tab(
                                        text: "Monthly", 
                                    ),
                                    Tab(
                                        text: "Total", 
                                    )
                                ],
                            ),
                        ),
                        
                        const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                                Column(
                                    children: [
                                        Text(
                                            "Income",
                                            style: Themes.amtType,
                                        ),
                                        Text("0.00",
                                            style: Themes.amtIncome
                                        ),
                                    ],
                                ),

                                Column(
                                    children: [
                                        Text(
                                            "Expenses",
                                            style: Themes.amtType,
                                        ),
                                        Text(
                                            "0.00",
                                            style: Themes.amtExpense,
                                        ),
                                    ],
                                ),

                                Column(
                                    children: [
                                        Text(
                                            "Total",
                                            style: Themes.amtType,
                                        ),
                                        Text(
                                            "0.00",
                                            style: Themes.amtType,
                                        ),
                                    ],
                                )
                            ],
                        ),
                        
                        Expanded(
                            child: TabBarView(
                                children: [
                                    DailyTranList(date: date),
                                    const Text("Tab2"),
                                    const Text("Tab3"),
                                    const Text("Tab4"),
                                ],
                            ),
                        )
                    ],
                ),
            ),
        );
    }
}
