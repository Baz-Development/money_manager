import 'package:flutter/material.dart';

class TabBarModel {
  final IconData icon;
  final String name;

  TabBarModel({
    required this.icon,
    required this.name,
  });
}

List<TabBarModel> navBtn = [
  TabBarModel(icon: Icons.event, name: 'event'),
  TabBarModel(icon: Icons.search, name: 'search'),
  TabBarModel(icon: Icons.highlight, name: 'highlight'),
  TabBarModel(icon: Icons.settings, name: 'settings')
];
