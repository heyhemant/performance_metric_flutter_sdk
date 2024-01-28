import 'package:performance_metrics/src/models/performance_event.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:performance_metrics/src/utils/constants.dart';

class PerformanceService {
  Future<bool> sendPerformanceData(List<PerformanceEvent> events) async {
    try {
      List<dynamic> data = events.map((e) => e.toJson()).toList();
      Uri performanceUri = Uri.parse(Constants.PERFORMANCE_URL);
      var response = await http.post(
        performanceUri,
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        assert(false, "Error sending performance data");
        return false;
      }
    } catch (e) {
      assert(false, "Error sending performance data  $e");
      return false;
    }
  }
}
