import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobilab_flutter_assignment/core/design_system/colors.dart';
import 'package:mobilab_flutter_assignment/features/home/presentation/store/home_store.dart';

import '../../../../core/design_system/text_styles.dart';
import '../../../create_shopping_list/presentation/ui/create_shopping_list.dart';
import '../store/home_state.dart';
import 'widgets/shopping_list_tile.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeStore.notifier).getAllShoppingLists();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeStore);
    final store = ref.read(homeStore.notifier);

    switch (state.status) {
      case HomeStatus.initial:
      case HomeStatus.loading:
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
      case HomeStatus.error:
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
                const Spacer(),
                Center(
                  child: Text(
                    'Ops, something went wrong!',
                    style: kTitle.copyWith(fontSize: 20),
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
                        backgroundColor:
                            MaterialStatePropertyAll(kPrimaryColor),
                      ),
                      onPressed: () async {
                        await store.getAllShoppingLists();
                      },
                      child: const Text(
                        'Retry',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      case HomeStatus.success:
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
                state.shoppingLists!.isNotEmpty
                    ? Flexible(
                        child: ListView.builder(
                          itemCount: state.shoppingLists!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ShoppingListTile(
                                shoppingList: state.shoppingLists![index],
                              ),
                            );
                          },
                        ),
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: Text(
                          'You have no shopping lists yet!',
                          textAlign: TextAlign.center,
                          style: kDescription.copyWith(fontSize: 20),
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
                        backgroundColor:
                            MaterialStatePropertyAll(kPrimaryColor),
                      ),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CreateShoppingListPage(),
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
        );
    }
  }
}
