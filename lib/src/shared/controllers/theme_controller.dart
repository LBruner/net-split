import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:net_split/src/colors.dart';
import 'package:net_split/src/shared/controllers/storage_controller.dart';

class ThemeController with ChangeNotifier {
  // Singleton pattern with private constructor
  static final ThemeController _instance = ThemeController._internal();
  factory ThemeController() => _instance;
  ThemeController._internal();

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  Future<void> start() async {
    final savedTheme = await StorageController.readData('isDarkTheme') ?? false;
    _isDarkTheme = savedTheme as bool;
    notifyListeners();
  }

  Future<void> changeTheme() async {
    _isDarkTheme = !_isDarkTheme;
    await StorageController.saveData('isDarkTheme', _isDarkTheme);
    notifyListeners();
  }
}

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: bgColor,
  inputDecorationTheme: const InputDecorationTheme(fillColor: secondaryColor),
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: bgColor),
  cardColor: secondaryColor,
  cardTheme: const CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
  ),
  canvasColor: bgColor,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: bgColor,
    surface: bgColor,
  ),
  appBarTheme: const AppBarTheme(backgroundColor: bgColor),
  textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.white),
);

final lightTheme = ThemeData(
  primaryColor: primaryColor,
  brightness: Brightness.light,
  scaffoldBackgroundColor: bgColorLight,
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: secondaryColorLight,
  ),
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: bgColorLight),
  cardColor: secondaryColorLight,
  cardTheme: const CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
  ),
  canvasColor: bgColorLight,
  appBarTheme: const AppBarTheme(backgroundColor: bgColorLight),
  textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.black),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.grey,
  ).copyWith(surface: bgColorLight),
);

OutlineInputBorder outlineInputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: Colors.white12),
  );
}

OutlineInputBorder outlineInputBorderFocused(BuildContext context) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: focusColor),
  );
}
