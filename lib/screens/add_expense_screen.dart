import 'package:expense_tracker_lite/models/categories_model.dart';
import 'package:expense_tracker_lite/providers/add_expense_provider.dart';
import 'package:expense_tracker_lite/screens/widgets/LoaderWidget.dart';
import 'package:expense_tracker_lite/screens/widgets/categories_section_widget.dart';
import 'package:expense_tracker_lite/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/color_manger.dart';
import '../data/categories_data.dart';
import '../utils/helper.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/custom_text_feild.dart';


class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});
  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddExpenseProvider>(context, listen: false).fetchCurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AddExpenseProvider>(context, listen: true);
    return Scaffold(
       backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: const Text('Add Expense'),
        backgroundColor: ColorManager.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: provider.formKey,
          child: ListView(
            children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MyText(title: "Categories", size: 16,fontWeight: FontWeight.bold,),
                const SizedBox(height: 8,),
                DropdownButtonFormField<CategoryModel>(
                  style: TextStyle(color: ColorManager.grey),
                  value: provider.selectedCategory!,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorManager.fields,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(12),
                  menuMaxHeight: MediaQuery.of(context).size.height*.3,
                  items: CategoriesData.categoriesList.map((CategoryModel value) {
                    return DropdownMenuItem<CategoryModel>(
                      value: value,
                      child: Text(value.name!),
                    );
                  }).toList(),
                  onChanged: (CategoryModel? newValue) {
                    provider.changeSelectedCategory(newValue);
                  },
                )
              ],
            ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: provider.amountController,
                title: "Amount",
                prefixIcon:
                    Icon(Icons.attach_money_sharp, color: ColorManager.grey),
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                fieldTypes: FieldTypes.normal,
                type: const TextInputType.numberWithOptions(signed: true),
                validate: (String? value) {
                  if (value == null || value.isEmpty) return 'Enter amount';
                  final number = double.tryParse(value);
                  if (number == null || number <= 0) return 'Invalid amount';
                  return null;
                },
                action: TextInputAction.next,
                hint: "Enter Amount",
              ),
              const SizedBox(height: 16),
             // if(provider.isLoadingCurrencies==false)
              provider.currencyError==null?  Visibility(
                visible: provider.isLoadingCurrencies==false,
                replacement: const Loadingwidget(),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyText(title: "Currency", size: 16,fontWeight: FontWeight.bold,),
                  const SizedBox(height: 8,),
                  DropdownButtonFormField<Map<String, dynamic>>(
                    style: TextStyle(color: ColorManager.grey),
                    value: provider.selectedCurrency,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorManager.fields,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(12),
                    menuMaxHeight: MediaQuery.of(context).size.height*.3,
                    isExpanded: true,
                    items:provider.availableCurrencies.map((Map<String, dynamic> value) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: value,
                        child: Text(value["code"]),
                      );
                    }).toList(),
                    onChanged: (Map<String, dynamic>? newValue) {
                      provider.changeSelectedCurrency(newValue);
                    },
                  ),
                ],
              ),):MyText(title: provider.currencyError!, size: 24,color: ColorManager.selectedRed,),
              const SizedBox(height: 16),
              CustomTextField(
                controller: provider.dateController,
                title: "Date",
                suffixIcon: const Icon(Icons.date_range),
                fieldTypes: FieldTypes.clickable,
                type: const TextInputType.numberWithOptions(signed: true),
                validate: (String? value) {
                  if (value == null || value.isEmpty) return 'Choose Date';
                  return null;
                },
                action: TextInputAction.next,
                hint: "Choose Date",
                onTab: () {
                  Helper().selectDate(context, (val) {
                    provider.changeSelectedDate(val.toString());
                  });
                },
              ),
              CustomTextField(
                controller: provider.imageController,
                title: "Attach Receipt",
                suffixIcon: const Icon(Icons.photo_camera),
                fieldTypes: FieldTypes.clickable,
                type: const TextInputType.numberWithOptions(signed: true),
                validate: (String? value) {
                  if (value == null || value.isEmpty) return 'Choose Date';
                  return null;
                },
                action: TextInputAction.next,
                hint: "Upload image",
                onTab: () {
                  provider.getImage();
                },
              ),
              const SizedBox(height: 16),
              CategoriesSectionWidget(provider: provider),
              const SizedBox(height: 36),
              BuildButtonWidget(
                label: "Save",
                onTap: () => provider.saveExpense(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

