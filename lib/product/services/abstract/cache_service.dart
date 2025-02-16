abstract class CacheService{
  Future<List<String>?> getSmartDevicesId();
  Future<List<String>?> addSmartDeviceId(String deviceId);
  Future<bool> deleteSmartDevice(String deviceId);
}