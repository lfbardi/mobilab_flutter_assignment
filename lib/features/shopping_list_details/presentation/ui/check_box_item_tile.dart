import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobilab_flutter_assignment/core/design_system/colors.dart';
import 'package:mobilab_flutter_assignment/core/design_system/text_styles.dart';

class CheckBoxItemTile extends ConsumerStatefulWidget {
  const CheckBoxItemTile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CheckBoxItemTileState();
}

class _CheckBoxItemTileState extends ConsumerState<CheckBoxItemTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.3,
          child: Checkbox(
            value: isChecked,
            shape: const CircleBorder(
              eccentricity: 0,
            ),
            activeColor: kPrimaryColor,
            onChanged: (value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
        ),
        const SizedBox(width: 10),
        Text('Cenoura', style: kTitle.copyWith(fontSize: 20)),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.delete_rounded, color: Colors.red.shade300),
        )
      ],
    );
  }
}
