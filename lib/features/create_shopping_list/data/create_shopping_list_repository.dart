import 'package:dartz/dartz.dart';
import 'package:mobilab_flutter_assignment/features/create_shopping_list/data/create_shopping_list_remote_datasource.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../home/data/models/shopping_item.dart';

abstract class CreateShoppingListRepository {
  Future<Either<Failure, bool>> createShoppingList({
    required String title,
    required List<ShoppingItem> items,
  });
}

class CreateShoppingListRepositoryImpl implements CreateShoppingListRepository {
  final CreateShoppingListRemoteDatasource datasource;

  CreateShoppingListRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<Failure, bool>> createShoppingList({
    required String title,
    required List<ShoppingItem> items,
  }) async {
    try {
      final creteShoppingListResponse =
          await datasource.createShoppingList(title: title, items: items);
      return Right(creteShoppingListResponse);
    } on FirebaseException catch (e) {
      return Left(
        FirebaseFailure(e.message),
      );
    }
  }
}
