import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobilab_flutter_assignment/core/error/exceptions.dart';
import 'package:mobilab_flutter_assignment/features/home/data/home_remote_datasource.dart';
import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_item.dart';
import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_list.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late HomeRemoteDatasource datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = HomeRemoteDatasourceImpl(dio: mockDio);
  });

  group('Home Datasource', () {
    const String title = 'Test Shopping List';
    final List<ShoppingItem> items = [
      ShoppingItem(title: 'Rice', isChecked: true),
      ShoppingItem(title: 'Meat', isChecked: true),
    ];

    test('should get all ShoppingLists successfully', () async {
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: {
            'list': {
              'title': title,
              'items': items.map((item) => item.toMap()).toList(),
            },
          },
        ),
      );

      final result = await datasource.getAllShoppingLists();

      expect(result, isA<List<ShoppingList>>());
      verify(() => mockDio.get('/shopping-lists.json'));
    });

    test('should throw FirebaseException on unsuccessful response', () async {
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
        ),
      );

      final call = datasource.getAllShoppingLists();

      expect(call, throwsA(isA<FirebaseException>()));
      verify(() => mockDio.get('/shopping-lists.json'));
    });
  });
}
