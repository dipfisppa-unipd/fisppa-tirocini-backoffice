import 'package:flutter/material.dart';
import 'app_colors.dart';


ThemeData themeData(){

  return ThemeData(
    fontFamily: 'Lato',
    indicatorColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    splashColor:AppColors.primary.withOpacity(0.3),
    appBarTheme: AppBarTheme(
      toolbarTextStyle: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Lato'),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Lato'),
      color: AppColors.primary,
      centerTitle: false,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 24,
      ),
    ),
    unselectedWidgetColor: AppColors.iconDefault,  
    toggleableActiveColor: AppColors.primary,
    // radioTheme: RadioThemeData(
    //   fillColor: MaterialStateProperty.resolveWith((states) => states.any(<MaterialState>{MaterialState.disabled}.contains) ? AppColors.iconDefault : AppColors.primary )

    // ),
    // primarySwatch: MaterialColor(0xFF36BFD8, {
    // 50:Color.fromRGBO(54,191,216, .1),
    // 100:Color.fromRGBO(54,191,216, .2),
    // 200:Color.fromRGBO(54,191,216, .3),
    // 300:Color.fromRGBO(54,191,216, .4),
    // 400:Color.fromRGBO(54,191,216, .5),
    // 500:Color.fromRGBO(54,191,216, .6),
    // 600:Color.fromRGBO(54,191,216, .7),
    // 700:Color.fromRGBO(54,191,216, .8),
    // 800:Color.fromRGBO(54,191,216, .9),
    // 900:Color.fromRGBO(54,191,216, 1),
    // }),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    backgroundColor: AppColors.background,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary, 
      onPrimary: AppColors.secondary,
      primaryContainer: AppColors.secondary,
      onPrimaryContainer: AppColors.black,
      secondary: AppColors.secondary, 
      onSecondary: AppColors.black,
      secondaryContainer: AppColors.secondary,
      onSecondaryContainer: AppColors.black,
      background: AppColors.secondary,
      onBackground: AppColors.black,
      surface: AppColors.secondary,
      onSurface: AppColors.black, 
      error: AppColors.secondary,
      onError: AppColors.black,
      onInverseSurface: AppColors.black,
      onSurfaceVariant: AppColors.black,
      onTertiaryContainer: AppColors.black,
      onTertiary: AppColors.black,
      
    ),    
    // buttonColor: AppColors.action,
    // accentTextTheme: TextTheme(
    //   headline1: TextStyle(fontSize: 28, color: AppColors.accent, fontWeight: FontWeight.w700),
    //   headline2: TextStyle(fontSize: 24, color: AppColors.accent, fontWeight: FontWeight.w700),
    //   headline3: TextStyle(fontSize: 20, color: AppColors.accent, fontWeight: FontWeight.w500),
    //   headline4: TextStyle(fontSize: 18, color: AppColors.accent, fontWeight: FontWeight.w700),
    //   headline5: TextStyle(fontSize: 16, color: AppColors.accent, fontWeight: FontWeight.w700),
    //   headline6: TextStyle(fontSize: 14, color: AppColors.accent,),
    //   subtitle1: TextStyle(fontSize: 16, color: AppColors.accent, fontWeight: FontWeight.w700),
    //   subtitle2: TextStyle(fontSize: 14, color: AppColors.accent, fontWeight: FontWeight.w700),
    //   bodyText1: TextStyle(fontSize: 16, color: AppColors.accent,),
    //   bodyText2: TextStyle(fontSize: 14, color: AppColors.accent,),
    //   button: TextStyle(fontSize: 20, color: AppColors.accent,),
    // ),
    // primaryTextTheme: TextTheme( 
    //   headline1: TextStyle(fontSize: 28, color: AppColors.primaryTextColor, fontWeight: FontWeight.w700, fontFamily: 'Lato'),
    //   headline2: TextStyle(fontSize: 24, color: AppColors.primaryTextColor, fontWeight: FontWeight.w700, fontFamily: 'Lato'),
    //   headline3: TextStyle(fontSize: 20, color: AppColors.primaryTextColor, fontWeight: FontWeight.w700, fontFamily: 'Lato'),
    //   headline4: TextStyle(fontSize: 18, color: AppColors.primaryTextColor, fontWeight: FontWeight.w700, fontFamily: 'Lato'),
    //   headline5: TextStyle(fontSize: 16, color: AppColors.primaryTextColor, fontWeight: FontWeight.w700, fontFamily: 'Lato'),
    //   headline6: TextStyle(fontSize: 14, color: AppColors.primaryTextColor, fontFamily: 'Lato'),
    //   subtitle1: TextStyle(fontSize: 18, color: AppColors.primaryTextColor, fontFamily: 'Lato'),
    //   subtitle2: TextStyle(fontSize: 16, color: AppColors.primaryTextColor, fontFamily: 'Lato'),
    //   bodyText1: TextStyle(fontSize: 16, color: AppColors.primaryTextColor, fontFamily: 'Lato'),
    //   bodyText2: TextStyle(fontSize: 14, color: AppColors.primaryTextColor, fontFamily: 'Lato'),
    //   button: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700, fontFamily: 'Lato'),
    // ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: AppColors.text, fontFamily: 'Lato'),
      bodyText2: TextStyle(color: AppColors.text, fontFamily: 'Lato'),
      caption: TextStyle(color: AppColors.text, fontFamily: 'Lato'),
      subtitle1: TextStyle(color: AppColors.onSurface, fontFamily: 'Lato'),
    ),
    iconTheme: IconThemeData(
      color: AppColors.primary,
    ),
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.only(right: 10),
      horizontalTitleGap: 0,
      selectedTileColor: AppColors.secondary,
      minVerticalPadding: 0,
      selectedColor: AppColors.primary
    ),
    inputDecorationTheme: InputDecorationTheme(
      // focusColor: AppColors.accent,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightText, width: 1),
        borderRadius: BorderRadius.circular(8)
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightText, width: 1),
        borderRadius: BorderRadius.circular(8)
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.lightText, width: 1),
        borderRadius: BorderRadius.circular(4)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.lightText, width: 1),
        borderRadius: BorderRadius.circular(4)
      ),
      /* labelStyle: TextStyle(
        color: AppColors.accentTextColor,
        fontSize: 16,
        height: 1,
        fontWeight: FontWeight.normal,
      ), */
      
    //   contentPadding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 16),
    ),
    // textButtonTheme: TextButtonThemeData(
    //   style: TextButton.styleFrom(
    //     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
    //     side: BorderSide(color: AppColors.borderDisabledColor),
    //   )
    // ),
    // outlinedButtonTheme: OutlinedButtonThemeData(
    //   style: OutlinedButton.styleFrom(
    //     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
    //     side: BorderSide(color: AppColors.borderDisabledColor),
    //   )
    // ),
    // timePickerTheme: TimePickerThemeData(
    //   backgroundColor: AppColors.accentBlue,
    // ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        side: BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        )
      )
    ),
    
  );
}