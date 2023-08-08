import 'package:dartz_test/dartz_test.dart';
import 'package:mobilab_flutter_assignment/core/error/exceptions.dart';
import 'package:mobilab_flutter_assignment/features/home/data/home_remote_datasource.dart';
import 'package:mobilab_flutter_assignment/features/home/data/home_repository.dart';
import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_item.dart';
import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_list.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHomeDatasource extends Mock implements HomeRemoteDatasource {}

void main() {
  group('Home Repository', () {
    late HomeRepository homeRepository;
    late MockHomeDatasource mockDatasource;

    setUp(() {
      mockDatasource = MockHomeDatasource();
      homeRepository = HomeRepositoryImpl(datasource: mockDatasource);
    });

    test('getAllShoppingLists returns Right', () async {
      when(
        () => mockDatasource.getAllShoppingLists(),
      ).thenAnswer(
        (_) async => [
          ShoppingList(
            id: '',
            title: '',
            items: [
              ShoppingItem(
                title: '',
                isChecked: false,
              ),
            ],
          )
        ],
      );

      final result = await homeRepository.getAllShoppingLists();

      verify(() => mockDatasource.getAllShoppingLists()).called(1);
      expect(result, isRight);
    });

    test('createShoppingList returns Left', () async {
      when(
        () => mockDatasource.getAllShoppingLists(),
      ).thenThrow(FirebaseException(message: 'Error'));

      final result = await homeRepository.getAllShoppingLists();

      verify(() => mockDatasource.getAllShoppingLists()).called(1);
      expect(result, isLeft);
    });
  });
}
