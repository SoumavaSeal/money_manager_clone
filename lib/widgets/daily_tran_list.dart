import 'package:flutter/material.dart';
import 'package:money_manager_clone/models/transaction.dart';
import 'package:money_manager_clone/widgets/transaction_entry.dart';

class DailyTranList extends StatefulWidget{
    final DateTime date;

    const DailyTranList({ super.key, required this.date });

    @override
    State<DailyTranList> createState() => _DailyTranList();
}

class _DailyTranList extends State<DailyTranList> {
    
    final List<Transaction> tranList= [
        Transaction(1,100.0,DateTime(2024,08,03),1,1,1,"with SB", ""),
        Transaction(2,100.0,DateTime(2024,08,03),1,1,1,"with SB", ""),
        Transaction(3,100.0,DateTime(2024,08,03),1,1,1,"with SB", ""),
        Transaction(4,100.0,DateTime(2024,08,03),1,1,1,"with SB", ""),
        Transaction(5,100.0,DateTime(2024,08,03),1,1,1,"with SB", ""),
    ];

    @override
    Widget build(BuildContext context) {
        return ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index){
                return Column(
                    children: [
                        
                        const Divider(),

                        const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Row(
                                    children: [
                                        Text('03'),
                                        Text('Sat'),
                                        Text('08.2024')
                                    ],
                                ),

                                Text("0.00"),
                                Text("0.00")

                            ],
                        ),

                        const Divider(),
                        
                        for( var i=0; i<tranList.length; i++) TransactionEntry(tran: tranList[0])
                    ],
                );
            },
        );
    }
}
