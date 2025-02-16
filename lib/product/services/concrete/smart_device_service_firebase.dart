import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_device_mobile_app/product/initializer/package_initializer.dart';
import 'package:smart_device_mobile_app/product/models/smart_device/smart_device.dart';
import 'package:smart_device_mobile_app/product/models/smart_device/smart_device_response.dart';
import 'package:smart_device_mobile_app/product/services/abstract/smart_device_service.dart';

class SmartDeviceServiceFirebase implements SmartDeviceService {
  late final List<DocumentSnapshot>? _documentList;

  @override
  Future<List<SmartDevice>?> getAll() async {
    try {
      var res = await PackageInitializer.firebaseFirestoreInstance.collection('smart_devices').get();
      _documentList = res.docs;
      return _documentList!
          .map((e) => SmartDeviceResponse.fromJson(e.data() as Map<String, dynamic>).convertToSmartDevice())
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SmartDevice?> get(String id) async {
    try {
      var res = await PackageInitializer.firebaseFirestoreInstance.collection('smart_devices').doc(id).get();
      if (res.exists) {
        return SmartDeviceResponse.fromJson(res.data() as Map<String, dynamic>).convertToSmartDevice();
      } else {
        throw Exception("Akıllı Cihaz Bulunamadı");
      }
    } catch (e) {
      rethrow;
    }
  }
}
