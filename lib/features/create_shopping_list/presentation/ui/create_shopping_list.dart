import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobilab_flutter_assignment/core/design_system/text_styles.dart';
import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_item.dart';
import 'package:mobilab_flutter_assignment/features/home/presentation/store/home_store.dart';

import '../../../../core/design_system/colors.dart';
import '../store/create_shopping_list_state.dart';
import '../store/create_shopping_list_store.dart';
import 'widgets/elevated_text_field.dart';

class CreateShoppingListPage extends ConsumerStatefulWidget {
  const CreateShoppingListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateShoppingListPageState();
}

class _CreateShoppingListPageState
    extends ConsumerState<CreateShoppingListPage> {
  final shoppingListNameController = TextEditingController();
  final addItemsController = TextEditingController();
  final nameFormKey = GlobalKey<FormState>();
  final itemFormKey = GlobalKey<FormState>();
  List<ShoppingItem> items = [];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createShoppingListStore);
    final store = ref.read(createShoppingListStore.notifier);
    final storeHome = ref.read(homeStore.notifier);

    return Material(
      child: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: kBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon:
                              const Icon(Icons.chevron_left_rounded, size: 30),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'New Shopping List',
                          style: kTitle.copyWith(fontSize: 26),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: nameFormKey,
                      child: ElevatedTextField(
                        controller: shoppingListNameController,
                        hintText: 'Shopping List Name',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Cart Items',
                      style: kTitle.copyWith(fontSize: 26),
                    ),
                    const SizedBox(height: 10),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              items[index].title,
                              style: kTitle.copyWith(fontSize: 20),
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
                            onPressed: () async {
                              if (itemFormKey.currentState!.validate()) {
                                setState(() {
                                  items.add(
                                    ShoppingItem(
                                      title: addItemsController.text,
                                      isChecked: false,
                                    ),
                                  );
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
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 160,
                    height: 50,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(kPrimaryColor),
                      ),
                      onPressed: () async {
                        if (nameFormKey.currentState!.validate() &&
                            items.isNotEmpty) {
                          store
                              .createShoppingList(
                            shoppingListNameController.text,
                            items,
                          )
                              .then((value) {
                            shoppingListNameController.clear();
                            Navigator.of(context)
                                .pop(storeHome.getAllShoppingLists());
                          });
                        }
                      },
                      child: state.status ==
                              CreateShoppingListStatus.creatingShoppingList
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Create List',
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
