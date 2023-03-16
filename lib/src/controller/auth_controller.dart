import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/src/repository/user_repository.dart';

import '../binding/init_bindings.dart';
import '../model/instagram_user.dart';

//AuthController 는 이 앱을 통틀어서 유저 정보를 가지고 있는 객체

class AuthController extends GetxController{ //controller이기에 getxcontroller
  //static은 원래는 쓸때마다 객체를 해당 사용하는 놈에서 계속 선언해서 사용해야 하지만
  //static을 사용하면 선언할 필요 없이 바로 사용 가능
  //대신에 이를 사용하는 모든 놈에서 값을 공유
  //const를 사용할 경우 값 변경을 막을 수 있음
  static AuthController get to => Get.find();

  Rx<IUser> user = IUser().obs; //GetX를 이용한 유저정보 저장

  Future<IUser?> loginUser(String uid) async{ //loginUser 함수
    //DB조회
    var userData = await UserRepository.loginUserByUid(uid);
    //loginUserByUid를 함수를 불러옴 => user_repository에 정의해놓음
    //UserRepository Class에서
    if(userData != null){
      user(userData);
      InitBinding.additionalBinding(); //mypagecontroller를 들여옴
    }
    return userData;
  }

  void signup(IUser signupUser, XFile? thumbnail) async{ //user_repository에 있는걸 그대로 가져다 씀
    if(thumbnail == null){
      _submitSignup(signupUser);
    }else{
      var task = uploadXFile(thumbnail,
          '${signupUser.uid}/profile.${thumbnail.path.split('.').last}');
      //확장자는 split(.)을 통해 나눈후 마지막 값으로 추출
          task.snapshotEvents.listen((event) async{
            print(event.bytesTransferred);
            if(event.bytesTransferred == event.totalBytes &&
            event.state == TaskState.success){ //업로드가 완료 되었을 때
              var downloadUrl = await event.ref.getDownloadURL();
              //업로드를 했을 때 이미지 파일의 도메인(cdn)을 받아올 수 있음
              var updatedUserData = signupUser.copyWith(thumbnail : downloadUrl);
              _submitSignup(updatedUserData);
            }
          });
    }
  }

  UploadTask uploadXFile(XFile file, String filename){
    var f = File(file.path);
    var ref = FirebaseStorage.instance.ref().child('users').child(filename);
    //파이어베이스 스토리지에 users 안에 파일이름을 담아 저장함
    //users/{uid}/profile.jpg or profile.png 이런식으로 저장됨

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path' : file.path},
    );

    return ref.putFile(f, metadata);
  }

  void _submitSignup(IUser signupUser) async{
    var result = await UserRepository.signup(signupUser);
    if(result){ //result 가 true일 경우 signup이 된것임
      loginUser(signupUser.uid!);
    }
  }

}