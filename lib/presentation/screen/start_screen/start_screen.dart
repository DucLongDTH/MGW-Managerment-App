import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DemoApp', style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.white38,
      ),
      body: Column(
        children: [
          SizedBox(height: 200.h),
          Container(
            color: Colors.deepPurpleAccent,
            width: 50.w,
            height: 50.h,
          )
        ],
      ),
    );
  }
}
