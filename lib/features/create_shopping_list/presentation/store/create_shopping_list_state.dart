enum CreateShoppingListStatus {
  initial,
  creatingShoppingList,
  success,
  error,
}

class CreateShoppingListState {
  final String errorMessage;
  final CreateShoppingListStatus status;

  CreateShoppingListState({
    required this.errorMessage,
    required this.status,
  });

  CreateShoppingListState copyWith({
    String? errorMessage,
    CreateShoppingListStatus? status,
  }) {
    return CreateShoppingListState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
