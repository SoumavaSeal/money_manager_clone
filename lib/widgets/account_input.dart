import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_clone/ui/theme.dart';

class AccountInput extends StatelessWidget{
    const AccountInput({super.key});

    @override
    Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return Column(
            children: [
                // Input Box border
                Container(
                    color: Colors.black,
                    height: 30,
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            const Text("Account", style: TextStyle(color: Colors.white),),
                            IconButton(
                                icon: const FaIcon(
                                    FontAwesomeIcons.xmark,
                                    size: 12,
                                    color: Themes.secondaryTextColor,
                                ),
                                onPressed: (){
                                },
                            )
                        ],
                    ),
                ),

                Row(
                    children: [
                        SizedBox(
                            height: size.height * 0.3,
                            width: size.width * 0.5,
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index){
                                    return ListTile(
                                        title: Text(index.toString()),
                                        trailing: Text(">"),
                                    );
                                },
                            ),
                        ),

                        SizedBox(
                            height: size.height * 0.3,
                            width: size.width * 0.5,
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index){
                                    return ListTile(
                                        title: Text(index.toString()),
                                    );
                                },
                            ),
                        )
                    ],
                )
            ],
        );
    }
}
