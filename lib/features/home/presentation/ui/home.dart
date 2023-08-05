import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobilab_flutter_assignment/core/design_system/colors.dart';

import '../../../../core/design_system/text_styles.dart';
import 'widgets/shopping_list_tile.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: kBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Smart Shopping List', style: kTitle),
            const SizedBox(height: 20),
            Flexible(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: ShoppingListTile(),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 160,
                height: 50,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(kPrimaryColor),
                  ),
                  onPressed: () async {},
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
    );
  }
}
