import 'package:flutter/material.dart';
import 'package:pastorplanner/pages/dashboard_page.dart';
import 'package:pastorplanner/pages/login_page.dart';
import 'package:pastorplanner/pages/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const PastorPlannerApp());
}

class PastorPlannerApp extends StatelessWidget {
  const PastorPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pastor Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}