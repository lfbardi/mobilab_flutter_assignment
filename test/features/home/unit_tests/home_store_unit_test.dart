import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mobilab_flutter_assignment/core/error/failures.dart';
import 'package:mobilab_flutter_assignment/features/home/data/home_repository.dart';
import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_item.dart';
import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_list.dart';
import 'package:mobilab_flutter_assignment/features/home/presentation/store/home_state.dart';
import 'package:mobilab_flutter_assignment/features/home/presentation/store/home_store.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  group('CreateShoppingListStore', () {
    late HomeStore homeStore;
    late MockHomeRepository mockRepository;
    late StreamController<HomeState> stateController;

    setUp(() {
      mockRepository = MockHomeRepository();
      stateController = StreamController<HomeState>();
      homeStore = HomeStore(repository: mockRepository);
      homeStore.addListener((state) {
        stateController.add(state);
      });
    });

    tearDown(() {
      stateController.close();
    });

    test('home - Success State', () async {
      when(
        () => mockRepository.getAllShoppingLists(),
      ).thenAnswer((_) async => const Right(<ShoppingList>[]));

      await homeStore.getAllShoppingLists();

      expect(
        homeStore.state.status,
        HomeStatus.success,
      );
    });

    test('home - Error State', () async {
      when(
        () => mockRepository.getAllShoppingLists(),
      ).thenAnswer((_) async => Left(Failure('Error Message')));

      await homeStore.getAllShoppingLists();

      expect(
        homeStore.state.status,
        HomeStatus.error,
      );
    });

    test('getListProgress return correctly', () async {
      final result = homeStore.getListProgress(
        ShoppingList(
          id: '',
          title: '',
          items: [
            ShoppingItem(
              title: 'foo',
              isChecked: false,
            ),
            ShoppingItem(
              title: 'bar',
              isChecked: true,
            ),
          ],
        ),
      );

      expect(
        result,
        50.0,
      );
    });
  });
}
