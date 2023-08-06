// ignore: avoid_web_libraries_in_flutter
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobilab_flutter_assignment/core/dio/firebase_dio.dart';
import 'package:mobilab_flutter_assignment/features/home/data/home_remote_datasource.dart';
import 'package:mobilab_flutter_assignment/features/home/data/home_repository.dart';
import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_list.dart';
import 'package:mobilab_flutter_assignment/features/home/presentation/store/home_state.dart';

final homeRemoteDatasource = Provider<HomeRemoteDatasource>((ref) {
  return HomeRemoteDatasourceImpl(dio: ref.read(firebaseDio));
});

final homeRepository = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(
    datasource: ref.read(homeRemoteDatasource),
  );
});

final homeStore = StateNotifierProvider<HomeStore, HomeState>(
  (ref) => HomeStore(
    repository: ref.read(
      homeRepository,
    ),
  ),
);

class HomeStore extends StateNotifier<HomeState> {
  HomeStore({
    required this.repository,
  }) : super(
          HomeState(
            errorMessage: '',
            status: HomeStatus.initial,
            shoppingLists: [],
          ),
        );

  final HomeRepository repository;

  Future getAllShoppingLists() async {
    final shoppingListsEither = await repository.getAllShoppingLists();

    shoppingListsEither.fold(
      (failure) {
        state = state.copyWith(
          status: HomeStatus.error,
          errorMessage: failure.errorMessage,
        );
      },
      (shoppingLists) {
        state = state.copyWith(
          status: HomeStatus.success,
          shoppingLists: shoppingLists,
        );
      },
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
}
