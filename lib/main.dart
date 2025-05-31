import 'package:expense_tracker_lite/providers/add_expense_provider.dart';
import 'package:expense_tracker_lite/providers/expense_provider.dart';
import 'package:expense_tracker_lite/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
        ChangeNotifierProvider(create: (_) => AddExpenseProvider()),
      ],
      child: MaterialApp(
        title: 'Expense Tracker Lite',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const LoginScreen(),
      ),
    );
  }
}
