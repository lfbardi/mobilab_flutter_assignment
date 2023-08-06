import 'package:dartz/dartz.dart';
import 'package:mobilab_flutter_assignment/features/shopping_list_details/data/shopping_list_details_remote_datasource.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../home/data/models/shopping_list.dart';

abstract class ShoppingListDetailsRepository {
  Future<Either<Failure, bool>> updateShoppingList({
    required ShoppingList shoppingList,
  });

  Future<Either<Failure, bool>> finishShoppingList({
    required ShoppingList shoppingList,
  });
}

class ShoppingListDetailsRepositoryImpl
    implements ShoppingListDetailsRepository {
  final ShoppingListDetailsRemoteDatasource datasource;

  ShoppingListDetailsRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<Failure, bool>> updateShoppingList({
    required ShoppingList shoppingList,
  }) async {
    try {
      final updateShoppingListResponse =
          await datasource.updateShoppingList(shoppingList);
      return Right(updateShoppingListResponse);
    } on FirebaseException catch (e) {
      return Left(
        FirebaseFailure(e.message),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> finishShoppingList({
    required ShoppingList shoppingList,
  }) async {
    try {
      final finishShoppingListResponse =
          await datasource.finishShoppingList(shoppingList);
      return Right(finishShoppingListResponse);
    } on FirebaseException catch (e) {
      return Left(
        FirebaseFailure(e.message),
      );
    }
  }
}
