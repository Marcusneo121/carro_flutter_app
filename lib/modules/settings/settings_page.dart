import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Settings',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Dark Mode",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Switch(
                value: context.read<ThemeProvider>().getTheme == ThemeMode.dark
                    ? true
                    : false,
                onChanged: (bool value) {
                  context.read<ThemeProvider>().toggleTheme();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
