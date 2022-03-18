import 'package:flutter/material.dart';

class AppTheme {

  static const Color primaryColor = Colors.amber;

  static ThemeData themeDark = ThemeData.dark().copyWith(

    primaryColor: primaryColor,

    appBarTheme: const AppBarTheme(
      color: primaryColor
    )

  );

  

}