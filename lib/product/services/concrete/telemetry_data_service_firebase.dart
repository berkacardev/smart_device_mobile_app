import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_device_mobile_app/product/initializer/package_initializer.dart';
import 'package:smart_device_mobile_app/product/models/telemetry_data/telemetry_data.dart';
import 'package:smart_device_mobile_app/product/models/telemetry_data/telemetry_data_response.dart';
import 'package:smart_device_mobile_app/product/services/abstract/telemetry_data_service.dart';

class TelemetryDataServiceFirebase extends TelemetryDataService {
  @override
  Stream<TelemetryData?> getLastTelemetryData(String deviceId) {
    try {
      final docRef =
          PackageInitializer.firebaseFirestoreInstance.collection("smart_devices").doc(deviceId).collection("telemetry_data");
      return docRef.snapshots().map((event) {
        if (event.docs.isNotEmpty) {
          var res = TelemetryDataResponse.fromJson(event.docs.last.data());
          return res.convertToTelemetryData();
        } else {
          return null;
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> changeFlagState(String deviceID, {bool giveWarningSound = false, runGrinder = false}) async {
    Map<String,dynamic> flagState = {};
    flagState["give_warning_sound"] = giveWarningSound;
    flagState["run_grinder"] = runGrinder;
    final docRef = PackageInitializer.firebaseFirestoreInstance.collection("smart_devices").doc(deviceID).collection("flags").doc("main_flag").set(flagState,SetOptions(merge: true));
  }
}
