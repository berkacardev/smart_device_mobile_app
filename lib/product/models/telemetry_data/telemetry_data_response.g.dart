// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telemetry_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TelemetryDataResponse _$TelemetryDataResponseFromJson(
        Map<String, dynamic> json) =>
    TelemetryDataResponse(
      distance: (json['distance'] as num?)?.toDouble(),
      humidity: (json['humidity'] as num?)?.toDouble(),
      temperature: (json['temperature'] as num?)?.toDouble(),
      gas: (json['gas'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      percent_fullness_by_distance:
          (json['percent_fullness_by_distance'] as num?)?.toDouble(),
      percent_fullness_by_weight:
          (json['percent_fullness_by_weight'] as num?)?.toDouble(),
      data_time: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['data_time'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$TelemetryDataResponseToJson(
        TelemetryDataResponse instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'humidity': instance.humidity,
      'temperature': instance.temperature,
      'gas': instance.gas,
      'weight': instance.weight,
      'percent_fullness_by_distance': instance.percent_fullness_by_distance,
      'percent_fullness_by_weight': instance.percent_fullness_by_weight,
      'data_time': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.data_time, const TimestampConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
