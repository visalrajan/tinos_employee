import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tinos_employee/screens/leave_page/leave_page.dart';
import 'package:tinos_employee/screens/punch_page/punch_page.dart';
import 'package:tinos_employee/screens/task/task.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int currentIndex = 0;
  final _pages = [const PunchPage(), const LeavePage(), const TaskPage()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[currentIndex],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: currentIndex,
          duration: const Duration(milliseconds: 500),
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.fingerprint_rounded,
              ),
              title: const Text('Punch'),
              selectedColor: Colors.black,
              unselectedColor: Colors.grey,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.local_hospital_rounded),
              title: const Text('Leave'),
              selectedColor: Colors.black,
              unselectedColor: Colors.grey,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.task_alt_rounded),
              title: const Text('Task'),
              selectedColor: Colors.black,
              unselectedColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
