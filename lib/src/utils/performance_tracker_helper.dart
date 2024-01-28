import 'dart:async';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:performance_metrics/src/models/performance_event.dart';
import 'package:performance_metrics/src/services/performance_service.dart';

class PerformanceMetricsHelper {
  static final PerformanceMetricsHelper _instance =
      PerformanceMetricsHelper._internal();

  bool forceLogEvents = false;
  Timer? timer;
  PackageInfo? packageInfo;
  String? userId;

  factory PerformanceMetricsHelper() {
    return _instance;
  }

  List<PerformanceEvent> bufferedEvents = [];

  PerformanceMetricsHelper._internal();

  void addPerformanceEvent(PerformanceEvent event) {
    bufferedEvents.add(event);
    timer ??= Timer.periodic(const Duration(seconds: 15), (timer) {
      forceLogEvents = true;
      checkAndLogEvents();
    });
    checkAndLogEvents();
  }

  Future<void> checkAndLogEvents() async {
    if ((bufferedEvents.isNotEmpty) &&
        (bufferedEvents.length > 10 || forceLogEvents)) {
      timer?.cancel();
      timer = null;
      forceLogEvents = false;
      await PerformanceService().sendPerformanceData(bufferedEvents);
      bufferedEvents.clear();
    }
  }
}
