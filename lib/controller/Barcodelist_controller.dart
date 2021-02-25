import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'DBHelper.dart';

class Barcodelist_controller extends GetxController {
  var dbHelper = Get.put(DatabaseHelper());
  //카드정보
  List<Map<String, dynamic>> cardinfo = [];
  //카드위젯정보
  var cardwidgetinfo = List<Map<String, dynamic>>();

  init() async {
    int i = 0;
    cardwidgetinfo.clear();
    cardinfo = await dbHelper.queryAllRows();
    update();
    cardinfo.forEach((element) {
      cardwidgetinfo
          .add({'seq': element['seq'], 'chk': 'false', 'imgheigh': 0.0});
      i++;
    });
    update();
  }

  //카드펼치기/감추기 버튼
  arrow_circle(String input, int seq) {
    String temp = input;
    cardwidgetinfo.forEach((element) {
      if (element["seq"] == seq) {
        if (temp == "true") {
          element["chk"] = "false";
          element["imgheigh"] = 0.0;
          update();
        } else {
          element["chk"] = "true";
          element["imgheigh"] = 150.0;
          update();
        }
      }
    });
  }
}
