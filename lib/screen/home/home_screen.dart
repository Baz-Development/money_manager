import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/screen/dashboard/dashboard_screen.dart';
import 'package:money_manager/screen/goals/goal_screen.dart';
import 'package:money_manager/screen/more/more_screen.dart';
import 'package:money_manager/screen/subscriptions/subscription_screen.dart';
import 'package:money_manager/screen/transactions/transactions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [
    const GoalScreen(),
    const TransactionsScreen(),
    const DashboardScreen(),
    const SubscriptionScreen(),
    const MoreScreen()
  ];

  var _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 20, 29, 1),
      body: Center(
        child: _screens[_selectedIndex]
      ),
      bottomNavigationBar: FlashyTabBar(
        animationCurve: Curves.linear,
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;

        }),
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.flag_outlined),
            title: const Text('Metas'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.list_rounded),
            title: const Text('Transações'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.analytics_outlined),
            title: const Text('Dashboard'),
          ),
          FlashyTabBarItem(
            icon: const ImageIcon(
              AssetImage("icons/monthlyIcon.png"),
            ),
            title: const Text('Assinaturas'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.more_horiz),
            title: const Text('Mais'),
          ),
        ],
      ),
    );
  }
}