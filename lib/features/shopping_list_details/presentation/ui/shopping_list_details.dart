import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobilab_flutter_assignment/core/design_system/colors.dart';
import 'package:mobilab_flutter_assignment/features/shopping_list_details/presentation/store/shopping_list_details_store.dart';

import '../../../../core/design_system/text_styles.dart';
import '../../../home/data/models/shopping_list.dart';
import '../../../home/presentation/store/home_store.dart';
import '../store/shopping_list_details_state.dart';

class ShoppingListDetails extends ConsumerStatefulWidget {
  const ShoppingListDetails({super.key, required this.shoppingList});

  final ShoppingList shoppingList;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShoppingListDetailsState();
}

class _ShoppingListDetailsState extends ConsumerState<ShoppingListDetails> {
  final addItemsController = TextEditingController();
  final itemFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(shoppingListDetailsStore.notifier)
          .initShoppingList(widget.shoppingList);
    });
  }

  @override
  Widget build(BuildContext context) {
    final storeHome = ref.read(homeStore.notifier);
    final state = ref.watch(shoppingListDetailsStore);
    final store = ref.watch(shoppingListDetailsStore.notifier);

    if (state.status == ShoppingListDetailsStatus.initial) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: kBackgroundColor,
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Smart Shopping List', style: kTitle),
              Spacer(),
              Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              ),
              Spacer(),
            ],
          ),
        ),
      );
    }

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
                        store
                            .updateShoppingList(
                                shoppingList: state.edittingShoppingList!)
                            .then((value) {
                          Navigator.of(context)
                              .pop(storeHome.getAllShoppingLists());
                        });
                      },
                      icon: const Icon(Icons.chevron_left_rounded, size: 30),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      state.edittingShoppingList?.title ?? 'Unknown',
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
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: double.parse(store
                                  .getListProgress(widget.shoppingList)
                                  .toStringAsFixed(2)) /
                              100,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    Text(
                      '${store.getListProgress(widget.shoppingList).toStringAsFixed(0)}%',
                      style: kTitle.copyWith(fontSize: 20),
                    ),
                  ],
                ),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.edittingShoppingList!.items.length,
                    itemBuilder: (context, index) {
                      final shoppingItem =
                          state.edittingShoppingList!.items[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                value: shoppingItem.isChecked,
                                shape: const CircleBorder(
                                  eccentricity: 0,
                                ),
                                activeColor: kPrimaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    store.toggleShoppingItem(index);
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(shoppingItem.title,
                                style: kTitle.copyWith(fontSize: 20)),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                store.removeItem(index);
                              },
                              icon: Icon(Icons.delete_rounded,
                                  color: Colors.red.shade300),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Form(
                        key: itemFormKey,
                        child: TextFormField(
                          controller: addItemsController,
                          style: kTitle.copyWith(fontSize: 18),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 3) {
                              return 'Please enter a valid name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'New Item',
                            hintStyle: kDescription.copyWith(fontSize: 18),
                          ),
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
                        onPressed: () {
                          if (itemFormKey.currentState!.validate()) {
                            setState(() {
                              store.addItem(addItemsController.text);
                              addItemsController.clear();
                            });
                          }
                        },
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
                      style: ButtonStyle(
                        backgroundColor: state.isFinishShoppingEnabled
                            ? const MaterialStatePropertyAll(kPrimaryColor)
                            : const MaterialStatePropertyAll(Colors.grey),
                      ),
                      onPressed: state.isFinishShoppingEnabled
                          ? () async {
                              store
                                  .finishShoppingList(
                                      state.edittingShoppingList!)
                                  .then((value) {
                                Navigator.of(context)
                                    .pop(storeHome.getAllShoppingLists());
                              });
                            }
                          : null,
                      child: state.status ==
                              ShoppingListDetailsStatus.finishingShoppingList
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : state.isFinishShoppingEnabled
                              ? const Text(
                                  'Finish Shopping',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                )
                              : const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Finish Shopping',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.lock_outline_rounded,
                                        color: Colors.white),
                                  ],
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
