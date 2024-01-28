class PerformanceEvent {
  final String? trackerId;
  final num? duration;
  final String? appVersion;
  final String? packageName;
  final DateTime? createdAt;
  final String? userId;

  PerformanceEvent({
    required this.trackerId,
    required this.packageName,
    required this.duration,
    required this.appVersion,
    required this.createdAt,
    required this.userId,
  });

  factory PerformanceEvent.fromJson(Map<String, dynamic> json) {
    return PerformanceEvent(
      packageName: json['package_name'],
      trackerId: json['tracker'],
      duration: json['duration'],
      appVersion: json['app_version'],
      userId: json['user_id'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'package_name': packageName,
      'tracker': trackerId,
      'duration': duration,
      'app_version': appVersion,
      'created_at': createdAt?.millisecondsSinceEpoch,
      'user_id': userId,
    };
  }
}