import 'dart:async';

import 'package:get_it/get_it.dart';

class Inject {
  Inject._();

  static T find<T extends Object>() {
    final getIt = GetIt.instance;
    return getIt.get<T>();
  }

  static void lazyPut<T extends Object>(T Function() callback) {
    GetIt.instance.registerLazySingleton<T>(callback);
  }

  static void put<T extends Object>(T object) {
    GetIt.instance.registerSingleton<T>(object);
  }

  static void remove<T extends Object>({
    required FutureOr<dynamic> Function(T)? disposeFunction,
  }) {
    GetIt.I.unregister<T>(disposingFunction: disposeFunction);
  }

  static bool exists<T extends Object>() {
    return GetIt.I.isRegistered<T>();
  }
}
