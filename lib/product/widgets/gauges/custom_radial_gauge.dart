import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CustomRadialGauge extends StatelessWidget {
  final String title;
  final String unit;
  final double value;
  final double minLimit;
  final double maxLimit;
  List<GaugeRange> ranges;

  CustomRadialGauge(
      {super.key,
      required this.title,
      this.unit = "",
      required this.value,
      required this.minLimit,
      required this.maxLimit,
      required this.ranges});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffF6F6F6),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 9,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                height: 200,
                child: SfRadialGauge(
                  axes: [
                    RadialAxis(
                      minimum: minLimit,
                      maximum: maxLimit,
                      ranges: ranges,
                      annotations: [
                        GaugeAnnotation(
                          widget: Container(
                            margin: EdgeInsets.only(top: 130),
                            child: Text(
                              "${double.parse(value.toStringAsFixed(2))} $unit",
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ],
                      pointers: [NeedlePointer(value: value)],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
