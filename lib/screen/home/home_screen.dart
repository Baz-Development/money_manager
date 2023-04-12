import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager/screen/dashboard/dashboard_screen.dart';
import 'package:money_manager/screen/goals/goal_screen.dart';
import 'package:money_manager/screen/more/more_screen.dart';
import 'package:money_manager/screen/subscriptions/subscription_screen.dart';
import 'package:money_manager/screen/transactions/transactions_screen.dart';
import 'package:money_manager/widgets/appbar_widget.dart';

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
      appBar: buildAppBar(context, false, true),
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
            title: const Text(
              'Metas',
              style: TextStyle(
                  fontSize: 13
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: const Icon(FontAwesomeIcons.exchangeAlt),
            title: const Text(
              'Transações',
              style: TextStyle(
                fontSize: 13
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.analytics_outlined),
            title: const Text(
              'Dashboard',
              style: TextStyle(
                  fontSize: 13
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.edit_note_sharp),
            title: const Text(
              'Assinaturas',
              style: TextStyle(
                  fontSize: 13
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.more_horiz),
            title: const Text(
              'Mais',
              style: TextStyle(
                  fontSize: 13
              ),
            ),
          ),
        ],
      ),
    );
  }
}