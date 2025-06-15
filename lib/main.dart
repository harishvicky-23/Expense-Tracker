import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter/services.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkcolorscheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 0, 152, 194),
  brightness: Brightness.dark,
);

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
  //  fn,
  //) {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.surface,
        ),
        cardTheme: const CardThemeData().copyWith(
          color: kColorScheme.primaryFixedDim,
          elevation: 4,
          margin: EdgeInsets.only(top: 15, left: 10, right: 10),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryFixed,
            foregroundColor: kColorScheme.onSecondaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            fixedSize: Size(130, 40),
            elevation: 2,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: kColorScheme.onSecondaryContainer,
            alignment: Alignment.center,
            padding: EdgeInsets.all(1),
            elevation: 2,
            fixedSize: Size(130, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: GoogleFonts.montserrat(
            color: kColorScheme.onSecondaryContainer,
            fontStyle: FontStyle.italic,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
          //bodyMedium: TextStyle(color: Colors.purple),
          labelLarge: TextStyle(
            color: kColorScheme.onSecondaryContainer,
            fontSize: 19,
          ),
          labelMedium: TextStyle(
            color: kColorScheme.onSecondaryContainer,
            fontSize: 15,
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkcolorscheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kDarkcolorscheme.onPrimaryFixed,
          foregroundColor: kDarkcolorscheme.onSurface,
        ),
        cardTheme: CardThemeData().copyWith(
          color: kDarkcolorscheme.onPrimaryFixedVariant,
          elevation: 4,
          margin: EdgeInsets.only(top: 15, left: 10, right: 10),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkcolorscheme.primaryContainer,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            fixedSize: Size(130, 40),
            elevation: 2,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: kDarkcolorscheme.onPrimaryContainer,
            alignment: Alignment.center,
            padding: EdgeInsets.all(1),
            elevation: 2,
            fixedSize: Size(130, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: GoogleFonts.montserrat(
            color: kDarkcolorscheme.onSecondaryContainer,
            fontStyle: FontStyle.italic,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(color: Colors.white),
          labelLarge: TextStyle(color: Colors.white, fontSize: 17),
          labelMedium: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      //themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: Expenses(),
    ),
  );
  //});
}
