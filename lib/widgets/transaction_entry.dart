import 'package:flutter/material.dart';
import 'package:money_manager_clone/models/transaction.dart';

class TransactionEntry extends StatefulWidget{
    final Transaction tran;
    const TransactionEntry({ super.key, required this.tran});

    @override
    State<TransactionEntry> createState() => _TransactionEntryState();
}

class _TransactionEntryState extends State<TransactionEntry>{
    @override
    build(BuildContext context){
        String temp = widget.tran.note;
        return Center(child: Text(temp),);
    }
}
