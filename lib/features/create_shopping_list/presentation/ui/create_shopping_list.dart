import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobilab_flutter_assignment/core/design_system/text_styles.dart';

import '../../../../core/design_system/colors.dart';
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

  @override
  Widget build(BuildContext context) {
    return Material(
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
                        icon: const Icon(Icons.chevron_left_rounded, size: 30),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'New Shopping List',
                        style: kTitle.copyWith(fontSize: 26),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedTextField(
                    controller: TextEditingController(),
                    hintText: 'Shopping List Name',
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
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Cenoura',
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
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 160,
                  height: 50,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(kPrimaryColor),
                    ),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateShoppingListPage(),
                        ),
                      );
                    },
                    child: const Text(
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
    );
  }
}
