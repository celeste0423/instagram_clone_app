import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/image_data.dart';
import 'package:instagram_clone/src/controller/upload_controller.dart';

class UploadDescription extends GetView<UploadController> {
  const UploadDescription({Key? key}) : super(key: key);

  Widget _description(){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Image.file(
              controller.filteredImage,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller.textEditingController,
              maxLines: null, //여러줄을 입력할 수 있게 됨
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: '문구 입력...',
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget infoOne(String title){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 15.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
        ),
      ),
    );
  }

  Widget get line => const Divider(color: Colors.grey);

  Widget snsInfo(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Facebook',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Switch(
                value: false,
                onChanged: (bool value){

                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Twitter',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Switch(
                value: false,
                onChanged: (bool value){

                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tumblr',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Switch(
                value: false,
                onChanged: (bool value){

                },
              )
            ],
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(IconsPath.backBtnIcon, width: 50,),
          ),
        ),
        title: const Text(
          '새 게시물',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: controller.uploadPost,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ImageData(
                IconsPath.uploadComplete,
                width: 50,
              )
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: (){
                FocusManager.instance.primaryFocus?.unfocus();
                //바깥을 누르게 되면은 키보드가 닫힘
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _description(),
                    line,
                    infoOne('사람 태그하기'),
                    line,
                    infoOne('위치 추가'),
                    line,
                    infoOne('다른 미디어에도 게시'),
                    snsInfo(),
                  ],
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
