import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';

class CustomDashedCircularProgressBar extends StatelessWidget {
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  final String title;
  final double? maxValue;
  final double? value;
  final String unit;
  final bool reversePercentCalculation;

  CustomDashedCircularProgressBar(
      {super.key, required this.title, required this.maxValue, required this.value, required this.unit, this.reversePercentCalculation = false});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        height: 190,
        padding: EdgeInsets.symmetric(horizontal: 9, vertical: 6),
        margin: EdgeInsets.only(top: 12, bottom: 6),
        decoration: BoxDecoration(
          color: Color(0xffF6F6F6),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(title, textAlign: TextAlign.center),
            SizedBox(height: 10),
            DashedCircularProgressBar.aspectRatio(
              aspectRatio: 1,
              // width ÷ height
              valueNotifier: _valueNotifier,
              progress: reversePercentCalculation == true ? (100-((value ?? 0) / (maxValue ?? 1)) * 100) : (((value ?? 0) / (maxValue ?? 1)) * 100),
              startAngle: 225,
              sweepAngle: 270,
              foregroundColor: Colors.green,
              backgroundColor: const Color(0xffeeeeee),
              foregroundStrokeWidth: 8,
              backgroundStrokeWidth: 6,
              animation: true,
              seekSize: 6,
              seekColor: const Color(0xffeeeeee),
              child: Center(
                child: ValueListenableBuilder(
                    valueListenable: _valueNotifier,
                    builder: (_, double value, __) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${value.toInt()}%',
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 20),
                            ),
                          ],
                        )),
              ),
            ),
            Text( "${value!.toStringAsFixed(2)}/${maxValue!.toStringAsFixed(2)}$unit", textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
