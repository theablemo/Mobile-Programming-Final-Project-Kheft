import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:kheft/Screens/BooksList_Screen.dart';
import 'package:kheft/Screens/Profile_Screen.dart';
import 'package:kheft/Screens/PublishBook_Screen.dart';

class BottomNavScreen extends StatefulWidget {
  static const routeAddress = "/bottom_nav_page";

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  var _selectedIndex = 0;
  final tabPages = [
    BooksListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabPages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(PublishBookScreen.routeAddress);
        },
        backgroundColor: Color.fromRGBO(161, 232, 240, 1),
        splashColor: Theme.of(context).colorScheme.secondary,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [Icons.class_, Icons.person],
        activeIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        gapLocation: GapLocation.center,
        backgroundColor: Theme.of(context).cardColor,
        inactiveColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
