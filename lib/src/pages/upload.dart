import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/image_data.dart';
import 'package:instagram_clone/src/controller/upload_controller.dart';
import 'package:photo_manager/photo_manager.dart';

class Upload extends GetView<UploadController> { //변경되는 부분이 있을 경우 stateful로 설정해야함
  Upload({Key? key}) : super(key: key);

  // @override
  // void initState(){
  //   super.initState();
  //   _loadPhotos();
  // }

    //이제는 get에 있는 binding을 사용함으로써 그냥 컨트롤러로 연결

    // setState(() {
    //   _pagingPhotos();
    // }); //setstate를 해줘야 반영됨
    // //setState()를 사용해야한다.
    // // setState()는 StatefulWidget에서 특정 오브젝트의 상태(값)를 변경하기 위해 사용하는 메소드이다.
    // // setState() 안에서 상태를 변경하면 setState()는 이를 Flutter 프레임워크에 알려준다.
    // // 그리고 변경된 상태를 기반으로 build() 메소드를 실행시킨다.
  //=========================================================================


  Widget _imagePreview(){
    var width = Get.width;
    return Obx(() => Container(
      width: width,
      height: width,
      color: Colors.grey,
      child: _photoWidget(controller.selectedImage.value, width.toInt(),
      builder: (data){return Image.memory(data, fit: BoxFit.cover);}),
        )
      );
  }

  Widget _header(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              showModalBottomSheet(//바텀시트 : 아래에서 올라오는 창
                context: Get.context!,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
                ),
                builder: (_)=> Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //위에 표시되는 작은 네모
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top:7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black54,
                        ),
                        width: 40,
                        height: 4,
                      ),
                    ),
                    //내용물 리스트 스크롤 가능
                    Expanded(
                      child: Scrollbar(
                        thickness: 8,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: List.generate(
                                controller.albums.length,
                                    (index) => GestureDetector(
                                      onTap: (){
                                        controller.changeAlbum(
                                          controller.albums[index]
                                        );
                                        Get.back();
                                      },
                                      child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20,
                                      ),
                                      child: Text(controller.albums[index].name) //갤러리 파일 분류 목록
                                ),
                                    )
                              ),
                            ),
                          ),
                        ),
                      )
                    ]
                  )
                );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Obx(() => Text(
                      controller.headerTitle.value, //갤러리 선택할 것 albums로 받아서 넣음
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                 const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff808080),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Row(
                  children: [
                    ImageData(IconsPath.imageSelectIcon),
                    const SizedBox(width: 7),
                    const Text(
                      '여러 항목 선택',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 5,),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff808080),
                ),
                child: ImageData(IconsPath.cameraIcon),
              )
            ],
          )
        ]
      ),
    );
  }

  Widget  _imageSelectList(){
    return Obx(() => GridView.builder( //스크롤 안에 스크롤 있으면 오류 발생하니까 주의
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, //몇줄로 만들 것인지
        childAspectRatio: 1,
        mainAxisSpacing: 1, //사이에 간격 주는 것
        crossAxisSpacing: 1,
      ),
      itemCount: controller.imageList.length, //이미지 리스트에 들어온 개수 만큼 생성
      itemBuilder: (BuildContext context, int index){
        controller.imageList[index];
        return _photoWidget(controller.imageList[index], 200,
          builder: (data){return GestureDetector(
            onTap: (){
              controller.changeSelectedImage(controller.imageList[index]);
            },
            child: Obx(() => Opacity(
              opacity: controller.imageList[index] == controller.selectedImage.value
                  ?0.3
                  :1,
              child: Image.memory(data,fit: BoxFit.cover,),),
              )
            );
          }
        );
      }
    ),
    );
  }

  Widget _photoWidget(AssetEntity asset, int size,
      {required Widget Function(Uint8List) builder}){ //들어갈 함수까지 받아 씀
    return FutureBuilder(
      future: asset.thumbnailDataWithSize(ThumbnailSize(size, size)),
      builder: (_,AsyncSnapshot<Uint8List?> snapshot){
        if(snapshot.hasData){
          return builder(snapshot.data!);
        }else {
          return Container();
        }
      }
    );

  }



  @override
  Widget build(BuildContext context) { //setState 될때마다 여기를 실행함
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(15.0), //앱바 리딩에서의 크기조절은 패딩으로 처리할 것
            child: ImageData(IconsPath.closeImage,),
          ),
        ),
        title: const Text(
          '새 게시물',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: controller.gotoImageFilter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(IconsPath.nextImage, width: 50,),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagePreview(),
            _header(),
            _imageSelectList(),
          ],
        ),
      )
    );
  }
}
