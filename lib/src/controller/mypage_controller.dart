import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/controller/auth_controller.dart';
import 'package:instagram_clone/src/model/instagram_user.dart';

class MypageController extends GetxController with GetTickerProviderStateMixin{
  late TabController tabController;
  Rx<IUser> targetUser = IUser().obs;

  @override
  void onInit(){
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  void setTargetUser(){
    var uid = Get.parameters['targetUid']; //친구의 계정을 클릭했을때는
    if(uid == null){ //널이라는 것은 내 프로필을 선택했다는 뜻임
      targetUser(AuthController.to.user.value); //내프로필 정보를 담음
    }else{ //상대 uid로 조회했을 때
      //users collection 조회
    }
  }

  void _loadData(){
    setTargetUser();

    //포스트 리스트 로드
    //사용자 정보 로드
  }
}

