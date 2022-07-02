import 'package:app_demo_flutter/widget/base/loading_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  LoadingOverlay loadingOverlay = GetIt.instance.get<LoadingOverlay>();
  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerDown: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: buildLayout(context));
  }

  Widget buildLayout(BuildContext context) {
    throw UnimplementedError();
  }
}
