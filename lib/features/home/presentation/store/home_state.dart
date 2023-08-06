import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_list.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  error,
}

class HomeState {
  final String errorMessage;
  final HomeStatus status;
  final List<ShoppingList>? shoppingLists;

  HomeState({
    required this.errorMessage,
    required this.status,
    this.shoppingLists,
  });

  HomeState copyWith({
    String? errorMessage,
    HomeStatus? status,
    List<ShoppingList>? shoppingLists,
  }) {
    return HomeState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      shoppingLists: shoppingLists ?? this.shoppingLists,
    );
  }
}
