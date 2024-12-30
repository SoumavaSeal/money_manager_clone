import 'package:flutter/material.dart';
import 'package:money_manager_clone/models/transaction.dart';

class TransactionEntry extends StatefulWidget{
    final Transactions tran;
    const TransactionEntry({ super.key, required this.tran});

    @override
    State<TransactionEntry> createState() => _TransactionEntryState();
}

class _TransactionEntryState extends State<TransactionEntry>{
    @override
    build(BuildContext context){
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
                children: [
                    const Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    "Personal",
                                    style: TextStyle(
                                        fontSize: 10,
                                    ),
                                ),

                                Text(
                                    "Transpotation",
                                    style: TextStyle(
                                        fontSize: 8
                                    ),
                                ),

                                SizedBox(height: 10,),

                            ],
                        ),
                    ),

                    Flexible(
                        flex: 5,
                        fit: FlexFit.tight,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                
                                Text(
                                    widget.tran.note,
                                    style: const TextStyle(
                                        fontSize: 12
                                    ),
                                ),
                                
                                const Text(
                                    "BOB",
                                    style: TextStyle(
                                        fontSize: 10
                                    ),
                                )
                            ],
                        ),
                    ),

                    Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: const Text(
                                "0.00",
                                style: TextStyle(
                                    fontSize: 12
                                ),
                            ),
                        )                    ),

                    Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: const Text(
                                "0.00",
                                style: TextStyle(
                                    fontSize: 12
                                ),
                            )
                        )
                    ),
                ],
            ),
        );
    }
}
