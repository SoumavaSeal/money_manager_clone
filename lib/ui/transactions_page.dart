import 'package:flutter/material.dart';
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
                        
                        const TabBar(
                            tabs: [
                                Tab(
                                    child: Text("Daily"),
                                ),
                                Tab(
                                    child: Text("Calendar"),
                                ),
                                Tab(
                                    child: Text("Monthly"),
                                ),
                                Tab(
                                    child: Text("Total"),
                                )
                            ],
                        ),
                        
                        const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                                Column(
                                    children: [
                                        Text("Income"),
                                        Text("0.00"),
                                    ],
                                ),

                                Column(
                                    children: [
                                        Text("Expenses"),
                                        Text("0.00"),
                                    ],
                                ),

                                Column(
                                    children: [
                                        Text("Total"),
                                        Text("0.00"),
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
