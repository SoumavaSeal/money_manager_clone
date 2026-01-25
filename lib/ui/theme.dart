import 'package:flutter/material.dart';

class Themes {
    
    //static const Color primaryColor = Color(0xFFf04035);
    static const Color primaryColor = Color(0xFFf54242);
    static const Color primaryTextColor = Color(0xFFFFFFFF);
    static const Color secondaryTextColor = Color(0xFFb8b4b4);
    static const Color satColor = Color(0xff5c5af2);
    static const Color sunColor = Color(0xfff06565);
    static const Color primaryBG = Color(0xffebeded);

    ThemeData lightTheme = ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: primaryBG,
        secondaryHeaderColor: primaryTextColor,
        primarySwatch: Colors.red,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: primaryColor
        ),
        tabBarTheme: const TabBarThemeData(
            indicatorColor: primaryTextColor,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelStyle: TextStyle(
                fontSize: 12,
                color:  Color(0xFFf7f7f7)
            ),
            labelStyle: TextStyle(
                fontSize: 12,
                color: primaryTextColor 
            )
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedLabelStyle: TextStyle(
                fontSize: 10,
            ),

            unselectedLabelStyle: TextStyle(
                fontSize: 10,
            ),
            
            backgroundColor: primaryBG,

            selectedItemColor: primaryColor,
            unselectedItemColor: secondaryTextColor,
            
        ),
        
        textTheme: const TextTheme(
            bodyMedium: TextStyle(fontSize: 12)
        ),

        popupMenuTheme: const PopupMenuThemeData(
            color: primaryTextColor, 
            position: PopupMenuPosition.under
        ),

        appBarTheme: const AppBarTheme(
           //toolbarHeight: 30,
           backgroundColor: Colors.red,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(primaryColor),
                foregroundColor: WidgetStateProperty.all(primaryTextColor),
            )
        ),

        //GoogleFonts package is throwing some errors.
        //textTheme: GoogleFonts.robotoTextTheme()
    );
    
    static const TextStyle amtType = TextStyle(
        fontSize: 12,
    );

    static const TextStyle amtIncome = TextStyle(
        fontSize: 12,
        color: Color(0xFF6c62e3)
    );
    
    static const TextStyle amtExpense = TextStyle(
        fontSize: 12,
        color: Color(0xFFf54242)
    );

}
