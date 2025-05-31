import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/color_manger.dart';
import '../models/categories_model.dart';

class CategoriesData{
  static List<CategoryModel> categoriesList = [
    CategoryModel(
        color: ColorManager.primary,
        icon: FontAwesomeIcons.cartShopping,
        name: "Groceries"),
    CategoryModel(
        color: ColorManager.selectedRed,
        icon: FontAwesomeIcons.iceCream,
        name: "Entertainment"),
  ];
}