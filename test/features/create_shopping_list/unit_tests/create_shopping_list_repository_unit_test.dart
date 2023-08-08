import 'package:dartz_test/dartz_test.dart';
import 'package:mobilab_flutter_assignment/core/error/exceptions.dart';
import 'package:mobilab_flutter_assignment/features/create_shopping_list/data/create_shopping_list_remote_datasource.dart';
import 'package:mobilab_flutter_assignment/features/create_shopping_list/data/create_shopping_list_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockCreateShoppingListDatasource extends Mock
    implements CreateShoppingListRemoteDatasource {}

void main() {
  group('CreateShoppingListRepository', () {
    late CreateShoppingListRepository createShoppingListRepository;
    late MockCreateShoppingListDatasource mockDatasource;

    setUp(() {
      mockDatasource = MockCreateShoppingListDatasource();
      createShoppingListRepository =
          CreateShoppingListRepositoryImpl(datasource: mockDatasource);
    });

    test('createShoppingList returns Right', () async {
      when(
        () => mockDatasource.createShoppingList(
          title: any(named: 'title'),
          items: any(named: 'items'),
        ),
      ).thenAnswer((_) async => true);

      final result = await createShoppingListRepository
          .createShoppingList(title: 'test list', items: []);

      verify(() => mockDatasource.createShoppingList(
            title: any(named: 'title'),
            items: any(named: 'items'),
          )).called(1);
      expect(result, isRight);
    });

    test('createShoppingList returns Left', () async {
      when(
        () => mockDatasource.createShoppingList(
          title: any(named: 'title'),
          items: any(named: 'items'),
        ),
      ).thenThrow(FirebaseException(message: 'Firebase Error'));

      final result = await createShoppingListRepository
          .createShoppingList(title: 'test list', items: []);

      verify(() => mockDatasource.createShoppingList(
            title: any(named: 'title'),
            items: any(named: 'items'),
          )).called(1);
      expect(result, isLeft);
    });
  });
}
