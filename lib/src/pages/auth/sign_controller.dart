import 'package:flutter/foundation.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AuthState { idle, success, error, loading, isLogged, isLogout }

class SignController extends ChangeNotifier {
  String domain = dotenv.get('AUTH0_DOMAIN');
  String clientId = dotenv.get('AUTH0_CLIENTE_ID');

  Auth0? auth0Mobile;
  Auth0Web? auth0Web;

  var state = AuthState.idle;

  Credentials? user;

  Future<void> initializeAuth0Mobile() async {
    auth0Mobile = Auth0(domain, clientId);
  }

  Future<void> initializeAuth0Web() async {
    auth0Web = Auth0Web(domain, clientId);
  }

  Future<void> onLoginMobile() async {
    if (auth0Mobile == null) {
      await initializeAuth0Mobile();
    }

    state = AuthState.loading;
    notifyListeners();

    try {
      await auth0Mobile!.webAuthentication(scheme: 'greengrocer').login();

      await getUserCredentials();
      state = AuthState.isLogged;
      notifyListeners();
    } catch (e) {
      state = AuthState.error;
      notifyListeners();
    }
  }

  Future<void> isLogged() async {
    if (auth0Mobile == null) {
      await initializeAuth0Mobile();
    }

    state = AuthState.loading;
    notifyListeners();

    final isLogged = kIsWeb
        ? await auth0Web?.hasValidCredentials()
        : await auth0Mobile?.credentialsManager.hasValidCredentials();

    if (isLogged == true) {
      state = AuthState.isLogged;

      await getUserCredentials();

      notifyListeners();
    } else {
      state = AuthState.error;
      notifyListeners();
    }
  }

  Future<Credentials> getUserCredentials() async {
    if (auth0Mobile == null) {
      await initializeAuth0Mobile();
    }

    final credentials = await auth0Mobile!.credentialsManager.credentials();

    user = credentials;

    return credentials;
  }

  Future<void> onLogoutMobile() async {
    if (auth0Mobile == null) {
      await initializeAuth0Mobile();
    }

    state = AuthState.loading;
    notifyListeners();

    try {
      await auth0Mobile!.webAuthentication(scheme: 'greengrocer').logout();
      state = AuthState.isLogout;
      notifyListeners();
    } catch (e) {
      state = AuthState.error;
      notifyListeners();
    }
  }

  Future<void> onLoginWeb() async {
    if (auth0Web == null) {
      await initializeAuth0Web();
    }

    state = AuthState.loading;
    notifyListeners();

    try {
      auth0Web!.loginWithRedirect(redirectUrl: 'http://localhost:3000');
      state = AuthState.success;
      notifyListeners();
    } catch (e) {
      state = AuthState.error;
      notifyListeners();
    }
  }

  Future<void> onLogoutWeb() async {
    if (auth0Web == null) {
      await initializeAuth0Web();
    }

    state = AuthState.loading;
    notifyListeners();

    try {
      await auth0Web!.logout();
      state = AuthState.success;
      notifyListeners();
    } catch (e) {
      state = AuthState.error;
      notifyListeners();
    }
  }
}
