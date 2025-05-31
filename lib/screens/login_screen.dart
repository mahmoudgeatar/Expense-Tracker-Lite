import 'package:expense_tracker_lite/constants/color_manger.dart';
import 'package:expense_tracker_lite/widgets/my_text.dart';
import 'package:flutter/material.dart';

import '../utils/navigation_helper.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/custom_text_feild.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const MyText(
                    title: "Logo",
                    size: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .1),
                  const MyText(
                    title: "Login",
                    size: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomTextField(
                    controller: emailController,
                    title: "Email",
                    fieldTypes: FieldTypes.normal,
                    type: TextInputType.emailAddress,
                    validate: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "This Field Required";
                      }
                      return null;
                    },
                    action: TextInputAction.next,
                    hint: "Enter Your Email",
                  ),
                  CustomTextField(
                    controller: passwordController,
                    title: "Password",
                    fieldTypes: FieldTypes.password,
                    type: TextInputType.text,
                    validate: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "This Field Required";
                      }
                      return null;
                    },
                    action: TextInputAction.done,
                    hint: "*******************",
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: ColorManager.border,
                    ),
                  ),
                  const SizedBox(height: 24),
                  BuildButtonWidget(
                    label: "Login",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        AppNavigator.finalNavigation(context, const DashboardScreen());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
