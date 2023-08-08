import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobilab_flutter_assignment/core/error/exceptions.dart';
import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_item.dart';
import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_list.dart';
import 'package:mobilab_flutter_assignment/features/shopping_list_details/data/shopping_list_details_remote_datasource.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late ShoppingListDetailsRemoteDatasource datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = ShoppingListDetailsRemoteDatasourceImpl(dio: mockDio);
  });

  group('Shopping List Details Datasource', () {
    const String title = 'Test Shopping List';
    final List<ShoppingItem> items = [
      ShoppingItem(title: 'Rice', isChecked: true),
      ShoppingItem(title: 'Meat', isChecked: true),
    ];
    final testList = ShoppingList(id: 'id', title: title, items: items);

    test('should update Shopping List successfully', () async {
      when(() => mockDio.patch(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      final result = await datasource.updateShoppingList(
        testList,
      );

      expect(result, true);
      verify(
        () => mockDio.patch('/shopping-lists/id.json', data: testList.toMap()),
      ).called(1);
    });

    test(
        'should throw FirebaseException on unsuccessful updating shopping list',
        () async {
      when(() => mockDio.patch(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
        ),
      );

      final call = datasource.updateShoppingList(
        ShoppingList(id: 'id', title: title, items: items),
      );

      expect(call, throwsA(isA<FirebaseException>()));
      verify(
        () => mockDio.patch('/shopping-lists/id.json', data: testList.toMap()),
      ).called(1);
    });

    test('should finish Shopping List successfully', () async {
      when(() => mockDio.delete(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      final result = await datasource.finishShoppingList(
        testList,
      );

      expect(result, true);
      verify(
        () => mockDio.delete('/shopping-lists/id.json'),
      ).called(1);
    });

    test('should throw FirebaseException on unsuccessful finish shopping list',
        () async {
      when(() => mockDio.delete('/shopping-lists/id.json')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
        ),
      );

      expect(() async => await datasource.finishShoppingList(testList),
          throwsA(isA<FirebaseException>()));
      verify(
        () => mockDio.delete('/shopping-lists/id.json'),
      ).called(1);
    });
  });
}
