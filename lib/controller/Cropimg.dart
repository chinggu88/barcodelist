import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class Cropimg extends GetxController {
  AppState state;
  File imageFile;
  File cropFile;
  Future<Directory> _appDocumentsDirectory;
  File savedfile;
  String _appDocPath = "";

  //바코드저장
  savecropimg() async {
    final appDir = await getApplicationDocumentsDirectory();
    // final filename = name + ".jpg";
    final filename = path.basename(imageFile.toString());

    savedfile = File('${appDir.path}/${filename}');
    savedfile.writeAsBytesSync(imageFile.readAsBytesSync());
    print("savefile ${savedfile.path}");
    update();
    imageFile = null;
  }

  Future<Null> cropImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      state = AppState.cropped;
    }
    update();
  }

  void clearImage() {
    imageFile = null;
    state = AppState.free;
  }
}

enum AppState {
  free,
  picked,
  cropped,
}
