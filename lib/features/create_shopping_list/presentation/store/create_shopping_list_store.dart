import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobilab_flutter_assignment/core/dio/firebase_dio.dart';
import 'package:mobilab_flutter_assignment/features/create_shopping_list/data/create_shopping_list_remote_datasource.dart';
import 'package:mobilab_flutter_assignment/features/create_shopping_list/data/create_shopping_list_repository.dart';
import 'package:mobilab_flutter_assignment/features/create_shopping_list/presentation/store/create_shopping_list_state.dart';

import '../../../home/data/models/shopping_item.dart';

final createShoppingListRemoteDatasource =
    Provider.autoDispose<CreateShoppingListRemoteDatasource>((ref) {
  return CreateShoppingListRemoteDatasourceImpl(dio: ref.read(firebaseDio));
});

final createShoppingListRepository =
    Provider.autoDispose<CreateShoppingListRepository>((ref) {
  return CreateShoppingListRepositoryImpl(
    datasource: ref.read(createShoppingListRemoteDatasource),
  );
});

final createShoppingListStore = StateNotifierProvider.autoDispose<
    CreateShoppingListStore, CreateShoppingListState>(
  (ref) => CreateShoppingListStore(
    repository: ref.read(
      createShoppingListRepository,
    ),
  ),
);

class CreateShoppingListStore extends StateNotifier<CreateShoppingListState> {
  CreateShoppingListStore({
    required this.repository,
  }) : super(
          CreateShoppingListState(
            errorMessage: '',
            status: CreateShoppingListStatus.initial,
          ),
        );

  final CreateShoppingListRepository repository;

  Future createShoppingList(String title, List<ShoppingItem> items) async {
    state = state.copyWith(
      status: CreateShoppingListStatus.creatingShoppingList,
    );

    final createShoppingListEither = await repository.createShoppingList(
      title: title,
      items: items,
    );

    createShoppingListEither.fold(
      (failure) {
        state = state.copyWith(
          status: CreateShoppingListStatus.error,
          errorMessage: failure.errorMessage,
        );
      },
      (shoppingLists) {
        state = state.copyWith(
          status: CreateShoppingListStatus.success,
        );
      },
    );
  }
}
