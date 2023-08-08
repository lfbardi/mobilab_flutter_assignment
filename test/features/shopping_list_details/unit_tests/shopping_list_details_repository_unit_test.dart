import 'package:dartz_test/dartz_test.dart';
import 'package:mobilab_flutter_assignment/core/error/exceptions.dart';
import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_item.dart';
import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_list.dart';
import 'package:mobilab_flutter_assignment/features/shopping_list_details/data/shopping_list_details_remote_datasource.dart';
import 'package:mobilab_flutter_assignment/features/shopping_list_details/data/shopping_list_details_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockShoppingListDetailsDatasource extends Mock
    implements ShoppingListDetailsRemoteDatasource {}

void main() {
  group('Shopping List Details Repository', () {
    late ShoppingListDetailsRepository shoppingListDetailsRepository;
    late MockShoppingListDetailsDatasource mockDatasource;

    setUp(() {
      mockDatasource = MockShoppingListDetailsDatasource();
      shoppingListDetailsRepository =
          ShoppingListDetailsRepositoryImpl(datasource: mockDatasource);
    });

    const String title = 'Test Shopping List';
    final List<ShoppingItem> items = [
      ShoppingItem(title: 'Rice', isChecked: true),
      ShoppingItem(title: 'Meat', isChecked: true),
    ];
    final testList = ShoppingList(id: 'id', title: title, items: items);

    test('updateShoppingList returns Right', () async {
      when(
        () => mockDatasource.updateShoppingList(testList),
      ).thenAnswer((_) async => true);

      final result = await shoppingListDetailsRepository.updateShoppingList(
        shoppingList: testList,
      );

      verify(() => mockDatasource.updateShoppingList(testList)).called(1);
      expect(result, isRight);
    });

    test('updateShoppingList returns Left', () async {
      when(
        () => mockDatasource.updateShoppingList(testList),
      ).thenThrow(FirebaseException(message: 'Firebase Error'));

      final result = await shoppingListDetailsRepository.updateShoppingList(
        shoppingList: testList,
      );

      verify(() => mockDatasource.updateShoppingList(testList)).called(1);
      expect(result, isLeft);
    });

    test('finishShoppingList returns Right', () async {
      when(
        () => mockDatasource.finishShoppingList(testList),
      ).thenAnswer((_) async => true);

      final result = await shoppingListDetailsRepository.finishShoppingList(
        shoppingList: testList,
      );

      verify(() => mockDatasource.finishShoppingList(testList)).called(1);
      expect(result, isRight);
    });

    test('finishShoppingList returns Left', () async {
      when(
        () => mockDatasource.finishShoppingList(testList),
      ).thenThrow(FirebaseException(message: 'Firebase Error'));

      final result = await shoppingListDetailsRepository.finishShoppingList(
        shoppingList: testList,
      );

      verify(() => mockDatasource.finishShoppingList(testList)).called(1);
      expect(result, isLeft);
    });
  });
}
