import 'package:flutter/material.dart';
import 'package:net_split/src/calculadora/calculadora_screen.dart';
import 'package:net_split/src/shared/controllers/theme_controller.dart';
import 'package:net_split/src/widgets/UI/custom_scaffold.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final controller = ThemeController();
        controller.start();
        return controller;
      },
      child: Consumer<ThemeController>(
        builder: (context, themeController, child) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                themeController.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
            home: CustomScaffold(body: CalculadoraScreen(), hint: 's'),
          );
        },
      ),
    );
  }
}
