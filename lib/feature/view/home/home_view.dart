import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_device_mobile_app/feature/view/smart_device_page/smart_device_page_view.dart';
import 'package:smart_device_mobile_app/feature/viewmodel/smart_device_notifier.dart';
import 'package:smart_device_mobile_app/feature/viewmodel/telemetry_data_notifier.dart';
import 'package:smart_device_mobile_app/product/constants/global_constants.dart';
import 'package:smart_device_mobile_app/product/constants/icons/icon_constants.dart';
import 'package:smart_device_mobile_app/product/constants/lang/local_keys_tr.dart';
import 'package:smart_device_mobile_app/product/enums/model_enums/basic_model_status.dart';
import 'package:smart_device_mobile_app/product/extensions/exception_message_extension.dart';
import 'package:smart_device_mobile_app/product/helpers/developer.dart';
import 'package:smart_device_mobile_app/product/models/smart_device/smart_device.dart';
import 'package:smart_device_mobile_app/product/widgets/buttons/custom_add_device_button.dart';
import 'package:smart_device_mobile_app/product/widgets/cards/custom_smart_device_card.dart';
import 'package:smart_device_mobile_app/product/widgets/dividers/custom_divider.dart';
import 'package:smart_device_mobile_app/product/widgets/dropdowns/custom_dropdown_button.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

@RoutePage()
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late final TextEditingController _deviceCodeTextEditingController;

  @override
  void initState() {
    super.initState();
    _deviceCodeTextEditingController = TextEditingController();
    _deviceCodeTextEditingController.text = GlobalConstants.DEFAULT_DEVICE_ID;
    Future.microtask(
      () {
        ref.read(kSmartDeviceProvider.notifier).fetchCachedSmartDevices();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(kSmartDeviceProvider, (previous, next) async {
      Developer.logError(next.basicModelStatus);
      List<SmartDevice>? smartDevices = ref.watch(kSmartDeviceProvider).smartDevices;
      if(next.basicModelStatus == BasicModelStatus.CLOSE_NAVIGATOR){
        Navigator.of(context).pop();
      }
      if(next.basicModelStatus == BasicModelStatus.SUCCESSFUL){
        showTopSnackBar(Overlay.of(context), CustomSnackBar.success(message: LocalKeysTr.YOUR_SMART_DEVICE_HAS_BEEN_SUCCESSFULLY_ADDED));
      }
      if (smartDevices != null) {
        for (var element in smartDevices) {
          ref.read(kTelemetryDataProvider.notifier).listenForTelemetryData(element.deviceId ?? "");
        }
      }
      if (next.basicModelStatus == BasicModelStatus.ON_EXCEPTION && next.exception != null) {
        showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message: next.exception.getMessage()));
      }
    });
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Row(
          children: [
            IconConstants.toolsIcon,
            SizedBox(width: 8),
            Text(LocalKeysTr.SMART_DEVICES, style: TextStyle(color: Colors.black)),
          ],
        ),
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
              CustomAddDeviceButton(
                text: LocalKeysTr.ADD_SMART_DEVICE,
                onClicked: () {
                  _showCustomDialog(context);
                },
              ),
              CustomDivider(),
              Expanded(child: SingleChildScrollView(child: Column(children: _buildSmartDevicesList())))
            ],
          ),
        ),
      ),
    );
  }

  void _showCustomDialog(BuildContext context) {
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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(LocalKeysTr.ADD_DEVICE, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(LocalKeysTr.YOU_CAN_ADD_YOUR_SMART_DEVICE_WITH_THE_DEVICE_CODE_AND_DEVICE_TYPE_WRITTEN_ON_IT),
                  SizedBox(height: 20),
                  Text(LocalKeysTr.SELECT_THE_DEVICE_TYPE),
                  SizedBox(height: 5),
                  CustomDropdownButton(),
                  SizedBox(height: 10),
                  Text(LocalKeysTr.PUSH_THE_DEVICE_CODE),
                  SizedBox(height: 5),
                  TextField(
                    obscureText: false,
                    controller: _deviceCodeTextEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                      labelText: LocalKeysTr.DEVICE_CODE,
                    ),
                  ),
                  SizedBox(height: 2),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () {
                        ref.read(kSmartDeviceProvider.notifier).addSmartDevice(_deviceCodeTextEditingController.text);
                      },
                      child: Text(LocalKeysTr.ADD_DEVICE),
                    ),
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

  List<Widget> _buildSmartDevicesList() {
    var state = ref.watch(kSmartDeviceProvider);
    if (state.basicModelStatus == BasicModelStatus.LOADING_DATA) {
      return _generateSmartDeviceLoadingList();
    } else if (state.basicModelStatus == BasicModelStatus.LOADED_DATA ||
        state.basicModelStatus == BasicModelStatus.ON_EXCEPTION) {
      return _generateSmartDeviceLoadedList(state.smartDevices ?? []);
    } else {
      return [SizedBox()];
    }
  }

  List<Widget> _generateSmartDeviceLoadingList() {
    return List.generate(5, (index) => CustomSmartDeviceCard.loading());
  }

  List<Widget> _generateSmartDeviceLoadedList(List<SmartDevice> smartDevices) {
    return List.generate(
      smartDevices.length,
      (index) {
        SmartDevice smartDevice = smartDevices[index];
        DateTime? dateTime = ref.watch(kTelemetryDataProvider).telemetryData?[smartDevice.deviceId]?.dataTime;
        double criticalGasLevel = smartDevice.gasCriticalLevel ?? 0;
        double gasLevel = ref.watch(kTelemetryDataProvider).telemetryData?[smartDevice.deviceId]?.gas ?? 0;
        return CustomSmartDeviceCard(
          smartDevice: smartDevices[index],
          dataTime: dateTime,
          areThereCriticalGasDanger: gasLevel>criticalGasLevel,
          onClicked: () {
            SmartDevice smartDevice = smartDevices[index];
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SmartDevicePageView(
                  smartDevice: smartDevice,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
