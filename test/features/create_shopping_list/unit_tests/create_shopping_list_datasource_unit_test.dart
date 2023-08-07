import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobilab_flutter_assignment/core/error/exceptions.dart';
import 'package:mobilab_flutter_assignment/features/create_shopping_list/data/create_shopping_list_remote_datasource.dart';
import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_item.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late CreateShoppingListRemoteDatasource datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = CreateShoppingListRemoteDatasourceImpl(dio: mockDio);
  });

  group('CreateShoppingList Datasource', () {
    const String title = 'Test Shopping List';
    final List<ShoppingItem> items = [
      ShoppingItem(title: 'Rice', isChecked: true),
      ShoppingItem(title: 'Meat', isChecked: true),
    ];

    test('should create shopping list successfully', () async {
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      final result =
          await datasource.createShoppingList(title: title, items: items);

      expect(result, true);
      verify(
          () => mockDio.post('/shopping-lists.json', data: any(named: 'data')));
    });

    test('should throw FirebaseException on unsuccessful response', () async {
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
        ),
      );

      final call = datasource.createShoppingList(title: title, items: items);

      expect(call, throwsA(isA<FirebaseException>()));
      verify(
          () => mockDio.post('/shopping-lists.json', data: any(named: 'data')));
    });

    test('should throw FirebaseException on Dio exception', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenThrow(Exception('Error'));

      final call = datasource.createShoppingList(title: title, items: items);

      expect(call, throwsA(isA<FirebaseException>()));
      verify(
          () => mockDio.post('/shopping-lists.json', data: any(named: 'data')));
    });
  });
}
