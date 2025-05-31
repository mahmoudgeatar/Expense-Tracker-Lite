import 'dart:io';
import 'package:expense_tracker_lite/constants/color_manger.dart';
import 'package:expense_tracker_lite/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import '../data/categories_data.dart';
import '../data/expense_database.dart';
import '../models/categories_model.dart';
import '../models/expense_model.dart';
import '../screens/dashboard_screen.dart';
import '../utils/navigation_helper.dart';

class AddExpenseProvider with ChangeNotifier {
  AddExpenseProvider() {
    selectedCategory = CategoryModel(
        color: ColorManager.primary,
        icon: FontAwesomeIcons.cartShopping,
        name: "Groceries");
  }
  CategoryModel? selectedCategory;
  List<Expense> expenses = [];
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  String? selectedDatetime;
  final imageController = TextEditingController();
  File? receiptImage;
  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> availableCurrencies = [];
  bool isLoadingCurrencies = true;
  String? currencyError = "";
  Map<String, dynamic>? selectedCurrency;
  String? convertedAmount;

  reset(){
    selectedCategory=CategoryModel(
        color: ColorManager.primary,
        icon: FontAwesomeIcons.cartShopping,
        name: "Groceries");
    amountController.clear();
    dateController.clear();
    selectedDatetime=null;
    imageController.clear();
    receiptImage=null;
    selectedCurrency=null;
    convertedAmount=null;
  }

  CategoryModel? getCategoryData(String title) {
    for (var item in CategoriesData.categoriesList) {
      if (item.name == title) {
        return item;
      }
    }
  }

  void changeSelectedCategory(CategoryModel? value) {
    selectedCategory = value;
    notifyListeners();
  }

  void changeSelectedCurrency(Map<String, dynamic>? value) {
    selectedCurrency = value;
    notifyListeners();
  }

  convertExpense() {
    if (selectedCurrency!["code"] == "USd") {
      convertedAmount = amountController.text;
    } else {
      convertedAmount =
          (double.parse(amountController.text) / selectedCurrency!["rate"])
              .toString();
    }
  }

  void changeSelectedDate(String? value) {
    dateController.text = Helper.getDate(value!);
    selectedDatetime=value;

    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    final newExpense = await ExpenseDatabase.instance.insertExpense(expense);
    expenses.insert(0, newExpense);
    notifyListeners();
  }

  Future<void> getImage() async {
    imageController.text = await Helper.getImage();
    notifyListeners();
  }

  Future<void> fetchCurrencies() async {
    const apiUrl = 'https://open.er-api.com/v6/latest/USD';
    isLoadingCurrencies = true;
    currencyError = null;
    notifyListeners();
    try {
      final response =
          await http.get(Uri.parse(apiUrl)).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rates = data['rates'] as Map<String, dynamic>;
        availableCurrencies = rates.entries.map((entry) {
          return {
            'code': entry.key,
            'rate': entry.value,
          };
        }).toList();
        if (!availableCurrencies.contains(selectedCurrency)) {
          selectedCurrency = availableCurrencies.firstWhere(
            (element) => element['code'] == 'USD',
            orElse: () => availableCurrencies.first,
          );
        }
      } else {
        currencyError =
            'Failed to load currencies (Code: ${response.statusCode})';
      }
    } catch (e) {
      currencyError = 'Connection error: In get Currencies';
    } finally {
      isLoadingCurrencies = false;
      notifyListeners();
    }
  }

  void saveExpense(BuildContext context) async {
    convertExpense();
    if (formKey.currentState?.validate() != true) return;
    formKey.currentState?.save();
    final expense = Expense(
      id: null,
      category: selectedCategory!.name!,
      amount: double.parse(amountController.text),
      date:selectedDatetime==null? DateTime.now().toIso8601String():selectedDatetime!,
      receiptPath: receiptImage?.path ?? "",
      currency: selectedCurrency!["code"],
      usdAmount: double.parse(convertedAmount!),
    );
    await addExpense(expense);
   await AppNavigator.finalNavigation(context, const DashboardScreen());
    reset();
  }
}
