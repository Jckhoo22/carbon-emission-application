import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workshop/Pages/transportation_screen.dart';

import '../Constant/theme.dart';
import '../Providers/bottom_nav_bar_provider.dart';
import 'electricity_screen.dart';
import 'home_screen.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const TransportationScreen(),
    const ElectricityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: ref.watch(bottomNavBarIndexProvider),
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(5),
              child: Icon(Icons.home),
            ),
            label: 'Home',
            backgroundColor: secondaryGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.car_detailed),
            label: 'Transportation',
            backgroundColor: primaryBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: 'Electricity',
            backgroundColor: primaryYellow,
          ),
        ],
        currentIndex: ref.watch(bottomNavBarIndexProvider),
        onTap: (index) {
          setState(() {
            // modify into provider state
            ref.read(bottomNavBarIndexProvider.notifier).updateIndex(index);
          });
        },
        selectedLabelStyle: label(bold: true),
      ),
    );
  }
}
