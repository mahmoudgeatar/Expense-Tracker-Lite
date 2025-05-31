
import 'package:expense_tracker_lite/constants/color_manger.dart';
import 'package:flutter/material.dart';


class BuildButtonWidget extends StatelessWidget {
  final Function() onTap;
  final String? label;
  const BuildButtonWidget({super.key, required this.onTap,this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient:  LinearGradient(
          colors: [
           ColorManager.primary,
            ColorManager.primary,
            ColorManager.primary,
            ColorManager.primary,
            ColorManager.lightPrimary
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,

        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child:  Center(
            child: Text(
              label??'Login',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}