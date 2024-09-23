import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_app/features/favourite/presentation/screens/favourite_screen.dart';

import 'package:meal_app/features/home/presentation/screens/home_screen.dart';
import 'package:meal_app/features/my_recipes/presentation/screens/recipe_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;


  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(),
       // Initialize with the correct constructor
      RecipeScreen(),
       FavoritesScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          Icon(Icons.home_outlined, size: 35.sp, color: Color(0xFF832EE5)),
          Icon(Icons.receipt, size: 30.sp, color: Color(0xFF832EE5)),
          Icon(Icons.favorite, size: 30.sp, color: Color(0xFF832EE5)),
        ],
        index: _selectedIndex,
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Color(0xFF832EE5),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: _onItemTapped,
        height: 55.h,
      ),
    );
  }
}
