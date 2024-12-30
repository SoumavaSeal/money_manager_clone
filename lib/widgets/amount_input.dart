import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_clone/ui/theme.dart';

class AmountInput extends StatelessWidget{
    
    final dynamic updateParentAmt;
    final dynamic updateParentAmtInp;
    final String amt;

    const AmountInput({super.key, required this.updateParentAmt, required this.updateParentAmtInp, required this.amt});

    static const List<String> btns = ["1","2","3","D","4","5","6","-","7","8","9","AC","","0",".","Done"];
    
    

    @override
    Widget build(BuildContext context) {
        final Size size = MediaQuery.of(context).size;
        return Column(
            children: [
                Container(
                    color: Colors.black,
                    height: 30,
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            const Text("Amount", style: TextStyle(color: Colors.white),),
                            IconButton(
                                icon: const FaIcon(
                                    FontAwesomeIcons.xmark,
                                    size: 12,
                                    color: Themes.secondaryTextColor,
                                ),
                                onPressed: (){
                                    updateParentAmtInp(false);
                                },
                            )
                        ],
                    ),
                ),

                Wrap(
                    children: btns.map(
                        (value) => SizedBox(
                            width: size.width / 4,
                            child: InkWell(
                                onTap: (){
                                    String temp = amt;
                                    if(amt == "₹ 0.00" && value != "Done"){
                                        temp = "₹ ";
                                    }
                        
                                    if (value == "AC"){
                                        temp = "₹ 0.00";
                                    }else if(value == "Done"){
                                        updateParentAmtInp(false);
                                    }else{
                                        temp = temp + value;
                                    }
                        
                                    updateParentAmt(temp);
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.2
                                        )
                                    ),
                                    child: Center(
                                        child: Text(value),
                                    )
                                ),
                            )
                        )
                    ).toList()
                )
            ],
        );
    }
}
