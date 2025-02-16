import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

abstract class GlobalConstants {

  static const DEFAULT_DEVICE_ID = "dxxiCl298q4x1wSSBNMv";

  static  List<GaugeRange> TEMPERATURE_GAUGE_RANGE_1 = [
    GaugeRange(startValue: 0,
        endValue: 28,
        color: Colors.green,
        startWidth: 10,
        endWidth: 10),
    GaugeRange(startValue: 28,
        endValue: 45,
        color: Colors.orange,
        startWidth: 10,
        endWidth: 10),
    GaugeRange(startValue: 45,
        endValue: 60,
        color: Colors.red,
        startWidth: 10,
        endWidth: 10),
  ];
  static  List<GaugeRange> GAS_GAUGE_RANGE_1 = [
    GaugeRange(startValue: 0,
        endValue: 500,
        color: Colors.green,
        startWidth: 10,
        endWidth: 10),
    GaugeRange(startValue: 500,
        endValue: 900,
        color: Colors.orange,
        startWidth: 10,
        endWidth: 10),
    GaugeRange(startValue: 900,
        endValue: 3000,
        color: Colors.red,
        startWidth: 10,
        endWidth: 10),
  ];
}