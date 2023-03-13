import 'package:flutter/material.dart';

/// device screen height
double getDeviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/// device screen width
double getDeviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// status bar
double getDeviceTopHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

/// bottom padding
double getDeviceBottomHeight(BuildContext context) {
  return MediaQuery.of(context).padding.bottom;
}
