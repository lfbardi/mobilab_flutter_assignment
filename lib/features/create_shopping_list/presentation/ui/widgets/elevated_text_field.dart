import 'package:flutter/material.dart';
import 'package:mobilab_flutter_assignment/core/design_system/text_styles.dart';

import '../../../../../core/design_system/colors.dart';

class ElevatedTextField extends StatelessWidget {
  const ElevatedTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty || value.length < 3) {
              return 'Please enter a valid name';
            }
            return null;
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: kDescription.copyWith(fontSize: 18),
          ),
          style: kTitle.copyWith(fontSize: 18),
          cursorColor: kPrimaryColor,
        ),
      ),
    );
  }
}
