import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:unique_id/unique_id_platform_interface.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _androidId = 'Unknown';

  @override
  void initState() {
    super.initState();
    _initAndroidId();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initAndroidId() async {
    String androidId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      androidId = await UniqueIdPlatform.instance.getUniqueId() ?? 'Unknown ID';
    } on PlatformException {
      androidId = 'Failed to get Android ID.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() => _androidId = androidId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Android ID: $_androidId'),
        ),
      ),
    );
  }
}
