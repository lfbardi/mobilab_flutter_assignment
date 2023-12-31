import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobilab_flutter_assignment/core/dio/firebase_dio.dart';
import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_list.dart';
import 'package:mobilab_flutter_assignment/features/shopping_list_details/data/shopping_list_details_repository.dart';
import 'package:mobilab_flutter_assignment/features/shopping_list_details/presentation/store/shopping_list_details_state.dart';

import '../../../home/data/models/shopping_item.dart';
import '../../data/shopping_list_details_remote_datasource.dart';

final shoppingListDetailsRemoteDatasource =
    Provider.autoDispose<ShoppingListDetailsRemoteDatasource>((ref) {
  return ShoppingListDetailsRemoteDatasourceImpl(dio: ref.read(firebaseDio));
});

final shoppingListDetailsRepository =
    Provider.autoDispose<ShoppingListDetailsRepository>((ref) {
  return ShoppingListDetailsRepositoryImpl(
    datasource: ref.read(shoppingListDetailsRemoteDatasource),
  );
});

final shoppingListDetailsStore = StateNotifierProvider.autoDispose<
    ShoppingListDetailsStore, ShoppingListDetailsState>(
  (ref) => ShoppingListDetailsStore(
    repository: ref.read(
      shoppingListDetailsRepository,
    ),
  ),
);

class ShoppingListDetailsStore extends StateNotifier<ShoppingListDetailsState> {
  ShoppingListDetailsStore({
    required this.repository,
  }) : super(
          ShoppingListDetailsState(
            errorMessage: '',
            status: ShoppingListDetailsStatus.initial,
            edittingShoppingList: null,
          ),
        );

  final ShoppingListDetailsRepository repository;

  Future updateShoppingList({required ShoppingList shoppingList}) async {
    state = state.copyWith(
      status: ShoppingListDetailsStatus.updatingShoppingList,
    );

    final updateShoppingListEither =
        await repository.updateShoppingList(shoppingList: shoppingList);

    updateShoppingListEither.fold(
      (failure) {
        state = state.copyWith(
          status: ShoppingListDetailsStatus.error,
          errorMessage: failure.errorMessage,
        );
      },
      (success) {
        state = state.copyWith(
          status: ShoppingListDetailsStatus.success,
        );
      },
    );
  }

  initShoppingList(ShoppingList shoppingList) {
    state = state.copyWith(
      edittingShoppingList: shoppingList,
      status: ShoppingListDetailsStatus.success,
    );
  }

  double getListProgress(ShoppingList list) {
    int totalProgress = 0;
    for (var item in list.items) {
      if (item.isChecked) {
        totalProgress += 1;
      }
    }
    return (totalProgress / list.items.length) * 100;
  }

  addItem(String title) {
    final newList = state.edittingShoppingList!.items;
    newList.add(ShoppingItem(title: title, isChecked: false));
    state = state.copyWith(
      edittingShoppingList:
          state.edittingShoppingList!.copyWith(items: newList),
    );
  }

  removeItem(int index) {
    final newList = state.edittingShoppingList!.items;
    if (newList.length > 1) {
      newList.removeAt(index);
      state = state.copyWith(
        edittingShoppingList:
            state.edittingShoppingList!.copyWith(items: newList),
      );
    }
  }

  toggleShoppingItem(int index) {
    final newList = state.edittingShoppingList!.items;
    newList[index] =
        newList[index].copyWith(isChecked: !newList[index].isChecked);
    state = state.copyWith(
      edittingShoppingList:
          state.edittingShoppingList!.copyWith(items: newList),
    );
  }

  Future finishShoppingList(ShoppingList shoppingList) async {
    state = state.copyWith(
      status: ShoppingListDetailsStatus.finishingShoppingList,
    );

    final updateShoppingListEither = await repository.finishShoppingList(
      shoppingList: shoppingList,
    );

    updateShoppingListEither.fold(
      (failure) {
        state = state.copyWith(
          status: ShoppingListDetailsStatus.error,
          errorMessage: failure.errorMessage,
        );
      },
      (success) {
        state = state.copyWith(
          status: ShoppingListDetailsStatus.success,
        );
      },
    );
  }
}
