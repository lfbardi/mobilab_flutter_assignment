import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobilab_flutter_assignment/core/design_system/colors.dart';

import '../../../../core/design_system/text_styles.dart';
import 'check_box_item_tile.dart';

class ShoppingListDetails extends ConsumerStatefulWidget {
  const ShoppingListDetails({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShoppingListDetailsState();
}

class _ShoppingListDetailsState extends ConsumerState<ShoppingListDetails> {
  final addItemsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: kBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.chevron_left_rounded, size: 30),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Breakfast shop',
                      style: kTitle,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Cart items',
                  style: kTitle,
                ),
                const SizedBox(height: 10),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 40,
                      child: const ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: 0.5,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    Text(
                      '50%',
                      style: kTitle.copyWith(fontSize: 20),
                    ),
                  ],
                ),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: CheckBoxItemTile(),
                      );
                    },
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: addItemsController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'New Item',
                          hintStyle: kDescription.copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(kPrimaryColor),
                        ),
                        onPressed: () async {},
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(kPrimaryColor),
                      ),
                      onPressed: () async {},
                      child: const Text(
                        'Finish Shopping',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
