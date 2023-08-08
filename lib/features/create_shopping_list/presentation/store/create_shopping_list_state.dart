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

  @override
  bool operator ==(covariant CreateShoppingListState other) {
    if (identical(this, other)) return true;

    return other.errorMessage == errorMessage && other.status == status;
  }

  @override
  int get hashCode => errorMessage.hashCode ^ status.hashCode;
}
