import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:resonance_client/resonance_client.dart';
import 'package:resonance_flutter/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

part 'auth_service.g.dart';

class AuthService {
  AuthService(this.client);
  final Client client;

  String? get currentUserId => client.auth.authInfo?.authUserId.uuid;
  bool get isAuthenticated => client.auth.isAuthenticated;

  Stream<AuthSuccess?> authStateChanges() {
    return valueListenableToStream<AuthSuccess?>(
      client.auth.authInfoListenable,
    );
  }
}

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) {
  return AuthService(client);
}

@Riverpod(keepAlive: true)
Stream<AuthSuccess?> authStateChanges(Ref ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges();
}

Stream<T> valueListenableToStream<T>(ValueListenable<T> listenable) {
  late final StreamController<T> controller;

  // The listener callback that adds the new value to the stream
  void listener() {
    controller.add(listenable.value);
  }

  controller = StreamController<T>.broadcast(
    onListen: () {
      // Add the initial value when the first listener subscribes (optional)
      // controller.add(listenable.value);
      listenable.addListener(listener);
    },
    onCancel: () {
      listenable.removeListener(listener);
    },
  );

  return controller.stream;
}
