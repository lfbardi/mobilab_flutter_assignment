import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _firebasePath =
    'https://mobilab-flutter-assignment-default-rtdb.europe-west1.firebasedatabase.app';

final firebaseDio = Provider<Dio>(
  ((ref) => Dio(
        BaseOptions(
          baseUrl: _firebasePath,
        ),
      )),
);
