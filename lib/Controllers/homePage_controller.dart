import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:re_new/Services/background_service.dart';
import '../Screens/Ui/homePage.dart';
import '../Services/api_service.dart';

class HomePageController extends GetxController{
  final _apiService = Get.find<ApiService>();
  var gallery=false.obs;
  var isLoading=false.obs;
  File? imageFile;
  Rx<String?> avatarPath = null.obs;
  final BackgroundService backgroundService = Get.put(BackgroundService());

  void startBackgroundTask(String image) {
    backgroundService.runBackgroundTask(image);
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    gallery.value=false;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }


  /// Get from gallery
  getFromGallery() async {

    gallery.value=true;
   XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 500,
    );

if(pickedFile!=null) {
  avatarPath = pickedFile.path.obs;
  update();
  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true,
    builder: (context) => SingleChildScrollView(
      child: Container(
        height:MediaQuery.of(context).size.height*0.30,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30)
        ),
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom),
        child:
        Obx(()=>
           isLoading.value==true?CircularProgressIndicator():Container(
            height: 250,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.file(
                      File(avatarPath.value!),
                      width: 150,
                      height: 150,
                      fit: BoxFit.fitHeight,
                    ),
                    Positioned(right: 0,top: 0,child: IconButton(icon:Icon(Icons.close),onPressed: (){Get.back();},))
                  ],
                ),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: (){
                  uploadImage();

                }, child:Text("Submit"))
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

     print("image:$avatarPath");
    }


  Future<void> uploadImage() async {
    var isLoading=true.obs;
    try {
      var apiKey = dotenv.env['API_KEY'];
      final File file = File(avatarPath.value!);
      final Uri uri = file.uri;
      // Define your API endpoint and headers
      String? url = "https://appyhigh-ai.p.rapidapi.com/rapidapi/enhancer/2k";
      Map<String,String> headers = {
        'content-type': 'application/json',
        'X-RapidAPI-Key': "$apiKey",
        'X-RapidAPI-Host': 'appyhigh-ai.p.rapidapi.com',
      };

        // Prepare the request body
        Map<String,String> body = {
          "source_url": "https://avatars.githubusercontent.com/u/48925155?v=4",
          "filename": "", // Specify the desired filename or leave it empty
        };

        // Make the POST request
        final response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: json.encode(body),
        );

        if (response.statusCode == 200) {
          var isLoading=false.obs;

          print("res:$response");

            final String imageUrl = json.decode(response.body)["data"]["2k"]["url"];
            print("Processed Image URL: $imageUrl");
          showGeneralDialog(
            context: Get.context!,
            barrierColor: Colors.black12, // Background color
            barrierDismissible: false,
            barrierLabel: 'Dialog',
            transitionDuration: Duration(milliseconds: 400),
            pageBuilder: (_, __, ___) {
              return
                  Column(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: SizedBox.expand(child: Stack(
                          children: [
                            Image.network(imageUrl),
                            Positioned(top: 0,right: 0,child: IconButton(onPressed: (){}, icon: Icon(Icons.close_outlined,color: Colors.white,size: 30,)))

                          ],
                        )),
                      ),
                      Expanded(flex: 1,child: Obx(() => Text('Progress: ${(backgroundService.backgroundTaskProgress.value * 100).toStringAsFixed(0)}%')),),
                      Expanded(
                        flex: 1,
                        child: SizedBox.expand(
                          child: ElevatedButton(
                            onPressed: () => startBackgroundTask(imageUrl),
                            child: Text('Download'),
                          ),
                        ),
                      ),

                    ],
                  );

            },
          );
            // You can display the image URL or handle it as needed
        } else {
          print("Failed to make the API request. Status code: ${response
              .statusCode}");
          // Handle the API request error
        }
    }catch (e) {
      // Handle the exception (e.g., show an error dialog, display a message)
      print(e);
    }
  }






}