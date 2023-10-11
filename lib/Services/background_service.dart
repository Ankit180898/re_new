import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:re_new/Style/textstyles.dart';
class BackgroundService extends GetxService {
  var backgroundTaskProgress = 0.0.obs;

  Future<String?> downloadImageInBackground(String imageUrl) async {
    // Get temporary directory
    var dir = await getDownloadsDirectory();

   print("directoru:${dir?.path}");
    // Create an image name
    var filename = dir?.path;
    final taskId = await FlutterDownloader.enqueue(
      url: imageUrl,
      savedDir: filename!, // Replace with the desired download path.
      showNotification: true,
      openFileFromNotification: true,
    );

    // Listen for download progress
    // FlutterDownloader.subscribe(taskId, (id, status, progress) {
    //   if (status == DownloadTaskStatus.complete) {
    //     backgroundTaskProgress.value = 1.0;
    //   } else {
    //     backgroundTaskProgress.value = progress / 100.0;
    //   }
    // });

    return taskId;
  }

   void runBackgroundTask(String image) {
    downloadImageInBackground(image)
        .then((_) => AlertDialog(
      title: Text("Download Complete",style: TextStyles.titleTextStyle(),),
    ))
        .catchError((error) => print('Error: $error'));
  }

}
