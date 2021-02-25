import 'dart:io';

import 'package:barcodeselector/controller/Barcodelist_controller.dart';
import 'package:barcodeselector/controller/DBHelper.dart';
import 'package:barcodeselector/view/addBarcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Barcodelist extends StatelessWidget {
  final info = Get.put(Barcodelist_controller());
  final dbHelper = Get.put(DatabaseHelper());
  @override
  Widget build(BuildContext context) {
    info.init();
    return Scaffold(
      appBar: AppBar(
        title: Text("리스트입니다."),
        actions: [
          IconButton(
            icon: Icon(
              Icons.replay_sharp,
              size: 40,
            ),
            onPressed: () {
              info.init();
            },
          )
        ],
      ),
      backgroundColor: Colors.grey,
      body: GetBuilder<Barcodelist_controller>(
        builder: (_) {
          return _.cardinfo == null
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: _.cardinfo.length,
                  itemBuilder: (BuildContext context, int i) {
                    int index = _.cardinfo[i]["seq"].toInt();
                    return GestureDetector(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("삭제"),
                              content: new Text("해당 바코드를 삭제하시겠습니까?"),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text("Ok"),
                                  onPressed: () {
                                    Get.back();
                                    dbHelper.deletevarcode(index);
                                    info.init();
                                  },
                                ),
                                new FlatButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              leading: IconButton(
                                icon: _.cardwidgetinfo[i]["chk"] == "false"
                                    ? Icon(
                                        Icons.arrow_circle_down,
                                        size: 40,
                                      )
                                    : Icon(
                                        Icons.arrow_circle_up,
                                        size: 40,
                                      ),
                                onPressed: () {
                                  _.arrow_circle(
                                      _.cardwidgetinfo[i]["chk"].toString(),
                                      index);
                                  dbHelper.updatecnt(_.cardinfo[i]);
                                },
                              ),
                              title: Text(_.cardinfo[i]['name']),
                              subtitle: Text(
                                _.cardinfo[i]['alias'],
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: _.cardwidgetinfo.length == 0
                                    ? 0
                                    : _.cardwidgetinfo[i]["imgheigh"]
                                        .toDouble(),
                                child: Image.file(
                                  File(_.cardinfo[i]["imagepath"].toString()),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.off(Addbarcode());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

//  GetBuilder<DatabaseHelper>(
//         builder: (_) {
//           return _.allrows == null
//               ? Text("로딩중!")
//               : ListView.builder(
//                   itemCount: _.allrows.length,
//                   itemBuilder: (BuildContext context, int i) {
//                     String index = _.allrows[i]["seq"].toString();
//                     return Dismissible(
//                       key: Key(index),
//                       onDismissed: (direction) {
//                         if (direction == DismissDirection.startToEnd) {
//                           //삭제쿼리
//                           _.deletevarcode(int.parse(index));
//                         }
//                       },
//                       background: Container(
//                         color: Colors.green,
//                         child: Icon(Icons.check),
//                       ),
//                       secondaryBackground: Container(
//                         color: Colors.red,
//                         child: Icon(Icons.cancel),
//                       ),
//                       child: Card(
//                         child: ExpansionTile(
//                           title: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(_.allrows[i]["name"]),
//                               Text(_.allrows[i]["alias"]),
//                             ],
//                           ),
//                           children: <Widget>[
//                             Container(
//                               color: Colors.black,
//                               child: Image.file(
//                                 File(_.allrows[i]["imagepath"].toString()),
//                               ),
//                               width: MediaQuery.of(context).size.width * 0.9,
//                             )
//                           ],
//                           // onExpansionChanged: test(),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//         },
//       ),
