// lib/presentation/screens/dashboard_screen.dart
import 'package:expense_tracker_lite/constants/color_manger.dart';
import 'package:expense_tracker_lite/providers/add_expense_provider.dart';
import 'package:expense_tracker_lite/providers/expense_provider.dart';
import 'package:expense_tracker_lite/screens/widgets/LoaderWidget.dart';
import 'package:expense_tracker_lite/screens/widgets/balance_card_widget.dart';
import 'package:expense_tracker_lite/screens/widgets/expenses_card_widget.dart';
import 'package:expense_tracker_lite/screens/widgets/floating_action_button_widget.dart';
import 'package:expense_tracker_lite/screens/widgets/section_header_widget.dart';
import 'package:expense_tracker_lite/screens/widgets/total_balance_widget.dart';
import 'package:expense_tracker_lite/utils/helper.dart';
import 'package:expense_tracker_lite/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'add_expense_screen.dart';
import '../models/expense_model.dart';

enum DateFilter { last7Days, currentMonth }

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentPage = 0;
  final scrollController = ScrollController();

  DateFilterType selectedFilter = DateFilterType.last7Days;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    provider.loadExpenses(page: currentPage, filter: selectedFilter,);
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent && !provider.isLoading) {
        currentPage++;
        provider.loadExpenses(
          page: currentPage,
          filter: selectedFilter,
        );
      }
    });
  }

  double getTotalExpenses(List<Expense> expenses) {
    return expenses.fold(0.0, (sum, e) => sum + e.amount);
  }

  void _onFilterChanged(DateFilterType? filter) {
    if (filter == null) return;
    setState(() {
      selectedFilter = filter;
      currentPage = 0;
    });
    Provider.of<ExpenseProvider>(context, listen: false).loadExpenses(
      page: 0,
      filter: selectedFilter,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context);
    final expenses = provider.expenses.reversed.toList();
    final totalExpenses = getTotalExpenses(expenses);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          currentPage = 0;
          await provider.loadExpenses(page: 0, filter: selectedFilter);
        },
        child: Stack(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * .4,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * .07),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                title: "Good Morning",
                                size: 16,
                                color: ColorManager.white,
                              ),
                              MyText(
                                title: "Shihab Rahman",
                                size: 20,
                                color: ColorManager.white,
                                fontWeight: FontWeight.w500,
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButton<DateFilterType>(
                            value: selectedFilter,
                            onChanged: _onFilterChanged,
                            underline: const SizedBox(),
                            items: const [
                              DropdownMenuItem(
                                value: DateFilterType.last7Days,
                                child: Text('Last 7 Days'),
                              ),
                              DropdownMenuItem(
                                value: DateFilterType.currentMonth,
                                child: Text('This Month'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * .05),
                BalanceCardWidget(totalExpenses: totalExpenses),
                const SectionHeader(),
                expenses.isEmpty
                    ? const Center(child: Text("No Data"))
                    : Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          controller: scrollController,
                          itemCount:
                              expenses.length + (provider.isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == expenses.length) {
                              return const Loadingwidget();
                            }
                            return ExpensesCardWidget(
                              expense: expenses[index],
                            );
                          },
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButtonWidget(),
    );
  }
}
