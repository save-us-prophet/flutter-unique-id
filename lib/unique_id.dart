import 'unique_id_platform_interface.dart';

class UniqueId {
  Future<String?> getPlatformVersion() {
    return UniqueIdPlatform.instance.getPlatformVersion();
  }

  Future<String?> getUniqueId() {
    return UniqueIdPlatform.instance.getUniqueId();
  }
}
