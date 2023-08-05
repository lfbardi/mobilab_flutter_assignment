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
      return (response.data as List)
          .map((e) => ShoppingList.fromMap(e))
          .toList();
    } catch (e) {
      throw FirebaseException(message: 'Error getting Shopping Lists');
    }
  }
}
