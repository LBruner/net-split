import 'package:flutter/material.dart';
import 'package:net_split/src/shared/controllers/theme_controller.dart';
import 'package:provider/provider.dart';

class ThemeSelectorButton extends StatelessWidget {
  const ThemeSelectorButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );

    return InkWell(
      child: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
      onTap: () => themeController.changeTheme(),
    );
  }
}
