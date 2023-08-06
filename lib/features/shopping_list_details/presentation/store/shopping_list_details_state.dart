import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_list.dart';

enum ShoppingListDetailsStatus {
  initial,
  updatingShoppingList,
  finishingShoppingList,
  success,
  error,
}

class ShoppingListDetailsState {
  final String errorMessage;
  final ShoppingListDetailsStatus status;
  ShoppingList? edittingShoppingList;

  bool get isFinishShoppingEnabled {
    return edittingShoppingList?.items
            .where((element) => element.isChecked == false)
            .isEmpty ==
        true;
  }

  ShoppingListDetailsState({
    required this.errorMessage,
    required this.status,
    required this.edittingShoppingList,
  });

  ShoppingListDetailsState copyWith({
    String? errorMessage,
    ShoppingListDetailsStatus? status,
    ShoppingList? edittingShoppingList,
  }) {
    return ShoppingListDetailsState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      edittingShoppingList: edittingShoppingList ?? this.edittingShoppingList,
    );
  }
}
