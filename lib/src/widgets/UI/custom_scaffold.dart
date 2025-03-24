import 'package:flutter/material.dart';
import 'package:net_split/src/constants.dart';
import 'package:net_split/src/widgets/UI/custom_text.dart';
import 'package:net_split/src/widgets/UI/theme_selector_button.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.hint,
    required this.body,
    this.fab,
    this.labels,
    this.iconPress,
    this.showBackButton = false,
    this.press,
    this.controller,
  });

  final Widget body;
  final Widget? fab;
  final String hint;
  final Function()? iconPress;
  final Function()? press;
  final Widget? labels;
  final bool showBackButton;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: CustomText('NetSlip'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ThemeSelectorButton(),
          ),
        ],
      ),
      drawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: SingleChildScrollView(child: body),
      ),
      floatingActionButton: fab,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
