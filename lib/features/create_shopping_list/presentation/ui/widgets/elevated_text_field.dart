import 'package:flutter/material.dart';
import 'package:mobilab_flutter_assignment/core/design_system/text_styles.dart';

import '../../../../../core/design_system/colors.dart';

class ElevatedTextField extends StatelessWidget {
  const ElevatedTextField({
    super.key,
    this.formKey,
    required this.controller,
    required this.hintText,
  });

  final GlobalKey<FormState>? formKey;
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey ?? GlobalKey<FormState>(),
      child: Container(
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2), // vertical and horizontal offset
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: kDescription.copyWith(fontSize: 18),
            ),
            style: kTitle.copyWith(fontSize: 18),
            cursorColor: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
