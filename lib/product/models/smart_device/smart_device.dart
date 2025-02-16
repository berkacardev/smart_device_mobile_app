import 'package:equatable/equatable.dart';

class SmartDevice extends Equatable {
  final String? deviceId;
  final int? deviceType;
  final double? weightCapacity;
  final double? distanceCapacity;
  final double? humidityCapacity;
  final double? temperatureCapacity;
  final double? gasCapacity;
  final double? gasCriticalLevel;

  const SmartDevice(
      {this.deviceId,
      this.deviceType,
      this.weightCapacity,
      this.distanceCapacity,
      this.humidityCapacity,
      this.temperatureCapacity,
      this.gasCapacity,
      this.gasCriticalLevel});

  @override
  List<Object?> get props => [deviceId, deviceType, weightCapacity, distanceCapacity, humidityCapacity, gasCriticalLevel];
}
