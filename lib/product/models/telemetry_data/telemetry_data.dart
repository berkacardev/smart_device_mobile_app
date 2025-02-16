import 'package:equatable/equatable.dart';

class TelemetryData extends Equatable {
  @override
  List<Object?> get props => [distance, humidity, temperature, gas, weight, percentFullnessByDistance, percentFullnessByWeight, dataTime];

  final double? distance;
  final double? humidity;
  final double? temperature;
  final double? gas;
  final double? weight;
  final double? percentFullnessByDistance;
  final double? percentFullnessByWeight;
  final DateTime? dataTime;

  const TelemetryData(
      {this.distance, this.humidity, this.temperature, this.gas, this.weight, this.percentFullnessByDistance, this.percentFullnessByWeight, this.dataTime});
}
