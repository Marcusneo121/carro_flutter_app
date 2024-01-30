import 'package:animations/animations.dart';
import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/modules/home/ui/home_page.dart';
import 'package:carro_flutter_app/modules/settings/ui/settings_page.dart';
import 'package:carro_flutter_app/modules/testing_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MainSkeleton extends StatefulWidget {
  const MainSkeleton({
    super.key,
  });

  @override
  State<MainSkeleton> createState() => _MainSkeletonState();
}

class _MainSkeletonState extends State<MainSkeleton> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      // _selectedIndex = index;
      context.read<ThemeProvider>().setSelectedIndex(index);
    });
  }

  static const List<Widget> _pages = <Widget>[
    Homepage(),
    TestingTextSize(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: _pages.elementAt(_selectedIndex), //New
      // ),
      body: PageTransitionSwitcher(
        transitionBuilder: ((child, primaryAnimation, secondaryAnimation) {
          // return FadeScaleTransition(
          //   animation: primaryAnimation,
          //   child: child,
          // );
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        }),
        child: _pages.elementAt(
          Provider.of<ThemeProvider>(context).getSelectedIndex,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // currentIndex: _selectedIndex,
        currentIndex: context.read<ThemeProvider>().getSelectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
        // backgroundColor: const Color(0xFF0C0120),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_format),
            label: 'Text',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Me',
          ),
        ],
      ),
    );
  }
}
