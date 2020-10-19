// import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:system_network_proxy/app.dart';
import 'package:system_network_proxy/flutter_configuration.dart';
import 'package:system_network_proxy/service.dart';
import 'dart:io' show Platform;
import 'dart:math' as math;
import 'package:window_size/window_size.dart' as window_size;

/// global configuration from yaml
FlutterConfiguration config;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await DesktopWindow.setWindowSize(Size(500, 300));
  var window = await window_size.getWindowInfo();
  if (window.screen != null) {
    final screenFrame = window.screen.visibleFrame;
    final width = 600.0;
    final height = 500.0;
    final left = ((screenFrame.width - width) / 2).roundToDouble();
    final top = ((screenFrame.height - height) / 3).roundToDouble();
    final frame = Rect.fromLTWH(left, top, width, height);
    window_size.setWindowFrame(frame);
    window_size.setWindowMinSize(Size(1.0 * width, 1.0 * height));
    window_size.setWindowMaxSize(Size(2.0 * width, 2.0 * height));
    window_size.setWindowTitle('System Network Proxy (${Platform.operatingSystem})');
  }
  config = await FlutterConfiguration.fromAsset('assets/config.yaml');
  await Service().init();
  runApp(App());
}