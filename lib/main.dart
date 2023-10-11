import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'Controllers/internet_controller.dart';
import 'Screens/Ui/homePage.dart';
import 'Services/api_service.dart';

void main() async{
  await dotenv.load(fileName:".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


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
