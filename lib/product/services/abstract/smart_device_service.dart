import 'package:smart_device_mobile_app/product/models/smart_device/smart_device.dart';

abstract class SmartDeviceService{
  Future<List<SmartDevice>?> getAll();
  Future<SmartDevice?> get(String id);
}