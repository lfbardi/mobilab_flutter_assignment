import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';
import '../../home/data/models/shopping_list.dart';

abstract class ShoppingListDetailsRemoteDatasource {
  Future<bool> updateShoppingList(ShoppingList shoppingList);
  Future<bool> finishShoppingList(ShoppingList shoppingList);
}

class ShoppingListDetailsRemoteDatasourceImpl
    implements ShoppingListDetailsRemoteDatasource {
  final Dio dio;

  ShoppingListDetailsRemoteDatasourceImpl({required this.dio});

  @override
  Future<bool> updateShoppingList(ShoppingList shoppingList) async {
    try {
      final response = await dio.patch(
        '/shopping-lists/${shoppingList.id}.json',
        data: shoppingList.toMap(),
      );

      if (response.statusCode != 200) {
        throw FirebaseException(message: 'Failed to update shopping list');
      } else {
        return true;
      }
    } catch (e) {
      throw FirebaseException(message: 'Failed to update shopping list');
    }
  }

  @override
  Future<bool> finishShoppingList(ShoppingList shoppingList) async {
    try {
      final response = await dio.delete(
        '/shopping-lists/${shoppingList.id}.json',
      );

      if (response.statusCode != 200) {
        throw FirebaseException(message: 'Failed to finish shopping list');
      } else {
        return true;
      }
    } catch (e) {
      throw FirebaseException(message: 'Failed to finish shopping list');
    }
  }
}
