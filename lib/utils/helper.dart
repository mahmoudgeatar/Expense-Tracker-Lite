import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../constants/color_manger.dart';

class Helper{
  static Future<String> getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25,
        maxHeight: 2000,
        maxWidth: 2000);
    if (image != null) {
     // File imageFile = File(image.path);
      return image.path.substring(image.path.lastIndexOf('/') + 1);
    }
    return "";
  }

  Future<void> selectDate(BuildContext context,
      final Function(DateTime selectedValue) onItemSelected,) async {
    final DateTime? picked = await showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: 300,
          color: ColorManager.white,
          child: Column(
            children: [
              Container(
                height: 200,
                child: CupertinoDatePicker(
                    initialDateTime:  DateTime.now(),
                    mode: CupertinoDatePickerMode.dateAndTime,
                    onDateTimeChanged: (val) {
                      onItemSelected(val);
                    }),
              ),

            ],
          ),
        ));
    // if (picked != null && picked != selectedDate) {
    //   selectedDate = picked;
    // }
  }


  static String getDate(String date) {
    DateTime expensesDate=DateTime.parse(date);
    final now = DateTime.now();
    bool isToday= expensesDate.year == now.year &&
        expensesDate.month == now.month &&
        expensesDate.day == now.day;

    return "${isToday?"Today":DateFormat('EE').format(DateTime.parse(date))} ${DateFormat('d HH:mm a').format(DateTime.parse(date))}";
  }
}