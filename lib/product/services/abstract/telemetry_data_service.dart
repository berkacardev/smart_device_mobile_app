import 'package:smart_device_mobile_app/product/models/telemetry_data/telemetry_data.dart';

abstract class TelemetryDataService {
  Stream<TelemetryData?> getLastTelemetryData(String deviceId);

  Future<void> changeFlagState(String deviceID, {bool giveWarningSound = false, bool runGrinder = false});
}
