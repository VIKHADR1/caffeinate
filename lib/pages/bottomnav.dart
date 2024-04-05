import 'package:caffeinate/pages/cart.dart';
import 'package:caffeinate/pages/favourite.dart';
import 'package:caffeinate/pages/home.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(
            () {
              currentIndex = index;
              switch (index) {
                case 0:
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home()));
                  break;
                case 1:
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Favourite()));
                  break;
                case 2:
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                  break;
              }
            },
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'First Screen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Second Screen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Third Screen',
          ),
        ],
      ),
    );
  }
}
