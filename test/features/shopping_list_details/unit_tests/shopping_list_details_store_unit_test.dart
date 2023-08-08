import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mobilab_flutter_assignment/core/error/failures.dart';
import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_item.dart';
import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_list.dart';
import 'package:mobilab_flutter_assignment/features/shopping_list_details/data/shopping_list_details_repository.dart';
import 'package:mobilab_flutter_assignment/features/shopping_list_details/presentation/store/shopping_list_details_state.dart';
import 'package:mobilab_flutter_assignment/features/shopping_list_details/presentation/store/shopping_list_details_store.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockShoppingListDetailsRepository extends Mock
    implements ShoppingListDetailsRepository {}

void main() {
  group('CreateShoppingListStore', () {
    late ShoppingListDetailsStore store;
    late MockShoppingListDetailsRepository mockRepository;
    late StreamController<ShoppingListDetailsState> stateController;

    const String title = 'Test Shopping List';
    final List<ShoppingItem> items = [
      ShoppingItem(title: 'Rice', isChecked: true),
      ShoppingItem(title: 'Meat', isChecked: true),
    ];
    final testList = ShoppingList(id: 'id', title: title, items: items);

    setUp(() {
      mockRepository = MockShoppingListDetailsRepository();
      stateController = StreamController<ShoppingListDetailsState>();
      store = ShoppingListDetailsStore(repository: mockRepository);
      store.addListener((state) {
        stateController.add(state);
      });
    });

    tearDown(() {
      stateController.close();
    });

    test('update shopping list - Success State', () async {
      when(
        () => mockRepository.updateShoppingList(shoppingList: testList),
      ).thenAnswer((_) async => const Right(true));

      await store.updateShoppingList(shoppingList: testList);

      expect(
        store.state.status,
        ShoppingListDetailsStatus.success,
      );
    });

    test('update shopping list - Error State', () async {
      when(
        () => mockRepository.updateShoppingList(shoppingList: testList),
      ).thenAnswer((_) async => Left(Failure('Error Message')));

      await store.updateShoppingList(shoppingList: testList);

      expect(
        store.state.status,
        ShoppingListDetailsStatus.error,
      );
    });

    test('finish shopping list - Success State', () async {
      when(
        () => mockRepository.finishShoppingList(shoppingList: testList),
      ).thenAnswer((_) async => const Right(true));

      await store.finishShoppingList(testList);

      expect(
        store.state.status,
        ShoppingListDetailsStatus.success,
      );
    });

    test('finish shopping list - Error State', () async {
      when(
        () => mockRepository.finishShoppingList(shoppingList: testList),
      ).thenAnswer((_) async => Left(Failure('Error Message')));

      await store.finishShoppingList(testList);

      expect(
        store.state.status,
        ShoppingListDetailsStatus.error,
      );
    });
  });
}
