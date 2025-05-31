// import 'package:flutter_test/flutter_test.dart';
// import 'package:expense_tracker_lite/models/expense_model.dart';
// import 'package:expense_tracker_lite/providers/expense_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:mocktail/mocktail.dart';
//
// class MockClient extends Mock implements http.Client {}
//
// void main() {
//   late ExpenseProvider provider;
//   late MockClient mockClient;
//
//   setUp(() {
//     mockClient = MockClient();
//     provider = ExpenseProvider();
//   });
//
//   group('Expense Validation', () {
//     test('Reject negative', () {
//       expect(
//             () => provider.addExpense(Expense(
//             id: '1',
//             category: 'Food',
//             amount: -50,
//             date: '2023-01-01',
//             usdAmount: -50
//         )),
//         throwsA(isA<ArgumentError>()),
//       );
//     });
//
//     test('reject empty', () {
//       expect(
//             () => provider.addExpense(Expense(
//             id: '1',
//             category: '',
//             amount: 50,
//             date: '2023-01-01',
//             usdAmount: 50
//         )),
//         throwsA(isA<ArgumentError>()),
//       );
//     });
//   });
//
//   group('Currency Conversion', () {
//     test('convert from usd to eur', () async {
//       // Mock API Response
//       when(() => mockClient.get(any())).thenAnswer((_) async =>
//           http.Response('{"rates":{"USD":1,"EUR":0.85}}', 200));
//
//       final service = CurrencyService(client: mockClient);
//       final result = await service.convertToUSD(amount: 85, fromCurrency: 'EUR');
//
//       expect(result, equals(100));
//     });
//
//     test('handel api error', () async {
//       when(() => mockClient.get(any())).thenAnswer((_) async =>
//           http.Response('Error', 500));
//
//       final service = CurrencyService(client: mockClient);
//       expect(() => service.convertToUSD(amount: 100, fromCurrency: 'EUR'),
//           throwsException);
//     });
//   });
//
//   group('Pagination', () {
//     test('show 10 item for every page', () {
//       for (var i = 0; i < 25; i++) {
//         provider.addExpense(Expense(
//             id: i,
//             category: 'Test',
//             amount: i.toDouble(),
//             date: '2023-01-01',
//             usdAmount: i.toDouble()
//         ));
//       }
//
//       final page1 = provider.loadExpenses(page: 0);
//       expect(page1.length, 10);
//       expect(page1.first.amount, equals(0));
//
//       final page2 = provider.getPaginatedExpenses(page: 1);
//       expect(page2.length, 10);
//       expect(page2.first.amount, equals(10));
//     });
//   });
// }