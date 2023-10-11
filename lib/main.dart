import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'Controllers/internet_controller.dart';
import 'Screens/Ui/homePage.dart';
import 'Services/api_service.dart';
import 'Services/background_service.dart';

void main() async{
  await dotenv.load(fileName:".env");
  WidgetsFlutterBinding.ensureInitialized();

  // Plugin must be initialized before using
  await FlutterDownloader.initialize(
      debug: false, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding:BindingsBuilder(() {
        Get.put(InternetController(), permanent: true);
        Get.put(ApiService(), permanent: true);
      }),
      home: const HomePage(),
    );
  }
}
