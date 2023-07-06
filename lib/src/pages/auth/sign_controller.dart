import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AuthState { idle, success, error, loading }

class SignController extends ChangeNotifier {
  String domain = dotenv.get('AUTH0_DOMAIN');
  String clientId = dotenv.get('AUTH0_CLIENTE_ID');

  Auth0? auth0;

  var state = AuthState.idle;

  Future<void> initializeAuth0() async {
    auth0 = Auth0(domain, clientId);
  }

  Future<void> onLogin() async {
    if (auth0 == null) {
      await initializeAuth0();
    }

    state = AuthState.loading;
    notifyListeners();

    final isSuccessLogin =
        await auth0!.webAuthentication(scheme: 'greengrocer').login();

    if (isSuccessLogin.accessToken != null) {
      state = AuthState.success;
      notifyListeners();
    } else {
      state = AuthState.error;
      notifyListeners();
    }
  }

  Future<void> onLogout() async {
    if (auth0 == null) {
      await initializeAuth0();
    }

    state = AuthState.loading;
    notifyListeners();

    try {
      await auth0!.webAuthentication(scheme: 'greengrocer').logout();
      state = AuthState.success;
      notifyListeners();
    } catch (e) {
      state = AuthState.error;
      notifyListeners();
    }
  }
}
