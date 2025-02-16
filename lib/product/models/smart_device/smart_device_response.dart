import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_device_mobile_app/product/models/smart_device/smart_device.dart';

part 'smart_device_response.g.dart';

@JsonSerializable()
@immutable
class SmartDeviceResponse extends Equatable {
  final String? device_id;
  final int? device_type;
  final double? weight_capacity;
  final double? distance_capacity;
  final double? humidity_capacity;
  final double? temperature_capacity;
  final double? gas_capacity;
  final double? gas_critical_level;

  const SmartDeviceResponse(
      {this.weight_capacity,
      this.distance_capacity,
      this.device_id,
      this.device_type,
      this.humidity_capacity,
      this.temperature_capacity,
      this.gas_capacity,
      this.gas_critical_level});

  @override
  List<Object?> get props => [
        device_id,
        device_type,
        weight_capacity,
        distance_capacity,
        humidity_capacity,
        temperature_capacity,
        gas_capacity,
        gas_critical_level
      ];

  Map<String, dynamic> toJson() {
    return _$SmartDeviceResponseToJson(this);
  }

  factory SmartDeviceResponse.fromJson(Map<String, dynamic> json) {
    return _$SmartDeviceResponseFromJson(json);
  }

  SmartDevice convertToSmartDevice() {
    return SmartDevice(
      deviceId: device_id,
      deviceType: device_type,
      distanceCapacity: distance_capacity,
      weightCapacity: weight_capacity,
      humidityCapacity: humidity_capacity,
      temperatureCapacity: temperature_capacity,
      gasCapacity: gas_capacity,
      gasCriticalLevel: gas_critical_level
    );
  }
}
