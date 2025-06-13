import 'dart:async';

import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget desktopView;
  final Widget mobileView;

  const ResponsiveWidget({super.key, required this.desktopView, required this.mobileView});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          // Desktop View
          deviceTypeStreamController.add(AppDeviceType.desk);
          return desktopView;
        } else {
          // Mobile View
          deviceTypeStreamController.add(AppDeviceType.mob);
          return mobileView;
        }
      },
    );
  }
}

StreamController<AppDeviceType> deviceTypeStreamController = StreamController<AppDeviceType>.broadcast();

enum AppDeviceType{
  mob,desk,
}