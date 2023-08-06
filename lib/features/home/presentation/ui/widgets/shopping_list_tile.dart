import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobilab_flutter_assignment/core/design_system/colors.dart';
import 'package:mobilab_flutter_assignment/core/design_system/text_styles.dart';
import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_list.dart';
import 'package:mobilab_flutter_assignment/features/home/presentation/store/home_store.dart';

import '../../../../shopping_list_details/presentation/ui/shopping_list_details.dart';

class ShoppingListTile extends ConsumerStatefulWidget {
  const ShoppingListTile({
    super.key,
    required this.shoppingList,
  });

  final ShoppingList shoppingList;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShoppingListTileState();
}

class _ShoppingListTileState extends ConsumerState<ShoppingListTile> {
  Color headerColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final store = ref.read(homeStore.notifier);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShoppingListDetails(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                        value: double.parse(store
                                .getListProgress(widget.shoppingList)
                                .toStringAsFixed(2)) /
                            100,
                      ),
                    ),
                    Positioned(
                      child: Text(
                        '${store.getListProgress(widget.shoppingList).toStringAsFixed(0)}%',
                        style: kTitle.copyWith(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.shoppingList.title,
                      style: kTitle.copyWith(fontSize: 18),
                    ),
                    Text(
                      '${widget.shoppingList.items.length} items',
                      style: kDescription.copyWith(fontSize: 14),
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  height: 50,
                  width: 3,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
