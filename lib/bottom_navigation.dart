import 'package:flutter/material.dart';
import 'consts.dart';
import 'first_screen.dart';
import 'home_screen.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class MyHomeState extends StatefulWidget {
  const MyHomeState({super.key});

  @override
  State<MyHomeState> createState() => _MyHomeStateState();
}

class _MyHomeStateState extends State<MyHomeState> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    const HomeScreen(),
    const FirstScreen(),
    const SignInScreen(),
    const SignUpScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primeColor,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fmd_good),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
