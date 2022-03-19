import 'package:app_demo_flutter/app/app.dart';
import 'package:app_demo_flutter/di/app_di.dart';
import 'package:flutter/material.dart';

void main() async {
  await initDI();
  runApp(const MyApp());
}
