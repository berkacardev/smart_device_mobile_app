import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_device_mobile_app/product/helpers/time_stamp_convertor.dart';
import 'package:smart_device_mobile_app/product/models/telemetry_data/telemetry_data.dart';

part 'telemetry_data_response.g.dart';
@immutable
@JsonSerializable()
class TelemetryDataResponse extends Equatable {
  final double? distance;
  final double? humidity;
  final double? temperature;
  final double? gas;
  final double? weight;
  final double? percent_fullness_by_distance;
  final double? percent_fullness_by_weight;
  @TimestampConverter()
  final DateTime? data_time;

  const TelemetryDataResponse(
      {this.distance,
        this.humidity,
        this.temperature,
        this.gas,
        this.weight,
        this.percent_fullness_by_distance,
        this.percent_fullness_by_weight,
        this.data_time});

  TelemetryDataResponse copyWith({
    double? distance,
    double? humidity,
    double? temperature,
    double? gas,
    double? weight,
    double? percentFullnessByDistance,
    double? percentFullnessByWeight,
    DateTime? dataTime,
  }) {
    return TelemetryDataResponse(
      distance: distance ?? this.distance,
      humidity: humidity ?? this.humidity,
      temperature: temperature ?? this.temperature,
      gas: gas ?? this.gas,
      weight: weight ?? this.weight,
      percent_fullness_by_distance: percentFullnessByDistance ?? this.percent_fullness_by_distance,
      percent_fullness_by_weight: percentFullnessByWeight ?? this.percent_fullness_by_weight,
      data_time: dataTime ?? this.data_time,
    );
  }

  @override
  List<Object?> get props =>
      [distance, humidity, temperature, gas, weight, percent_fullness_by_distance, percent_fullness_by_weight, data_time];

  Map<String, dynamic> toJson() {
    return _$TelemetryDataResponseToJson(this);
  }

  factory TelemetryDataResponse.fromJson(Map<String, dynamic> json) {
    return _$TelemetryDataResponseFromJson(json);
  }

  TelemetryData convertToTelemetryData() {
    return TelemetryData(
        distance: distance,
        humidity: humidity,
        temperature: temperature,
        gas: gas,
        weight: weight,
        percentFullnessByDistance: percent_fullness_by_distance,
        percentFullnessByWeight: percent_fullness_by_weight,
        dataTime: data_time);
  }
}
