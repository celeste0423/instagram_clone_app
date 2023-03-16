import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/message_popup.dart';
import '../pages/upload.dart';
import 'upload_controller.dart';

enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find(); //get방식으로 찾겠다

  RxInt pageIndex = 0.obs;
  GlobalKey<NavigatorState> searchPageNavigationKey =
      GlobalKey<NavigatorState>();

  //중첩 라우팅을 위한 글로벌 키
  List<int> bottomHistory = [0]; //페이지 뒤로가기 히스토리 관리

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value]; //page에 페이지 번호 들어오게 됨
    switch (page) {
      case PageName.UPLOAD: //Upload만 팝업창이 열리므로 pageindex 사용 X
        Get.to(() => Upload(),
          binding: BindingsBuilder(() {
            Get.put(UploadController());
        }));
        break;
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value); //pageIndex값을 changePage에 입력되는 value로 교체함
    if (!hasGesture)
      return; //hasGesture가 false이면 value를 add하지 않음 => 뒤로가기 시 현재 페이지 추가 X
    if (bottomHistory.contains(value)) {
      //이미 해당 페이지에 있을경우 remove 후 add
      //이렇게 할 경우 이전 히스토리에 있는 같은 페이지는 순서만 바꾸게 됨
      bottomHistory.remove(value);
    }
    bottomHistory.add(value);
  }

  Future<bool> willPopAction() async {
    //뒤로가기 실행할때
    if (bottomHistory.length == 1) {
      //쌓인 게 없음
      showDialog(
        context: Get.context!,
        builder: (context) => MessagePopup(
          //팝업메시지 : 종료하시겠습니까? => showDialog 파일로 만듦듦
          message: '종료하시겠습니까?',
          title: '시스템',
          okCallback: () {
            exit(0);
          },
          cancelCallback: Get.back,
        ),
      );
      print('exit');
      return true;
    } else {
      var page = PageName.values[bottomHistory.last]; //마지막 페이지 추출
      if (page == PageName.SEARCH) {
        //마지막 페이지가 search라면
        var value = searchPageNavigationKey.currentState!
            .maybePop(); //maybePop : 팝할게 있는 지 확인
        if (value == true) return false; //=> pop할 게 있으면 아무것도 안하겠음
      }

      //중간에 위의 과정을 추가함으로써 만약 search에 들어오게 됐고 pop할 게 없으면 해당 문에서 탈출

      bottomHistory.removeLast();
      //히스토리 리스트에 있는 마지막 요소 삭제
      var index = bottomHistory.last; //바로 직전의 히스토리 페이지 받음
      changeBottomNav(index, hasGesture: false); //받은 히스토리 페이지로 이동..!, 페이지 추가는 X
      return false;
    }
  }
}
