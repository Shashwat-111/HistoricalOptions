import 'package:flutter/material.dart';

Color defaultDarkModeTextAndIconColor = const Color.fromRGBO(209, 212, 220, 1);
Color defaultLightModeTextAndIconColor = Colors.black;

ThemeData darkTheme = ThemeData(
  primaryColor: const Color.fromRGBO(19, 23, 34, 1),
  brightness: Brightness.dark,
  canvasColor: const Color.fromRGBO(23, 27, 38, 1), // used for the chart area background
  scaffoldBackgroundColor: const Color.fromRGBO(42, 46, 57, 1),
  highlightColor: Colors.white10,
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(defaultDarkModeTextAndIconColor),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(fontSize: 12, color: defaultDarkModeTextAndIconColor),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStateProperty.all(defaultDarkModeTextAndIconColor),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.transparent),
        ),
      ),
    ),
  ),
  textTheme: TextTheme(
    displayMedium: TextStyle(color: defaultDarkModeTextAndIconColor, fontSize: 16), // used for the text icon button
  ),
);



ThemeData lightTheme = ThemeData(
  primaryColor: Colors.white,
  brightness: Brightness.light,
  canvasColor: Colors.white,
  scaffoldBackgroundColor: Colors.grey[700],
  highlightColor: Colors.grey[200],
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(defaultLightModeTextAndIconColor),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(fontSize: 12, color: defaultLightModeTextAndIconColor),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStateProperty.all(defaultLightModeTextAndIconColor),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.transparent),
        ),
      ),
    ),
  ),
  textTheme: TextTheme(
    displayMedium: TextStyle(color: defaultLightModeTextAndIconColor, fontSize: 16), // used for the text icon button
  ),
);
