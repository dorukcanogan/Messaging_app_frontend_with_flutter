import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_project/utils/color.dart';

// This is our  main focus
// Let's apply light and dark theme on our app
// Now let's add dark theme on our app

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: AppColors.primaryAppColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme,
    iconTheme: IconThemeData(color: AppColors.contentColorLightTheme),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: AppColors.contentColorLightTheme),
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryAppColor,
      secondary: AppColors.secondaryAppColor,
      error: AppColors.errorColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.contentColorLightTheme.withOpacity(0.7),
      unselectedItemColor: AppColors.contentColorLightTheme.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: AppColors.primaryAppColor),
      showUnselectedLabels: true,
    ),
  );
}
/*
ThemeData darkThemeData(BuildContext context) {
  // Bydefault flutter provie us light and dark theme
  // we just modify it as our need
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kContentColorLightTheme,
    appBarTheme: appBarTheme,
    iconTheme: IconThemeData(color: kContentColorDarkTheme),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorDarkTheme),
    colorScheme: ColorScheme.dark().copyWith(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kContentColorLightTheme,
      selectedItemColor: Colors.white70,
      unselectedItemColor: kContentColorDarkTheme.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: kPrimaryColor),
      showUnselectedLabels: true,
    ),
  );
}
*/

final appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);