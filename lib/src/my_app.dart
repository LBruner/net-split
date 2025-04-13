import 'package:flutter/material.dart';
import 'package:net_split/src/calculadora/calculadora_screen.dart';
import 'package:net_split/src/shared/controllers/providers/provider.dart';
import 'package:net_split/src/shared/controllers/theme_controller.dart';
import 'package:net_split/src/widgets/UI/custom_scaffold.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()..start()),
        ChangeNotifierProvider(create: (_) => CalculatorState()),
      ],
      child: Consumer<ThemeController>(
        builder: (context, themeController, child) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                themeController.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
            home: CustomScaffold(
              body: CalculadoraScreen(),
              title: 'Subnet Calculator',
            ),
          );
        },
      ),
    );
  }
}
