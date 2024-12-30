import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_clone/models/accounts.dart';
import 'package:money_manager_clone/services/database_services.dart';
import 'package:money_manager_clone/ui/home_page.dart';
import 'package:money_manager_clone/ui/theme.dart';
import 'package:money_manager_clone/widgets/amount_input.dart';

class AddAccount extends StatefulWidget{
    const AddAccount({super.key});
    
    @override
    State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount>{

    // Database Services
    final DatabaseServices _dbServices = DatabaseServices.dbInstance;
    
    
    int curgrp = 0;
    String amt = "";
    String accountName = "";
    String description = "";
    bool isAmtInp = false;

    @override
    void initState(){
        curgrp = 0;
        amt = "₹ 0.00";
        
        super.initState();
    }
    
    void refreshAmt(String amount){
        setState(() {
            amt = amount;
        });
    }
    
    void refreshAmtInp(bool amountInput){
        setState(() {
            isAmtInp = amountInput;
        });
    }

    @override
    build(BuildContext context){
        final Size size = MediaQuery.of(context).size;
        return Scaffold(
            body: SafeArea( 
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Column(
                            children: [
                            
                            // Header Area
                                Container(
                                    height: 40,
                                    color: Theme.of(context).primaryColor,
                                    child: Row(
                                        children: [
                                            IconButton(
                                                icon: const FaIcon(
                                                    FontAwesomeIcons.arrowLeft,
                                                    size: 12,
                                                    color: Themes.primaryTextColor,
                                                ),
                                                onPressed: (){
                                                    Navigator.pop(context);
                                                },
                                            ),
                                            const Text("Add Account",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Themes.primaryTextColor
                                                ),
                                            )
                                        ],
                                    ),
                                ),
                                
                                // First Input field i.e. Account Group
                                Container(
                                    margin: const EdgeInsets.only(top:20, right: 20),
                                    child: Row(
                                        children: [
                                            Flexible(
                                                fit: FlexFit.tight,
                                                flex: 2,
                                                child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: const Text("Group")
                                                )
                                            ),

                                            Flexible(
                                                fit: FlexFit.tight,
                                                flex: 7,
                                                child: Container(
                                                    decoration: const BoxDecoration(
                                                        border: Border(
                                                            bottom: BorderSide(
                                                                color: Themes.secondaryTextColor
                                                            )
                                                        )
                                                    ),
                                                    
                                                    child: FutureBuilder(
                                                        future: _dbServices.getAccountGrp(),
                                                        builder: (context, snapshot){
                                                            return GestureDetector(
                                                                onTap: (){
                                                                    showDialog(
                                                                        context: context,
                                                                        builder: (context) {
                                                                            return Dialog(
                                                                                alignment: Alignment.center,
                                                                                child: Container(
                                                                                    color: Themes.primaryTextColor,
                                                                                    height: size.height*0.6,
                                                                                    width: size.width, 
                                                                                    child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                            Container(
                                                                                                margin: const EdgeInsets.only(bottom: 10),
                                                                                                padding: const EdgeInsets.only(top: 10, left: 10),
                                                                                                child: const Text(
                                                                                                    "Account Group",
                                                                                                    style: TextStyle(
                                                                                                        fontSize: 13,
                                                                                                        fontWeight: FontWeight.bold
                                                                                                    ),
                                                                                                ),
                                                                                            ),

                                                                                            Expanded(
                                                                                                child: ListView.builder(
                                                                                                    itemCount: snapshot.data!.length,
                                                                                                    itemBuilder: (context, index){
                                                                                                        return Container(
                                                                                                            width: size.width,
                                                                                                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                                                                            decoration: const BoxDecoration(
                                                                                                                border: Border(
                                                                                                                    top: BorderSide(
                                                                                                                        color: Themes.secondaryTextColor,
                                                                                                                        width: 0.4
                                                                                                                    )
                                                                                                                )
                                                                                                            ),
                                                                                                            child: GestureDetector(
                                                                                                                onTap: () => setState(() {
                                                                                                                    curgrp = index;
                                                                                                                    Navigator.pop(context);
                                                                                                                }),

                                                                                                                child: Text(
                                                                                                                    snapshot.data![index].name
                                                                                                                ),
                                                                                                            ),
                                                                                                        );
                                                                                                    } 
                                                                                                )
                                                                                            )
                                                                                        ]
                                                                                    )
                                                                                ),
                                                                            );
                                                                        },
                                                                    );
                                                                },
                                                                child: (snapshot.data == null) ? const Text("") : Text(snapshot.data![curgrp].name),
                                                            );
                                                        }
                                                    )
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                                
                                // Second Input Field i.e., Account Name 
                                Container(
                                    margin: const EdgeInsets.only(top:20, right: 20),
                                    child: Row(
                                        children: [
                                            Flexible(
                                                fit: FlexFit.tight,
                                                flex: 2,
                                                child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: const Text("Name")
                                                )
                                            ),

                                            Flexible(
                                                fit: FlexFit.tight,
                                                flex: 7,
                                                child: TextField(
                                                    decoration: const InputDecoration(
                                                        isCollapsed: true,
                                                        contentPadding: EdgeInsets.all(5)
                                                    ),
                                                    textAlignVertical: TextAlignVertical.center,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        height: 1.0
                                                    ),
                                                    onSubmitted: (value){
                                                        accountName = value;
                                                    }
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                                
                                // Third Input Value i.e., Amount
                                Container(
                                    margin: const EdgeInsets.only(top:20, right: 20),
                                    child: Row(
                                        children: [
                                            Flexible(
                                                fit: FlexFit.tight,
                                                flex: 2,
                                                child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: const Text("Amount")
                                                )
                                            ),

                                            Flexible(
                                                fit: FlexFit.tight,
                                                flex: 7,
                                                child: Container(
                                                    decoration: const BoxDecoration(
                                                        border: Border(
                                                            bottom: BorderSide(
                                                                color: Themes.secondaryTextColor
                                                            )
                                                        )
                                                    ),
                                                    child: GestureDetector(
                                                        child: Text(
                                                            amt
                                                        ),
                                                        onTap: (){
                                                            setState(() {
                                                                isAmtInp = true;
                                                            });
                                                        },
                                                    ),
                                                )    
                                            ),
                                        ],
                                    ),
                                ),

                                // Fourth Input i.e., Description
                                Container(
                                    margin: const EdgeInsets.only(top:20, right: 20),
                                    child: Row(
                                        children: [
                                            Flexible(
                                                fit: FlexFit.tight,
                                                flex: 3,
                                                child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: const Text(
                                                        "Description",
                                                        style: TextStyle(
                                                            fontSize: 9,
                                                        ),
                                                    )
                                                )
                                            ),

                                            Flexible(
                                                fit: FlexFit.tight,
                                                flex: 9,
                                                child: TextField(
                                                    decoration: const InputDecoration(
                                                        isCollapsed: true,
                                                        contentPadding: EdgeInsets.all(5),
                                                        border: UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                width: 0.3,
                                                                color: Themes.secondaryTextColor
                                                            )
                                                        )
                                                    ),
                                                    textAlignVertical: TextAlignVertical.center,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        height: 1.0
                                                    ),
                                                    onSubmitted: (value){
                                                        description = value;
                                                    }
                                                ),
                                            ),
                                            
                                        ],
                                    ),
                                ),

                                Container(
                                    margin: const EdgeInsets.only(top: 30),
                                    width: size.width * 0.9,
                                    child: ElevatedButton(
                                        child: const Text("Save"),
                                        onPressed: (){
                                            var acc = Account(
                                                0, 
                                                accountName, 
                                                curgrp+1, 
                                                double.parse(amt.substring(2)), 
                                                description
                                            );
                                            _dbServices.addAccount(acc);
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => const HomePage(initialIndex: 2,)
                                            ));
                                        }
                                    ),
                                ),
                            ]
                        ),
                        
                        SizedBox(
                            child: (isAmtInp) ?  AmountInput(updateParentAmt: refreshAmt, updateParentAmtInp: refreshAmtInp, amt: amt,): null,
                        ),

                    ],
                )
            )
        );
    }
}
