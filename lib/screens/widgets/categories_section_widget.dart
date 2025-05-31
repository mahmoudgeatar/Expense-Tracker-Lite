import 'package:expense_tracker_lite/constants/color_manger.dart';
import 'package:expense_tracker_lite/providers/add_expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/categories_data.dart';
import '../../widgets/my_text.dart';

class CategoriesSectionWidget extends StatelessWidget {
  const CategoriesSectionWidget({
    super.key,
    required this.provider,
  });

  final AddExpenseProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyText(
          title: "Categories",
          size: 24,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 12,
        ),
        Wrap(
          children: CategoriesData.categoriesList.map((e) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: provider.selectedCategory!.name == e.name
                            ? ColorManager.primary
                            : e.color!.withOpacity(.5),
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                      // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                        icon: FaIcon(
                          e.icon,
                          color: provider.selectedCategory!.name == e.name
                              ? ColorManager.white
                              : e.color,
                        ),
                        onPressed: () {
                          provider.changeSelectedCategory(e);
                        }),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    e.name!,
                    style: TextStyle(
                        color: provider.selectedCategory!.name == e.name
                            ? ColorManager.primary
                            : ColorManager.black,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
