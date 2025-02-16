import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_device_mobile_app/feature/viewmodel/smart_device_notifier.dart';
import 'package:smart_device_mobile_app/feature/viewmodel/telemetry_data_notifier.dart';
import 'package:smart_device_mobile_app/product/constants/global_constants.dart';
import 'package:smart_device_mobile_app/product/constants/lang/local_keys_tr.dart';
import 'package:smart_device_mobile_app/product/constants/units.dart';
import 'package:smart_device_mobile_app/product/enums/model_enums/action_status.dart';
import 'package:smart_device_mobile_app/product/enums/model_enums/basic_model_status.dart';
import 'package:smart_device_mobile_app/product/helpers/helper.dart';
import 'package:smart_device_mobile_app/product/models/smart_device/smart_device.dart';
import 'package:smart_device_mobile_app/product/widgets/buttons/custom_action_button.dart';
import 'package:smart_device_mobile_app/product/widgets/cards/custom_title_info_card.dart';
import 'package:smart_device_mobile_app/product/widgets/gauges/custom_dashed_circular_progress_bar.dart';
import 'package:smart_device_mobile_app/product/widgets/gauges/custom_radial_gauge.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SmartDevicePageView extends ConsumerStatefulWidget {
  final SmartDevice smartDevice;

  const SmartDevicePageView({super.key, required this.smartDevice});

  @override
  ConsumerState createState() => _SmartDevicePageViewState();
}

class _SmartDevicePageViewState extends ConsumerState<SmartDevicePageView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(kTelemetryDataProvider.notifier).listenForTelemetryData(widget.smartDevice.deviceId!);
    });
    _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<TelemetryDataState>(kTelemetryDataProvider, (previous, next) {
      if (next.basicModelStatus == BasicModelStatus.ON_EXCEPTION && next.exception != null) {
        showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message: next.exception.toString()));
      }
      if (next.actionStatus == ActionStatus.RUN_GINDER) {
        showTopSnackBar(Overlay.of(context), CustomSnackBar.success(message: LocalKeysTr.GRINDER_IS_SUCCESFULLY_RUNNING));
      }
      if (next.actionStatus == ActionStatus.GIVE_WARNING_SOUND) {
        showTopSnackBar(Overlay.of(context), CustomSnackBar.success(message: LocalKeysTr.WARNING_SOUND_IS_SUCCESFULLY_GIVING));
      }
    });
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text(LocalKeysTr.MY_SMART_DUSTBIN, style: TextStyle(color: Colors.black))],
        ),
        actions: [
          IconButton(
              onPressed: () {
                _showCustomDeleteConfirmDialog(
                    context: context,
                    onConfirm: () {
                      ref.read(kSmartDeviceProvider.notifier).deleteSmartDevice(widget.smartDevice.deviceId ?? "");
                      Navigator.of(context).pop();
                    });
              },
              icon: Icon(Icons.delete_forever, color: Colors.black))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffD5E0EB), Color(0xffececec)],
            stops: [0.1, 0.90],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 80, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildLastUpdatedCard(),
              _buildSmartDeviceStatusCard(),
              SizedBox(height: 15),
              _buildTemperatureAndGasCards(),
              SizedBox(height: 5),
              _buildHumidityAndFullnessCards(),
              SizedBox(height: 20),
              CustomActionButton(
                  onClicked: () {
                    ref.read(kTelemetryDataProvider.notifier).giveWarningSound(widget.smartDevice.deviceId ?? "");
                  },
                  icon: Icons.warning,
                  label: LocalKeysTr.GIVE_LONG_WARNING_TONE),
              SizedBox(height: 12),
              CustomActionButton(
                onClicked: () {
                  ref.read(kTelemetryDataProvider.notifier).runGrinder(widget.smartDevice.deviceId ?? "");
                },
                icon: Icons.play_circle,
                label: LocalKeysTr.RUN_THE_GARBAGE_DISOPOSAL,
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showCustomDeleteConfirmDialog({
    required BuildContext context,
    String title = LocalKeysTr.WARNING,
    String cancelButtonText = LocalKeysTr.CANCEL,
    String confirmButtonText = LocalKeysTr.CONFIRM,
    String message = LocalKeysTr.ARE_YOU_SURE_YOU_WANT_TO_DELETE,
    required Function onConfirm,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      barrierColor: Colors.black54,
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 300,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(message),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(cancelButtonText),
                      ),
                      TextButton(
                        onPressed: () {
                          onConfirm();
                          Navigator.of(context).pop();
                        },
                        child: Text(confirmButtonText),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  Widget _buildLastUpdatedCard() {
    String lastUpdateTitle = "${LocalKeysTr.LAST_UPDATE} ";
    if (ref.watch(kTelemetryDataProvider).telemetryData != null) {
      DateTime? dataTime = ref.watch(kTelemetryDataProvider).telemetryData?[widget.smartDevice.deviceId]?.dataTime;
      lastUpdateTitle += dataTime == null ? "${LocalKeysTr.ERROR}." : "${Helper.getTimeAgo(dataTime)}.";
    }
    return CustomTitleInfoCard(icon: Icon(Icons.info, color: Colors.white, size: 27), infoTitle: lastUpdateTitle);
  }

  Widget _buildTemperatureAndGasCards() {
    double gas = ref.watch(kTelemetryDataProvider).telemetryData?[widget.smartDevice.deviceId]?.gas ?? 0;
    double temperature = ref.watch(kTelemetryDataProvider).telemetryData?[widget.smartDevice.deviceId]?.temperature ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomRadialGauge(
            title: LocalKeysTr.TEMPERATURE,
            unit: Units.CELSIUS_DEGREE,
            value: temperature,
            minLimit: 0,
            maxLimit: widget.smartDevice.temperatureCapacity ?? 0,
            ranges: GlobalConstants.TEMPERATURE_GAUGE_RANGE_1),
        SizedBox(width: 10),
        CustomRadialGauge(
          title: LocalKeysTr.GAS,
          value: gas,
          minLimit: 0,
          maxLimit: widget.smartDevice.gasCapacity ?? 0,
          ranges: GlobalConstants.GAS_GAUGE_RANGE_1,
        )
      ],
    );
  }

  Widget _buildHumidityAndFullnessCards() {
    double distanceFullness = ref.watch(kTelemetryDataProvider).telemetryData?[widget.smartDevice.deviceId]?.distance ?? 0;
    double weightFullness = ref.watch(kTelemetryDataProvider).telemetryData?[widget.smartDevice.deviceId]?.weight ?? 0;
    double humidity = ref.watch(kTelemetryDataProvider).telemetryData?[widget.smartDevice.deviceId]?.humidity ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomDashedCircularProgressBar(
          title: LocalKeysTr.FILLING_BY_WEIGHT,
          unit: Units.KILOGRAM,
          value: weightFullness,
          maxValue: widget.smartDevice.weightCapacity,
        ),
        SizedBox(width: 6),
        CustomDashedCircularProgressBar(
          title: LocalKeysTr.FILLING_BY_DISTANCE,
          unit: Units.METER,
          value: distanceFullness,
          maxValue: widget.smartDevice.distanceCapacity,
          reversePercentCalculation: true,
        ),
        SizedBox(width: 6),
        CustomDashedCircularProgressBar(
          title: LocalKeysTr.HUMIDITY,
          unit: Units.PERCENT,
          value: humidity,
          maxValue: widget.smartDevice.humidityCapacity,
        ),
      ],
    );
  }

  Color _color = Colors.red;
  bool _isRed = true;

  void _startAnimation() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _color = _isRed ? Colors.red : Color(0xffC60000);
        _isRed = !_isRed;
      });
    });
  }

  Widget _buildSmartDeviceStatusCard() {
    double gas = ref.watch(kTelemetryDataProvider).telemetryData?[widget.smartDevice.deviceId]?.gas ?? 0;
    String statusMessage = "";
    if (gas > (widget.smartDevice.gasCriticalLevel ?? 0)) {
      statusMessage = LocalKeysTr.THERE_ARE_HIGH_METAN_GAS_PROBLEM_IN_YOUR_DEVICE;
      return AnimatedContainer(
        duration: Duration(milliseconds: 1500),
        curve: Curves.easeInOut,
        child: CustomTitleInfoCard(
          icon: Icon(Icons.flag, color: Colors.white, size: 27),
          infoTitle: statusMessage,
          color: _color,
        ),
      );
    } else {
      statusMessage = LocalKeysTr.EVERYTHING_IS_NORMAL_YOUR_DEVICE;
      return CustomTitleInfoCard(
        icon: Icon(Icons.flag, color: Colors.white, size: 27),
        infoTitle: statusMessage,
        color: Colors.orange,
      );
    }
  }

  Future<void> customShowDialog(BuildContext context, Function onDelete) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Silme İşlemi'),
          content: Text('Silmek istediğinize emin misiniz?'),
          actions: <Widget>[
            TextButton(
              child: Text('Hayır'),
              onPressed: () {
                Navigator.of(context).pop(); // Dialogu kapat
              },
            ),
            TextButton(
              child: Text('Evet'),
              onPressed: () {
                onDelete(); // Silme işlemini gerçekleştir
                Navigator.of(context).pop(); // Dialogu kapat
              },
            ),
          ],
        );
      },
    );
  }
}
