import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_device_mobile_app/product/enums/model_enums/basic_model_status.dart';
import 'package:smart_device_mobile_app/product/initializer/di.dart';
import 'package:smart_device_mobile_app/product/models/smart_device/smart_device.dart';
import 'package:smart_device_mobile_app/product/services/abstract/cache_service.dart';
import 'package:smart_device_mobile_app/product/services/abstract/smart_device_service.dart';

final kSmartDeviceProvider = StateNotifierProvider<SmartDeviceNotifier, SmartDeviceState>((ref) => SmartDeviceNotifier());

class SmartDeviceNotifier extends StateNotifier<SmartDeviceState> {
  SmartDeviceNotifier() : super(SmartDeviceState(basicModelStatus: BasicModelStatus.INITIAL));
  final SmartDeviceService _smartDeviceService = kGetIt.get<SmartDeviceService>();
  final CacheService _cacheService = kGetIt.get<CacheService>();

  Future<void> fetchCachedSmartDevices() async {
    try {
      state = state.copyWith(basicModelStatus: BasicModelStatus.LOADING_DATA);
      List<String>? devicesId = await _cacheService.getSmartDevicesId();
      List<SmartDevice> smartDevices = [];
      if (devicesId != null && devicesId.isNotEmpty) {
        smartDevices = await Future.wait(
          devicesId.map((id) async {
            SmartDevice? device = await _smartDeviceService.get(id);
            return device!; //
          }),
        );
        smartDevices.removeWhere((device) => device == null);
      }

      await Future.delayed(const Duration(seconds: 2));
      state = state.copyWith(
        basicModelStatus: BasicModelStatus.LOADED_DATA,
        smartDevices: smartDevices,
      );
    } catch (e) {
      state = state.copyWith(
        basicModelStatus: BasicModelStatus.ON_EXCEPTION,
        exception: Exception(e),
      );
    }
  }

  Future<void> addSmartDevice(String id) async {
    try {
      if (id.isEmpty) {
        id = " ";
      }
      SmartDevice? smartDevice = await _smartDeviceService.get(id);
      await _cacheService.addSmartDeviceId(id);
      var smartDevices = state.smartDevices ?? [];
      smartDevices.add(smartDevice!);

      state = state.copyWith(basicModelStatus: BasicModelStatus.CLOSE_NAVIGATOR);
      state = state.copyWith(basicModelStatus: BasicModelStatus.SUCCESSFUL);
      state = state.copyWith(basicModelStatus: BasicModelStatus.LOADED_DATA, smartDevices: smartDevices);
      return;
    } catch (e) {
      state = state.copyWith(basicModelStatus: BasicModelStatus.ON_EXCEPTION, exception: Exception(e));
    }
  }

  Future<void> deleteSmartDevice(String id) async {
    try {
      var res = await _cacheService.deleteSmartDevice(id);
      if (res) {
        var smartDevices = state.smartDevices ?? [];
        smartDevices.removeWhere((element) => element.deviceId == id);
        state = state.copyWith(basicModelStatus: BasicModelStatus.LOADED_DATA, smartDevices: smartDevices);
      }
    } catch (e) {
      state = state.copyWith(basicModelStatus: BasicModelStatus.ON_EXCEPTION, exception: Exception(e));
    }
  }
}

class SmartDeviceState extends Equatable {
  final BasicModelStatus basicModelStatus;
  final Exception? exception;
  final List<SmartDevice>? smartDevices;

  @override
  List<Object?> get props => [basicModelStatus, exception, smartDevices];

  const SmartDeviceState({required this.basicModelStatus, this.exception, this.smartDevices});

  SmartDeviceState copyWith({
    BasicModelStatus? basicModelStatus,
    Exception? exception,
    List<SmartDevice>? smartDevices,
  }) {
    return SmartDeviceState(
      basicModelStatus: basicModelStatus ?? this.basicModelStatus,
      exception: exception ?? this.exception,
      smartDevices: smartDevices ?? this.smartDevices,
    );
  }
}
