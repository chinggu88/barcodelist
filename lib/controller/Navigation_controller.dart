import 'package:barcodeselector/view/Barcodelist.dart';
import 'package:barcodeselector/view/addBarcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Navigation_controller extends GetxController {
  //bomttomnavigation index정보
  int navi_index = 0;

  //메뉴이동
  List widgetOptions = [
    Barcodelist(),
    Addbarcode(),
    Text(
      'Places',
      style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
    ),
    Text(
      'News',
      style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
    ),
  ];

  //
  indexupdate(int i) {
    navi_index = i;
    update();
  }

  Widget bottomscreen(int index) {
    List widgetOptions = [
      Text(
        'Favorites',
        style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
      ),
      Text(
        'Music',
        style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
      ),
      Text(
        'Places',
        style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
      ),
      Text(
        'News',
        style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
      ),
    ];
    return widgetOptions[0];
  }
}
