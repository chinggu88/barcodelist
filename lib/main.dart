import 'package:barcodeselector/view/Barcodelist.dart';
import 'package:barcodeselector/view/addBarcode.dart';
import 'package:barcodeselector/view/mainNavigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(GetMaterialApp(
    // home: MainNavigation(),
    home: Barcodelist(),
    getPages: [
      GetPage(name: '/Barcodelist', page: () => Barcodelist()),
      GetPage(name: '/Addvarcode', page: () => Addbarcode()),
    ],
  ));
}
