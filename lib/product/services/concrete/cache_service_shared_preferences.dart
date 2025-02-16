import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_device_mobile_app/product/exceptions/device_already_exists_exception.dart';
import 'package:smart_device_mobile_app/product/services/abstract/cache_service.dart';

class CacheServiceSharedPreferences extends CacheService {
  @override
  Future<List<String>?> getSmartDevicesId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('smart_devices');
  }

  @override
  Future<List<String>?> addSmartDeviceId(String deviceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cachedData = await getSmartDevicesId();
    if (cachedData == null) {
      cachedData = [];
      cachedData.add(deviceId);
    } else {
      if (cachedData.where((element) => element == deviceId).isNotEmpty) {
        throw DeviceAlreadyExistsException();
      }
      cachedData.add(deviceId);
    }
    await prefs.setStringList('smart_devices', cachedData);
    return Future.value(cachedData);
  }

  @override
  Future<bool> deleteSmartDevice(String deviceId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? cachedData = await getSmartDevicesId();
      if (cachedData == null) {
        cachedData = [];
      } else {
        int savedCount = cachedData.where((element) => element == deviceId).length;
        for (int i = 0; i < savedCount; i++) {
          cachedData.removeWhere((element) => element == deviceId);
        }
      }
      await prefs.setStringList('smart_devices', cachedData);
      return true;
    } catch (e) {
      return false;
    }
  }
}
