import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validatorCheck;
  final bool? isTypeNumb;
  final bool? isCheckReadOnly;
  final Widget? suffixIcon;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.validatorCheck,
    this.isTypeNumb,
    this.isCheckReadOnly,
    this.suffixIcon,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      obscureText: widget.obscureText,
      // style: AppStyles.black000Size14Fw400FfMont,
      keyboardType: widget.isTypeNumb != null && widget.isTypeNumb == true
          ? TextInputType.number
          : TextInputType.text,
      readOnly: widget.isCheckReadOnly != null && widget.isCheckReadOnly == true
          ? true
          : false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: ColorConstants.darkGray.withOpacity(.5),
          ),
        ),
        suffixIconConstraints:
            const BoxConstraints(maxHeight: 60, maxWidth: 60),
        suffixIcon: widget.suffixIcon,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: Colors.blue),
        ),
        fillColor: Colors.grey.shade100,
        labelText: widget.hintText,
        labelStyle: TextStyle(
          color: ColorConstants.accent1,
          fontWeight: FontWeight.w400,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 1.5,
            color: ColorConstants.red,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 0.5,
            color: ColorConstants.red,
          ),
        ),
        isDense: true,
      ),
      validator: (widget.validatorCheck ??
          (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Don\'t empty';
            }
            return null;
          }),
      cursorColor: ColorConstants.primaryButton,
    );
  }
}
