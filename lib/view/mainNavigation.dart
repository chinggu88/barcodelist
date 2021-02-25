import 'package:barcodeselector/controller/Barcodelist_controller.dart';
import 'package:barcodeselector/controller/Navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainNavigation extends StatelessWidget {
  final info = Get.put(Barcodelist_controller());
  var navi = Get.put(Navigation_controller());
  @override
  Widget build(BuildContext context) {
    if (navi.navi_index != 0) {
      navi.indexupdate(0);
    }
    return Scaffold(body: GetBuilder<Navigation_controller>(
      builder: (_) {
        return Center(
          child: _.widgetOptions.elementAt(_.navi_index),
        );
      },
    ), bottomNavigationBar: GetBuilder<Navigation_controller>(
      builder: (_) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.red,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          currentIndex: _.navi_index, //현재 선택된 Index
          onTap: (int seq) {
            _.indexupdate(seq);
          },
          items: [
            BottomNavigationBarItem(
              title: Text('List'),
              icon: Icon(Icons.list),
            ),
            BottomNavigationBarItem(
              title: Text('add'),
              icon: Icon(Icons.add),
            ),
            BottomNavigationBarItem(
              title: Text('Places'),
              icon: Icon(Icons.location_on),
            ),
            BottomNavigationBarItem(
              title: Text('News'),
              icon: Icon(Icons.library_books),
            ),
          ],
        );
      },
    ));
  }
}
