import 'package:expense_tracker_lite/providers/add_expense_provider.dart';
import 'package:expense_tracker_lite/screens/add_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Should show validation error if amount is empty', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AddExpenseProvider>(
          create: (_) => AddExpenseProvider()..selectedCategory = null,
          child: const AddExpenseScreen(),
        ),
      ),
    );

    final saveButton = find.text('Save');
    expect(saveButton, findsOneWidget);

    await tester.tap(saveButton);
    await tester.pumpAndSettle();
    expect(find.text('Enter amount'), findsOneWidget);
  });
}
