/*
바코드 등록하는 화면
*/
import 'dart:io';

import 'package:barcodeselector/controller/Cropimg.dart';
import 'package:barcodeselector/controller/DBHelper.dart';
import 'package:barcodeselector/controller/Navigation_controller.dart';
import 'package:barcodeselector/view/mainNavigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Barcodelist.dart';

class Addbarcode extends StatelessWidget {
  final crop = Get.put(Cropimg());
  final dbHelper = Get.put(DatabaseHelper());

  TextEditingController varcodename = TextEditingController();
  TextEditingController varcodealies = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "바코드이름",
                  hintText: "바코드 이름을 입력해주세요",
                ),
                controller: varcodename,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "사용처",
                  hintText: "사용가능한곳을 입력해주세요",
                ),
                controller: varcodealies,
              ),
            ),
            Center(child: GetBuilder<Cropimg>(
              builder: (_) {
                return _.imageFile != null
                    ? Image.file(_.imageFile)
                    : Text("이미지자리");
              },
            )),
            Center(child: GetBuilder<Cropimg>(
              builder: (_) {
                return _.savedfile != null
                    ? Image.file(File(_.savedfile.toString()))
                    : Text("저장파일");
              },
            )),
            Container(
              child: Image.file(File(
                  '/data/user/0/com.iksun.barcodeselector/app_flutter/aaaa.jpg')),
            ),
            Center(
              child: GetBuilder<Cropimg>(
                builder: (_) {
                  return _.imageFile != null
                      ? Container()
                      : FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,
                          child: Text(
                            "바코드 불러오기",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          onPressed: () {
                            // _.pickImage();
                            _.cropImage();
                          },
                        );
                },
              ),
            ),
            GetBuilder<Cropimg>(builder: (_) {
              return FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () async {
                  try {
                    int cnt = await dbHelper.queryRowCount();
                    //이미지저장
                    await _.savecropimg();
                    Map<String, dynamic> row = {
                      DatabaseHelper.columnSeq: cnt,
                      DatabaseHelper.columnName: varcodename.text,
                      DatabaseHelper.columnPath: _.savedfile.path,
                      DatabaseHelper.columnAlias: varcodealies.text,
                      DatabaseHelper.columnCnt: 0,
                    };
                    //db저장
                    await dbHelper.insert(row);

                    Get.off(Barcodelist());
                  } catch (e) {
                    Get.snackbar("주의", "사용정보를 모두 입력해주세요");
                  }
                },
                child: Text(
                  "바코드 저장하기",
                  style: TextStyle(fontSize: 20.0),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
