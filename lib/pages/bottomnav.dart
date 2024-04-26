import 'package:caffeinate/pages/cart.dart';
import 'package:caffeinate/pages/favourite.dart';
import 'package:caffeinate/pages/home.dart';
import 'package:caffeinate/pages/noti.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  final List<Widget> _pages = [
    const Home(),
    const Favourite(),
    const Cart(key: Key('cart'),),
    const Noti(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(
            () {
              currentIndex = index;
            },
          );
        },
        selectedItemColor: Colors.brown, // Color for active item
        unselectedItemColor: Colors.grey, // Color for inactive items
        backgroundColor: Colors.white, // Background color for the bar
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Noti',
          ),
        ],
      ),
    );
  }
}
