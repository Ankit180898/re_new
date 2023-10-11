import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Screens/Ui/homePage.dart';
import '../Services/api_service.dart';

class HomePageController extends GetxController{
  final _apiService = Get.find<ApiService>();
  var gallery=false.obs;
  File? imageFile;
  Rx<String?> avatarPath = null.obs;
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
        Container(
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
                showGeneralDialog(
                  context: context,
                  barrierColor: Colors.black12, // Background color
                  barrierDismissible: false,
                  barrierLabel: 'Dialog',
                  transitionDuration: Duration(milliseconds: 400),
                  pageBuilder: (_, __, ___) {
                    return Column(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: SizedBox.expand(child: FlutterLogo()),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox.expand(
                            child: ElevatedButton(
                              onPressed: () => Get.offAll(HomePage()),
                              child: Text('Dismiss'),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }, child:Text("Submit"))
            ],
          ),
        ),
      ),
    ),
  );
}

     print("image:$avatarPath");
    }


  Future<void> uploadImage() async {
    try {
      var apiKey = dotenv.env['API_KEY'];
      var headers = {
        'content-type': "application/json",
        'X-RapidAPI-Key': "3d3ad25bfemsha0930c6451fb353p18d40bjsnf8fda05d84df",
        'X-RapidAPI-Host': "appyhigh-ai.p.rapidapi.com"
      };
      var body = {
        "source_url": "https://dribbble.com/shots/3729464-Unsplash-Upload-image",
        "filename": "",
      };

      String url = "https://appyhigh-ai.p.rapidapi.com/rapidapi/enhancer/2k";

      final response = await _apiService.post(url,headers, body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Response Data: $data");
        // You can now work with the response data.
      } else {
        print("Request failed with status: ${response.statusCode}");
        // Handle the error, e.g., show an error message to the user.
      }
    } catch (e) {
      // Handle the exception (e.g., show an error dialog, display a message)
      print(e);
    }
  }





}