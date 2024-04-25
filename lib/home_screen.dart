import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform = MethodChannel('com.example.platform_specific_code');

  String deviceType = 'Unknown';
  String deviceModel = 'Unknown';
  String deviceBrand = 'Unknown';
  String osVersion = 'Unknown';
  String batteryLevel = 'Unknown';

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  Future<void> _getDeviceInfo() async {
    try {
      final dynamic result = await platform.invokeMethod('getDeviceInfo');
      final Map<String, dynamic> deviceInfo = Map<String, dynamic>.from(result);
      setState(() {
        deviceType = deviceInfo['deviceType'] ?? 'Unknown';
        deviceModel = deviceInfo['deviceModel'] ?? 'Unknown';
        deviceBrand = deviceInfo['deviceBrand'] ?? 'Unknown';
        osVersion = deviceInfo['osVersion'] ?? 'Unknown';
        batteryLevel = deviceInfo['batteryLevel']?.toString() ?? 'Unknown';
      });
    } on PlatformException catch (e) {
      print("Failed to get device info: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Information'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: ListTile(
                title: Text('Device Type'),
                subtitle: Text(deviceType),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              child: ListTile(
                title: Text('Device Model'),
                subtitle: Text(deviceModel),
              ),
            ),
            Card(
              elevation: 4,
              child: ListTile(
                title: Text('Device Brand'),
                subtitle: Text(deviceBrand),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              child: ListTile(
                title: const Text('OS Version'),
                subtitle: Text(osVersion),
              ),
            ),
            Card(
              elevation: 4,
              child: ListTile(
                title: const Text('Battery Level'),
                subtitle: Text(batteryLevel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
