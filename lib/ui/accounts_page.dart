import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_clone/models/account_group.dart';
import 'package:money_manager_clone/models/accounts.dart';
import 'package:money_manager_clone/services/database_services.dart';
import 'package:money_manager_clone/ui/add_account.dart';
import 'package:money_manager_clone/ui/theme.dart';

class AccountsPage extends StatelessWidget{
    const AccountsPage({super.key});

    @override
    Widget build(BuildContext context) {
        
        // Database Services
        final DatabaseServices _dbServices = DatabaseServices.dbInstance;

        return SafeArea(
            child: FutureBuilder( 
                future: Future.wait([
                    _dbServices.getAccountGrp(),    // Get all Account Group Details
                    _dbServices.getAccount(),       // Get all Account Details
                ]),

                builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                    
                    double sumAsset = 0;            // Total Assets
                    double sumLiabilities = 0;      // Total Liabilities
                    
                    List<Account> accList = [];      // All Account Details
                    List<AccountGroup> accGrp = [];  // All AccountGroup Details
                    
                    if(snapshot.hasData){
                            
                        accList = snapshot.data![1];      // All Account Details
                        accGrp = snapshot.data![0];       // All AccountGroup Details

                        for(Account acc in accList){
                            if( acc.amount > 0 ){
                                sumAsset += acc.amount;
                            }else{
                                sumLiabilities += acc.amount;
                            }
                        }
                    }

                    return Column(
                        children: [
                            
                            // Header Area
                            Container(
                                color: Theme.of(context).primaryColor,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        const Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                                "Accounts",
                                                style: TextStyle(
                                                    color: Themes.primaryTextColor
                                                ),
                                            ),
                                        ),

                                        Row(
                                            children: [
                                                IconButton(
                                                    icon: const FaIcon(
                                                        FontAwesomeIcons.chartLine,
                                                        size: 18,
                                                        color: Themes.primaryTextColor,
                                                    ),
                                                    onPressed: (){},
                                                ),

                                                PopupMenuButton(
                                                    iconColor: Themes.primaryTextColor,
                                                    itemBuilder: (context) => const [
                                                        PopupMenuItem(
                                                            value: 1,
                                                            child: Text("Add"),
                                                        ),

                                                        PopupMenuItem(
                                                            value: 2,
                                                            child: Text("Delete"),
                                                        ),

                                                        PopupMenuItem(
                                                            value: 3,
                                                            child: Text("Show/Hide"),
                                                        )
                                                    ],
                                                    onSelected: (value){
                                                        if(value == 1){
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => const AddAccount()
                                                                )
                                                            );
                                                        }
                                                    },
                                                )
                                            ],
                                        ),
                                    ],
                                )
                            ),

                            // Dashboard area
                            Container(
                                color: Colors.white,
                                padding: const EdgeInsets.only(left: 10, right:10, top: 10, bottom: 5),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        Column(
                                            children: [
                                                const Text(
                                                    "Assets",
                                                    style: Themes.amtType,
                                                ),
                                                Text(
                                                    sumAsset.toString(),
                                                    style: Themes.amtIncome,
                                                )
                                            ],
                                        ),

                                        Column(
                                            children: [
                                                const Text(
                                                    "Liabilities",
                                                    style: Themes.amtType,

                                                ),
                                                Text(
                                                    sumLiabilities.toString(),
                                                    style: Themes.amtExpense,
                                                )
                                            ],
                                        ),

                                        Column(
                                            children: [
                                                const Text(
                                                    "Total",
                                                    style: Themes.amtType,
                                                ),
                                                Text(
                                                    ( sumAsset - sumLiabilities ).toString(),
                                                    style: Themes.amtType,
                                                ),
                                            ],
                                        )
                                    ],
                                )
                            ),
                            
                            // Accounts
                            Expanded(
                                child: ListView.builder(
                                    itemCount: (snapshot.hasData) ? snapshot.data![0].length : 0,
                                    itemBuilder: (context, index){
                                        
                                        double sumAcctGrp = 0;
                                        List<Account> keys = accList.where( (key) => key.accountGroup == accGrp[index].id ).toList();
                                        
                                        for(Account acc in keys){
                                            sumAcctGrp += acc.amount;
                                        }

                                        if (keys.isNotEmpty){
                                            return Column(
                                                children: [
                                                    Padding(
                                                        padding: const EdgeInsets.only(left:10, right: 10, top: 15),
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                                Text(
                                                                    accGrp[index].name, 
                                                                    style: const TextStyle(fontSize: 12)
                                                                ),
                                                                Text( 
                                                                    sumAcctGrp.toString(), 
                                                                    style: (sumAcctGrp > 0) ? Themes.amtIncome : Themes.amtExpense
                                                                ),
                                                            ]
                                                        ),
                                                    ),

                                                    for(var i=0; i<keys.length; i++) Container(
                                                        decoration: const BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border(
                                                                bottom: BorderSide(width: 0.1)
                                                            )
                                                        ),
                                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                                Text(keys[i].name),
                                                                Text(keys[i].amount.toString()),
                                                            ],
                                                        ),
                                                    )

                                                ]
                                            ); 
                                        }else{
                                            return null;
                                        }
                                    },
                                ),
                            )
                            
                        ],
                    );
                }
            ),
        );
    }
}
