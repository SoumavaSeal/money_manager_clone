import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_clone/ui/accounts_page.dart';
import 'package:money_manager_clone/ui/add_transaction.dart';
import 'package:money_manager_clone/ui/transactions_page.dart';

class HomePage extends StatefulWidget{
    final int initialIndex;
    const HomePage({super.key, required this.initialIndex});
    
    @override
    State<HomePage> createState() => _HomePageState(); 
}

class _HomePageState extends State<HomePage>{

    int _currIndex = 0; // Current selected Page    
    
    List<Widget> widgetList = [
        TransactionsPage(date: DateTime.now()),
        const Center(child: Text("StatPage")),
        const AccountsPage(),
        const Center(child: Text("MorePage")),
    ];

    @override
    void initState() {
        _currIndex = widget.initialIndex;
        super.initState();
    }
    

    @override
    Widget build(BuildContext context){
        return  Scaffold(
            resizeToAvoidBottomInset: true,
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currIndex,
                onTap: (index){
                    setState(() {
                        _currIndex = index;
                    });
                },
                type: BottomNavigationBarType.fixed,
                items: const [
                    BottomNavigationBarItem(
                        icon: FaIcon(
                            FontAwesomeIcons.book,
                            size: 18,
                        ),
                        label: "Trans.",
                    ),

                    BottomNavigationBarItem(
                        icon: FaIcon(
                            FontAwesomeIcons.chartLine,
                            size: 18,
                        ),
                        label: "Stats"
                    ),

                    BottomNavigationBarItem(
                        icon: FaIcon(
                            FontAwesomeIcons.database,
                            size: 18
                        ),
                        label: "Accounts"
                    ),

                    BottomNavigationBarItem(
                        icon: FaIcon(
                            FontAwesomeIcons.ellipsis,
                            size: 18,
                        ),
                        label: "More"
                    ),

                ],
            ),
            body: widgetList[_currIndex],
            floatingActionButton: (_currIndex == 0) ? FloatingActionButton(
                onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddTransaction()
                    ));
                },
                child: const Icon(Icons.add), 
            ) : null,
        );
    }
}
