import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_device_mobile_app/product/enums/model_enums/action_status.dart';
import 'package:smart_device_mobile_app/product/enums/model_enums/basic_model_status.dart';
import 'package:smart_device_mobile_app/product/initializer/di.dart';
import 'package:smart_device_mobile_app/product/models/telemetry_data/telemetry_data.dart';
import 'package:smart_device_mobile_app/product/services/abstract/telemetry_data_service.dart';

final kTelemetryDataProvider = StateNotifierProvider<TelemetryDataNotifier, TelemetryDataState>((ref) => TelemetryDataNotifier());

class TelemetryDataNotifier extends StateNotifier<TelemetryDataState> {
  TelemetryDataNotifier()
      : super(TelemetryDataState(
            basicModelStatus: BasicModelStatus.INITIAL,
            actionStatus: ActionStatus.NO_ACTION,
            telemetryData: <String, TelemetryData>{}));

  final TelemetryDataService _telemetryDataService = kGetIt.get<TelemetryDataService>();

  Future<void> listenForTelemetryData(String deviceId) async {
    state = state.copyWith(basicModelStatus: BasicModelStatus.LOADING_DATA);
    _telemetryDataService.getLastTelemetryData(deviceId).listen((telemetryData) {
      if (telemetryData != null) {
        state.telemetryData?[deviceId] = telemetryData;
        state = state.copyWith(basicModelStatus: BasicModelStatus.LOADED_DATA, telemetryData: state.telemetryData);
      } else {
        state = state.copyWith(
          basicModelStatus: BasicModelStatus.ON_EXCEPTION,
        );
      }
    }, onError: (error) {
      state = state.copyWith(
        basicModelStatus: BasicModelStatus.ON_EXCEPTION,
        exception: Exception(error),
      );
    });
  }

  Future<void> giveWarningSound(String deviceId) async {
    try {
      state = state.copyWith(actionStatus: ActionStatus.GIVE_WARNING_SOUND);
      _telemetryDataService.changeFlagState(deviceId, giveWarningSound: true, runGrinder: false);
      state = state.copyWith(actionStatus: ActionStatus.NO_ACTION);
    } catch (e) {
      state = state.copyWith(basicModelStatus: BasicModelStatus.ON_EXCEPTION, exception: Exception(e));
    }
  }
  Future<void> runGrinder(String deviceId) async {
    try {
      state = state.copyWith(actionStatus: ActionStatus.RUN_GINDER);
      _telemetryDataService.changeFlagState(deviceId, giveWarningSound: false, runGrinder: true);
      state = state.copyWith(actionStatus: ActionStatus.NO_ACTION);
    } catch (e) {
      state = state.copyWith(basicModelStatus: BasicModelStatus.ON_EXCEPTION, exception: Exception(e));
    }
  }
}

class TelemetryDataState extends Equatable {
  final BasicModelStatus basicModelStatus;
  final ActionStatus actionStatus;
  final Exception? exception;
  final Map<String, TelemetryData>? telemetryData;

  const TelemetryDataState({required this.basicModelStatus, required this.actionStatus, this.exception, this.telemetryData});

  @override
  List<Object?> get props => [basicModelStatus, exception, telemetryData];

  TelemetryDataState copyWith({
    BasicModelStatus? basicModelStatus,
    ActionStatus? actionStatus,
    Exception? exception,
    Map<String, TelemetryData>? telemetryData,
  }) {
    return TelemetryDataState(
      basicModelStatus: basicModelStatus ?? this.basicModelStatus,
      actionStatus: actionStatus ?? this.actionStatus,
      exception: exception ?? this.exception,
      telemetryData: telemetryData ?? this.telemetryData,
    );
  }
}
