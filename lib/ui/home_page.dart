import 'package:flutter/material.dart';
import 'package:money_manager_clone/ui/transactions_page.dart';

class HomePage extends StatefulWidget{
    const HomePage({super.key});
    
    @override
    State<HomePage> createState() => _HomePageState(); 
}

class _HomePageState extends State<HomePage>{
    int _currIndex = 0; // Current selected Page    

    List<Widget> widgetList = [
        TransactionsPage(date: DateTime.now()),
        const Center(child: Text("StatPage")),
        const Center(child: Text("AccountPage")),
        const Center(child: Text("MorePage")),
    ];


    @override
    Widget build(BuildContext context){
        return  Scaffold(
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
                        icon: Icon(Icons.book),
                        label: "Trans."
                    ),

                    BottomNavigationBarItem(
                        icon: Icon(Icons.auto_graph),
                        label: "Stats"
                    ),

                    BottomNavigationBarItem(
                        icon: Icon(Icons.dataset),
                        label: "Accounts"
                    ),

                    BottomNavigationBarItem(
                        icon: Icon(Icons.add),
                        label: "More"
                    ),

                ],
            ),
            body: widgetList[_currIndex],
            floatingActionButton: FloatingActionButton(
                onPressed: (){},
                child: const Icon(Icons.add), 
            ),
        );
    }
}
