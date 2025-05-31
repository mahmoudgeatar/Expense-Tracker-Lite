import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/color_manger.dart';
import 'my_text.dart';


class CustomTextField extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final bool autoFocus;
  final int? max;
  final EdgeInsets? margin;
  final EdgeInsets? contentPadding;
  final TextInputType type;
  final TextInputAction action;
  final BorderRadius? radius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Function()? onTab;
  final Color? enableBorderColor;
  final Color? focusBorderColor;
  final Color? fillColor;
  final Color? titleColor;
  final Color? hintColor;
  final Color? textColor;
  final int? maxLength;
  final Function(String? value) validate;
  final FieldTypes fieldTypes;
  final Function()? onSubmit;
  final Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autoValidateMode;
  final String? fontFamily;
  final TextDirection? textDirection;

  const CustomTextField(
      {super.key,
        this.title,
        this.titleColor,
        this.label,
        this.hint,
        required this.fieldTypes,
        this.controller,
        this.focusNode,
        this.margin,
        this.autoFocus = false,
        this.contentPadding,
        this.inputFormatters,
        required this.type,
        this.onTab,
        this.radius,
        this.max,
        this.maxLength,
        this.suffixWidget,
        this.prefixWidget,
        this.textColor,
        this.fillColor,
        this.hintColor,
        this.prefixIcon,
        this.suffixIcon,
        this.onChange,
        this.textDirection,
        this.fontFamily,
        this.autoValidateMode,
        this.onSubmit,
        required this.action,
        this.enableBorderColor,
        this.focusBorderColor,
        required this.validate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      child: Visibility(
        visible: fieldTypes == FieldTypes.clickable,
        replacement: buildFormFiled(context),
        child: buildClickableView(context),
      ),
    );
  }

  Widget buildClickableView(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: AbsorbPointer(
        absorbing: true,
        child: buildFormFiled(context),
      ),
    );
  }

  Widget buildFormFiled(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          MyText(
            title: title!,
            size: 16,
            color: titleColor ?? ColorManager.black,
            fontWeight: FontWeight.bold,
          ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          // onTapOutside: (v)=>FocusScope.of(context).requestFocus(FocusNode()),
          controller: controller,
          keyboardType: type,
          textInputAction: action,
          enableSuggestions: false,
          autocorrect: false,
          autofocus: autoFocus,
          focusNode: focusNode,
          textDirection: textDirection,
          autovalidateMode:
          autoValidateMode ?? AutovalidateMode.onUserInteraction,
          inputFormatters: type.signed == true
              ? [
            FilteringTextInputFormatter.allow(RegExp(r'[-0-9.]')),
          ]
              : inputFormatters ??
              [
                if (maxLength != null)
                  LengthLimitingTextInputFormatter(
                      maxLength), //n is maximum number of characters you want in textfield
              ],
          enabled: fieldTypes != FieldTypes.disable,
          autofillHints: getAutoFillHints(type),
          maxLines: fieldTypes == FieldTypes.chat
              ? null
              : fieldTypes == FieldTypes.rich
              ? max
              : 1,
          obscureText: fieldTypes == FieldTypes.password,
          readOnly: fieldTypes == FieldTypes.readonly,
          onEditingComplete: onSubmit,
          onChanged: onChange,
          validator: (value) => validate(value),
          style: TextStyle(
            color: textColor ?? ColorManager.grey,
            fontSize: 16,
            fontFamily: fontFamily,
          ),
          decoration: InputDecoration(
            focusColor: focusBorderColor ?? ColorManager.fields,
            counterStyle: const TextStyle(),
            errorBorder: OutlineInputBorder(
              borderRadius: radius ?? BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            labelText: label,
            hintText: hint,
            labelStyle: const TextStyle(),
            hintStyle: TextStyle(
              color: hintColor ?? Colors.grey,
              fontSize:  14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: radius ?? BorderRadius.circular(15),
              borderSide: BorderSide(
                color: enableBorderColor ?? ColorManager.white,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: radius ?? BorderRadius.circular(15),
              borderSide: BorderSide(
                color: enableBorderColor ?? ColorManager.white,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: radius ?? BorderRadius.circular(15),
              borderSide: BorderSide(
                color: enableBorderColor ?? ColorManager.white,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: radius ?? BorderRadius.circular(15),
              borderSide: BorderSide(
                color: enableBorderColor ?? ColorManager.white,
                width: 1,
              ),
            ),
            filled: true,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            fillColor:fillColor?? ColorManager.grey.withOpacity(.05),
            contentPadding: contentPadding?? const EdgeInsets.symmetric(
                horizontal:12,
                vertical: 16),
            prefix: prefixWidget,
            suffix: suffixWidget,
            errorMaxLines: 3,
            errorStyle:  TextStyle(
              color: ColorManager.selectedRed
            ),
          ),
        ),
      ],
    );
  }

  List<String> getAutoFillHints(TextInputType inputType) {
    if (inputType == TextInputType.emailAddress) {
      return [AutofillHints.email];
    } else if (inputType == TextInputType.datetime) {
      return [AutofillHints.birthday];
    } else if (inputType == TextInputType.phone) {
      return [AutofillHints.telephoneNumber];
    } else if (inputType == TextInputType.url) {
      return [AutofillHints.url];
    }
    return [AutofillHints.name, AutofillHints.username];
  }
}

enum FieldTypes { normal, clickable, readonly, chat, password, rich, disable }