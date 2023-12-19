import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class FirebaseStorageService extends GetxService {
  deleteImage(String imageName, Function() onSuccess,
      Function(String message) onError) async {
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child("$imageName.png");
    try {
      await mountainsRef.delete();
      onSuccess();
    } on FirebaseException catch (e) {
      onError(e.message.toString());
      print("Failed with error '${e.code}': ${e.message}");
    }
  }

  uploadImage(String imageName, Uint8List image, Function(String url) onSuccess,
      Function(String message) onError) async {
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child("$imageName.png");
    final Directory systemTempDir = Directory.systemTemp;
    final File file =
        await File('${systemTempDir.path}/$imageName.png').create();
    file.writeAsBytes(image);
    try {
      mountainsRef
          .putFile(
              file,
              SettableMetadata(
                contentType: "image/png",
              ))
          .snapshotEvents
          .listen((taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress = 100.0 *
                (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            print("Upload is $progress% complete.");
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.success:
            final url = await mountainsRef.getDownloadURL();
            onSuccess(url);
            print("Upload is success.");
            break;
          case TaskState.canceled:
            onError("Upload was canceled.");
            print("Upload was canceled");
            break;
          case TaskState.error:
            onError("Upload is error.");
            print("Upload is error.");
            break;
        }
      });
    } on FirebaseException catch (e) {
      onError(e.message.toString());
      print("Firebase upload image error: ${e.message}");
    }
  }
}
