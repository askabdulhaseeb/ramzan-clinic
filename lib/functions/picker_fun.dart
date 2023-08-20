import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PickerFun {
  Future<File?> image() async {
    final bool isGranted = await _request();
    if (!isGranted) return null;
    final XFile? file =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return null;
    return File(file.path);
  }

  Future<List<File>> images() async {
    final bool isGranted = await _request();
    if (!isGranted) return <File>[];
    final List<XFile> file = await ImagePicker().pickMultiImage();
    List<File> temp = <File>[];
    for (XFile element in file) {
      temp.add(File(element.path));
    }
    return temp;
  }

  Future<bool> _request() async {
    if (Platform.isMacOS || Platform.isWindows) return true;
    await <Permission>[Permission.photos, Permission.mediaLibrary].request();
    final PermissionStatus status1 = await Permission.photos.status;
    final PermissionStatus status2 = await Permission.mediaLibrary.status;
    return status1.isGranted && status2.isGranted;
  }
}
