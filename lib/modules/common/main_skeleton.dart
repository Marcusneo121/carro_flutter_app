import 'package:animations/animations.dart';
import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/core/widget/fade_indexed_stack.dart';
import 'package:carro_flutter_app/modules/bookings/ui/bookings_page.dart';
import 'package:carro_flutter_app/modules/home/ui/home_page.dart';
import 'package:carro_flutter_app/modules/host/ui/host_page.dart';
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
    // TestingTextSize(),
    BookingsPage(),
    HostPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: _pages.elementAt(_selectedIndex), //New
      // ),
      //Page Transition Switcher is great, but no state retain after tab change
      // body: PageTransitionSwitcher(
      //   transitionBuilder: ((child, primaryAnimation, secondaryAnimation) {
      //     // return FadeScaleTransition(
      //     //   animation: primaryAnimation,
      //     //   child: child,
      //     // );
      //     return FadeThroughTransition(
      //       animation: primaryAnimation,
      //       secondaryAnimation: secondaryAnimation,
      //       child: child,
      //     );
      //   }),
      //   child: _pages.elementAt(
      //     Provider.of<ThemeProvider>(context).getSelectedIndex,
      //   ),
      // ),
      // body: IndexedStack(
      //   index: Provider.of<ThemeProvider>(context).getSelectedIndex,
      //   children: _pages,
      // ),
      body: FadeIndexedStack(
        index: Provider.of<ThemeProvider>(context).getSelectedIndex,
        duration: const Duration(milliseconds: 200),
        children: _pages,
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
            icon: Icon(Icons.library_books_rounded),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental_rounded),
            label: 'Host',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.text_format),
          //   label: 'Text',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Me',
          ),
        ],
      ),
    );
  }
}
