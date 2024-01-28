import 'package:flutter/material.dart';
import 'package:performance_metrics/performance_metrics.dart';
import 'package:performance_tracking_example/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PerformanceMetrics().init('temp_user_id');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Performance Metrics Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
