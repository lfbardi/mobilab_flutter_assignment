import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import '../../../core/error/exceptions.dart';
import '../../home/data/models/shopping_item.dart';

abstract class CreateShoppingListRemoteDatasource {
  Future<bool> createShoppingList({
    required String title,
    required List<ShoppingItem> items,
  });
}

class CreateShoppingListRemoteDatasourceImpl
    implements CreateShoppingListRemoteDatasource {
  final Dio dio;

  CreateShoppingListRemoteDatasourceImpl({required this.dio});

  @override
  Future<bool> createShoppingList({
    required String title,
    required List<ShoppingItem> items,
  }) async {
    try {
      final response = await dio.post(
        '/shopping-lists.json',
        data: jsonEncode(
          {
            'id': const Uuid().v4(),
            'title': title,
            'items': items.map((e) => e.toMap()).toList(),
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        throw FirebaseException(message: 'Error getting Shopping Lists');
      }
    } catch (e) {
      throw FirebaseException(message: 'Error getting Shopping Lists');
    }
  }
}
