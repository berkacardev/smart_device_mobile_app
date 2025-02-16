// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_device_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmartDeviceResponse _$SmartDeviceResponseFromJson(Map<String, dynamic> json) =>
    SmartDeviceResponse(
      weight_capacity: (json['weight_capacity'] as num?)?.toDouble(),
      distance_capacity: (json['distance_capacity'] as num?)?.toDouble(),
      device_id: json['device_id'] as String?,
      device_type: (json['device_type'] as num?)?.toInt(),
      humidity_capacity: (json['humidity_capacity'] as num?)?.toDouble(),
      temperature_capacity: (json['temperature_capacity'] as num?)?.toDouble(),
      gas_capacity: (json['gas_capacity'] as num?)?.toDouble(),
      gas_critical_level: (json['gas_critical_level'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SmartDeviceResponseToJson(
        SmartDeviceResponse instance) =>
    <String, dynamic>{
      'device_id': instance.device_id,
      'device_type': instance.device_type,
      'weight_capacity': instance.weight_capacity,
      'distance_capacity': instance.distance_capacity,
      'humidity_capacity': instance.humidity_capacity,
      'temperature_capacity': instance.temperature_capacity,
      'gas_capacity': instance.gas_capacity,
      'gas_critical_level': instance.gas_critical_level,
    };
