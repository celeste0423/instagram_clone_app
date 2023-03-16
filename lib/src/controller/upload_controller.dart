import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as imageLib;
import 'package:instagram_clone/src/components/message_popup.dart';
import 'package:instagram_clone/src/controller/auth_controller.dart';
import 'package:instagram_clone/src/repository/post_repository.dart';
import 'package:path/path.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photofilters/filters/preset_filters.dart';

import '../model/post.dart';
import '../pages/upload/photo_filter.dart';
import '../pages/upload/upload_description.dart';
import '../utils/data_util.dart';

class UploadController extends GetxController {
  var albums = <AssetPathEntity>[]; //AssetPathEntity 형식으로 클래스 선언
  RxString headerTitle = ''.obs;
  RxList<AssetEntity> imageList = <AssetEntity>[].obs;
  Rx<AssetEntity> selectedImage = const AssetEntity(
    id: '0',
    typeInt: 0,
    width: 0,
    height: 0,
  ).obs;
  late File filteredImage;
  Post? post;

  TextEditingController textEditingController = TextEditingController();

  @override
  void onInit() {
    //업로드 창 들어왔을 시 자동으로 init됨
    super.onInit();
    post = Post.init(AuthController.to.user.value);
    _loadPhotos();
  }

  void _loadPhotos() async {
    var result = await PhotoManager.requestPermissionExtend(); //퍼미션 받아옴
    if (result.isAuth) {
      //권한이 있으면 시작, 없으면 권한 요청
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image, //가져올 타입 이미지로 설정
        filterOption: FilterOptionGroup(
            //가져올 이미지의 필터 설정
            imageOption: const FilterOption(
                sizeConstraint: SizeConstraint(
              //이미지 크기 제한
              minHeight: 100,
              minWidth: 100,
            )),
            orders: [
              const OrderOption(
                //순서는 날짜 순서대로 사용
                type: OrderOptionType.createDate,
                asc: false,
              )
            ]),
      );
      _loadData();
    } else {}
  }

  void _loadData() async {
    changeAlbum(albums.first); //Rx인 놈들은 괄호로 값을 정의함
  }

  Future<void> _pagingPhotos(AssetPathEntity album) async {
    imageList.clear(); //페이지가 달라질 때마다 초기화를 해줘야함
    var photos = await album.getAssetListPaged(page: 0, size: 30);
    //페이징을 통해 과부하 방지, 30개씩 이미지를 불러옴
    imageList.addAll(photos);
    changeSelectedImage(imageList.first);
    //만들어놓은 이미지리스트에다가 페이징 된 사진을 추가함
  }

  changeSelectedImage(AssetEntity image) {
    selectedImage(image);
  }

  void changeAlbum(AssetPathEntity album) async {
    headerTitle(album.name);
    await _pagingPhotos(album);
  }

  void gotoImageFilter() async {
    var file = await selectedImage.value.file;
    var fileName = basename(file!.path);
    var image = imageLib.decodeImage(file.readAsBytesSync());
    image = imageLib.copyResize(image!, width: Get.width.toInt());
    Map imagefile = await Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: const Text("필터 선택"),
          image: image!,
          filters: presetFiltersList,
          filename: fileName,
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.cover,
          circleShape: false,
          appBarColor: Colors.white,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      filteredImage = imagefile['image_filtered'];
      Get.to(() => UploadDescription());
    }
  }

  void uploadPost() {
    FocusManager.instance.primaryFocus?.unfocus();
    var filename = DataUtil.makeFilePath();
    var task = uploadFile(
        filteredImage, '${AuthController.to.user.value.uid}/${filename}');
    if (task != null) {
      task.snapshotEvents.listen((event) async {
        if (event.bytesTransferred == event.totalBytes && //완료되었는 지 체크함
            event.state == TaskState.success) {
          var downloadUrl = await event.ref.getDownloadURL();
          var updatedPost = post!.copyWith(
            thumbnail: downloadUrl,
            description: textEditingController.text,
          );
          _submitPost(updatedPost);
        }
      });
    }
  }

  UploadTask uploadFile(File file, String filename) {
    var ref = FirebaseStorage.instance.ref().child('instagram').child(filename);
    //파이어베이스 스토리지에 users 안에 파일이름을 담아 저장함
    //users/{uid}/profile.jpg or profile.png 이런식으로 저장됨

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );
    return ref.putFile(file, metadata);
  }

  void _submitPost(Post postData) async {
    await PostRepository.updatePost(postData);
    showDialog(
      context: Get.context!,
      builder: (context) => MessagePopup(
        title: '포스트',
        message: '포스팅이 완료 되었습니다.',
        okCallback: () {
          Get.until((route) => Get.currentRoute == '/');
          //저 페이지 나갈때까지 콜백
        },
        cancelCallback: () {
          Get.back();
        },
      ),
    );
  }
}
