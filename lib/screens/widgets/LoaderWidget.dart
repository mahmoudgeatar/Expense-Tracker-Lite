import 'package:flutter/material.dart';

class Loadingwidget extends StatelessWidget {
  const Loadingwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child:
      Center(child: CircularProgressIndicator()),
    );
  }
}
