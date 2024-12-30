import 'package:flutter/material.dart';
import 'package:money_manager_clone/models/transaction.dart';
import 'package:money_manager_clone/ui/theme.dart';
import 'package:money_manager_clone/widgets/transaction_entry.dart';

class DailyTranList extends StatefulWidget{
    final DateTime date;

    const DailyTranList({ super.key, required this.date });

    @override
    State<DailyTranList> createState() => _DailyTranList();
}

class _DailyTranList extends State<DailyTranList> {
    
    final List<Transactions> tranList= [
        Transactions(1,100.0,DateTime(2024,08,03),1,1,1,"with SB", ""),
        Transactions(2,100.0,DateTime(2024,08,03),1,1,1,"with SB", ""),
        Transactions(3,100.0,DateTime(2024,08,03),1,1,1,"with SB", ""),
        Transactions(4,100.0,DateTime(2024,08,03),1,1,1,"with SB", ""),
        Transactions(5,100.0,DateTime(2024,08,03),1,1,1,"with SB", ""),
    ];

    @override
    Widget build(BuildContext context) {
        return ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index){
                return Column(
                    children: [
                        
                        const Divider(),

                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                                Row(
                                    children: [
                                        Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 5),
                                            child: const Text(
                                                '03',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold
                                                ),
                                            )
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                color: Themes.satColor,
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                            margin: const EdgeInsets.only(right: 5),
                                            child: const Text(
                                                'Sat',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Themes.primaryTextColor
                                                ),
                                            )
                                        ),
                                        const Text(
                                            '08.2024',
                                            style: TextStyle(
                                                fontSize: 10 
                                            ),
                                        )
                                    ],
                                ),

                                const Text(
                                    "0.00",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),
                                ),
                                Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                    child: const Text(
                                        "0.00",
                                        style: TextStyle(
                                            fontSize: 12
                                        ),    
                                    )
                                )

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
