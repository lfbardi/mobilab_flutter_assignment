import 'package:dartz/dartz.dart';
import 'package:mobilab_flutter_assignment/features/home/data/home_remote_datasource.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import 'models/shopping_list.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<ShoppingList>>> getAllShoppingLists();
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource datasource;

  HomeRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<Failure, List<ShoppingList>>> getAllShoppingLists() async {
    try {
      final getAllShoppingListsResponse =
          await datasource.getAllShoppingLists();
      return Right(getAllShoppingListsResponse);
    } on FirebaseException catch (e) {
      return Left(
        FirebaseFailure(e.message),
      );
    }
  }
}
