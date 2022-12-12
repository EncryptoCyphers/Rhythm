import 'dart:ui';

import 'package:device_information/device_information.dart';

var pixelRatio = window.devicePixelRatio;

//Size in physical pixels
var physicalScreenSize = window.physicalSize;
var physicalWidth = physicalScreenSize.width;
var physicalHeight = physicalScreenSize.height;

//Size in logical pixels
var logicalScreenSize = window.physicalSize / pixelRatio;
var logicalWidth = logicalScreenSize.width;
var logicalHeight = logicalScreenSize.height;

//Padding in physical pixels
var padding = window.padding;

//Safe area paddings in logical pixels
var paddingLeft = window.padding.left / window.devicePixelRatio;
var paddingRight = window.padding.right / window.devicePixelRatio;
var paddingTop = window.padding.top / window.devicePixelRatio;
var paddingBottom = window.padding.bottom / window.devicePixelRatio;

//Safe area in logical pixels
var safeWidth = logicalWidth - paddingLeft - paddingRight;
var safeHeight = logicalHeight - paddingTop - paddingBottom;

// ignore: prefer_typing_uninitialized_variables
late var platformVersion;
// ignore: prefer_typing_uninitialized_variables
// late var imeiNo;
// ignore: prefer_typing_uninitialized_variables
late var modelName;
// ignore: prefer_typing_uninitialized_variables
late var manufacturer;
// ignore: prefer_typing_uninitialized_variables
var apiLevel = 1;

Future getDeviceInfo() async {
  platformVersion = await DeviceInformation.platformVersion;
  // imeiNo = await DeviceInformation.deviceIMEINumber;
  modelName = await DeviceInformation.deviceModel;
  manufacturer = await DeviceInformation.deviceManufacturer;
  apiLevel = await DeviceInformation.apiLevel;
  // print("API: $apiLevel");
}
