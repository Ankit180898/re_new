import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_new/Controllers/homePage_controller.dart';

import '../../Style/textstyles.dart';
import '../Widgets/common_bottom_sheet.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(HomePageController());
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: size.height*0.35,
              width: size.width*0.80,
              decoration: BoxDecoration(
                boxShadow:[BoxShadow(
                  color: Colors.black.withOpacity(0.09),
                  blurRadius: 30.0,
                ),] ,
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0)
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text("Upload your file",style: TextStyles.titleTextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.7)),),
                    Text("Files can be uploaded by url/gallery",style: TextStyles.bodyTextStyle(fontSize: 14, color: Colors.grey,),textAlign: TextAlign.center),
          Spacer(),
          InkWell(
            onTap: (){
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    height: size.height*0.30,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context)
                            .viewInsets
                            .bottom),
                    child: BottomSheetExample(),
                  ),
                ),
              );
            },
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              padding: EdgeInsets.all(6),
              dashPattern: [8, 4],
              strokeWidth: 2,
              color: Colors.grey,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    height: size.height*0.15,
                    width: double.infinity,

                    color: Colors.blue.withOpacity(0.09),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_upload,size: 50,color: Colors.blue,),
                      ],
                    ),
                  ),
              ),
            ),
          )
                    ,
                    Spacer()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
