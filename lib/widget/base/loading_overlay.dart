import 'package:app_demo_flutter/constant/loading_utils.dart';
import 'package:flutter/material.dart';

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return showLoading(true);
  }
}

class LoadingOverlay {
  OverlayEntry? _overlay;

  LoadingOverlay();

  void show(BuildContext context) {
    if (_overlay == null) {
      _overlay = OverlayEntry(
        builder: (context) => _FullScreenLoader(),
      );
      Overlay.of(context)!.insert(_overlay!);
    }
  }

  void hide() {
    if (_overlay != null) {
      _overlay!.remove();
      _overlay = null;
    }
  }
}
