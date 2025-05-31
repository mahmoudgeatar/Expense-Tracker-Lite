import 'package:flutter/material.dart';

class CategoryModel {
  String? name;
  Color? color;
  IconData? icon;



  CategoryModel({this.name, this.color, this.icon});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CategoryModel &&
              runtimeType == other.runtimeType &&
              name == other.name;

  @override
  int get hashCode => name.hashCode;
}