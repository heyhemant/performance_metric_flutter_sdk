import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:performance_metrics/performance_metrics.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    //we can track performance of any async task
    PerformanceMetrics().executeAsyncTask('hemant_home', () async {
      await Future<void>.delayed(const Duration(seconds: 5));
      return true;
    });
    super.initState();
  }

  //one more example of async task
  Future<void> _asyncTask() async {
    var data = await PerformanceMetrics().executeAsyncTask('async_task', () async {
      await Future<void>.delayed(const Duration(seconds: 5));
      return 'async data';
    });
    if (kDebugMode) {
      print("$data");
    }
  }

  // sync task too
  void _syncTask() {
    var data =  PerformanceMetrics().executeSyncTask('sync_task', () {
      for(int i=0;i<100;i++){
        for(int j=0;j<1000;j++){
          int a = i+j;
        }
      }
      return 'sync data';
    });
    if (kDebugMode) {
      print("$data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                children: [
                  ElevatedButton(onPressed: (){
                    _syncTask();
                  }, child:const Text('Execute Sync Task')),
                  const Spacer(),
                  ElevatedButton(onPressed: ()async{
                    await _asyncTask();
                  }, child: const Text('Execute Async Task')),
                ],
                         ),
             ),
          ],
        ),
      ),
    );
  }
}
