import 'package:get_it/get_it.dart';
import 'package:smart_device_mobile_app/product/services/abstract/cache_service.dart';
import 'package:smart_device_mobile_app/product/services/abstract/smart_device_service.dart';
import 'package:smart_device_mobile_app/product/services/abstract/telemetry_data_service.dart';
import 'package:smart_device_mobile_app/product/services/concrete/cache_service_shared_preferences.dart';
import 'package:smart_device_mobile_app/product/services/concrete/smart_device_service_firebase.dart';
import 'package:smart_device_mobile_app/product/services/concrete/telemetry_data_service_firebase.dart';

final kGetIt = GetIt.instance;

abstract class DependencyInjection {
  static void initializeDependencies() {
    kGetIt.registerSingleton<SmartDeviceService>(SmartDeviceServiceFirebase(), signalsReady: true);
    kGetIt.registerSingleton<TelemetryDataService>(TelemetryDataServiceFirebase(), signalsReady: true);
    kGetIt.registerSingleton<CacheService>(CacheServiceSharedPreferences(), signalsReady: true);
  }
}
