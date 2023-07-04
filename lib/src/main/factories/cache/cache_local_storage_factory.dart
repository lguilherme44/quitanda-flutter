import '../../../data/cache/local_storage.dart';
import '../../../infra/cache/local_storage_adater.dart';
import '../../singletons/local_storage_singleton.dart';

CacheLocalStorage makeLocalStorage() => LocalStorageAdapter(
      localStorage: LocalStorage.instance.preferences,
    );
