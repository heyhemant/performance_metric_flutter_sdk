import 'package:package_info_plus/package_info_plus.dart';
import 'package:performance_metrics/src/models/performance_event.dart';
import 'package:performance_metrics/src/utils/performance_tracker_helper.dart';

class PerformanceMetrics {
  static final PerformanceMetrics _instance = PerformanceMetrics._internal();

  factory PerformanceMetrics() {
    return _instance;
  }

  PerformanceMetrics._internal();
  
  Future<void> init(String? userId) async {
    PerformanceMetricsHelper().userId = userId;
    PerformanceMetricsHelper().packageInfo = await PackageInfo.fromPlatform();
  }

  Future<dynamic> executeAsyncTask(String tracker, Function task) async {
    final Stopwatch stopwatch = Stopwatch()..start();
    final result = await task();
    stopwatch.stop();
    final int duration = stopwatch.elapsedMilliseconds;
    final PerformanceEvent event = PerformanceEvent(
      trackerId: tracker,
      duration: duration,
      appVersion: PerformanceMetricsHelper().packageInfo?.version,
      packageName: PerformanceMetricsHelper().packageInfo?.packageName,
      userId: PerformanceMetricsHelper().userId,
      createdAt: DateTime.now(),
    );
    PerformanceMetricsHelper().addPerformanceEvent(event);
    return result;
  }

  dynamic executeSyncTask(String tracker, Function task) {
    final Stopwatch stopwatch = Stopwatch()..start();
    final result = task();
    stopwatch.stop();
    final int duration = stopwatch.elapsedMilliseconds;
    final PerformanceEvent event = PerformanceEvent(
      trackerId: tracker,
      duration: duration,
      appVersion: PerformanceMetricsHelper().packageInfo?.version,
      packageName: PerformanceMetricsHelper().packageInfo?.packageName,
      userId: PerformanceMetricsHelper().userId,
      createdAt: DateTime.now(),
    );
    PerformanceMetricsHelper().addPerformanceEvent(event);
    return result;
  }
}
