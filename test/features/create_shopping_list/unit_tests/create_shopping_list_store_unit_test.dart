import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mobilab_flutter_assignment/core/error/failures.dart';
import 'package:mobilab_flutter_assignment/features/create_shopping_list/data/create_shopping_list_repository.dart';
import 'package:mobilab_flutter_assignment/features/create_shopping_list/presentation/store/create_shopping_list_state.dart';
import 'package:mobilab_flutter_assignment/features/create_shopping_list/presentation/store/create_shopping_list_store.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockCreateShoppingListRepository extends Mock
    implements CreateShoppingListRepository {}

void main() {
  group('CreateShoppingListStore', () {
    late CreateShoppingListStore shoppingListStore;
    late MockCreateShoppingListRepository mockRepository;
    late StreamController<CreateShoppingListState> stateController;

    setUp(() {
      mockRepository = MockCreateShoppingListRepository();
      stateController = StreamController<CreateShoppingListState>();
      shoppingListStore = CreateShoppingListStore(repository: mockRepository);
      shoppingListStore.addListener((state) {
        stateController.add(state);
      });
    });

    tearDown(() {
      stateController.close();
    });

    test('createShoppingList - Success State', () async {
      when(
        () => mockRepository.createShoppingList(
          title: any(named: 'title'),
          items: any(named: 'items'),
        ),
      ).thenAnswer((_) async => const Right(true));

      await shoppingListStore.createShoppingList('My List', []);

      expect(
        shoppingListStore.state.status,
        CreateShoppingListStatus.success,
      );
    });

    test('createShoppingList - Error State', () async {
      when(
        () => mockRepository.createShoppingList(
          title: any(named: 'title'),
          items: any(named: 'items'),
        ),
      ).thenAnswer((_) async => Left(Failure('Error Message')));

      await shoppingListStore.createShoppingList('My List', []);

      expect(
        shoppingListStore.state.status,
        CreateShoppingListStatus.error,
      );
    });
  });
}
