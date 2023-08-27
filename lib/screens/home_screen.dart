import 'package:flutter/material.dart';
import 'package:flutter_attendance_app/screens/attendance_history_screen.dart';
import 'package:flutter_attendance_app/screens/attendnace_sharing_screen.dart';
import 'package:flutter_attendance_app/screens/check_in_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const CheckInCheckOutScreen(),
    const AttendanceHistoryScreen(),
    const AttendanceSharingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time), label: 'Check-In/Out'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'Attendance History'),
          BottomNavigationBarItem(
              icon: Icon(Icons.share), label: 'Attendance Sharing'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
