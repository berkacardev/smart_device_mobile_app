import 'package:smart_device_mobile_app/product/constants/lang/local_keys_tr.dart';

class DeviceAlreadyExistsException implements Exception {
  @override
  String toString() => LocalKeysTr.DEVICE_ALREADY_EXISTS;
}
