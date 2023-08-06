import 'package:dio/dio.dart';
import 'package:mobilab_flutter_assignment/features/home/data/models/shopping_list.dart';

import '../../../core/error/exceptions.dart';

abstract class HomeRemoteDatasource {
  Future<List<ShoppingList>> getAllShoppingLists();
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final Dio dio;

  HomeRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<ShoppingList>> getAllShoppingLists() async {
    try {
      final response = await dio.get('/shopping-lists.json');

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        final List<ShoppingList> shoppingLists = data.entries.map((entry) {
          final id = entry.key;
          final map = entry.value as Map<String, dynamic>;
          return ShoppingList.fromMap(id, map);
        }).toList();
        return shoppingLists;
      } else if (response.statusCode == 200 && response.data == null) {
        return [];
      } else {
        throw FirebaseException(message: 'Error getting Shopping Lists');
      }
    } catch (e) {
      throw FirebaseException(message: 'Error getting Shopping Lists');
    }
  }
}
