import 'package:flutter/material.dart';

abstract class BaseLoadingWidget extends StatefulWidget {
  const BaseLoadingWidget({Key? key}) : super(key: key);
}

abstract class BaseLoadingWidgetState<T extends BaseLoadingWidget>
    extends State<BaseLoadingWidget> {}