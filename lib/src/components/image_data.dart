//이미지 가져오는 걸 쳐리해주는 컴포넌트

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageData extends StatelessWidget {
  String icon;
  final double? width;
  ImageData(this.icon, {Key? key, this.width = 55}) : super(key: key);
  //width 값이 없을때는 default 로 55

  @override
  Widget build(BuildContext context) {
    return Image.asset(icon, width: width! / Get.mediaQuery.devicePixelRatio,);
    // 이미지의 가로 width값을 디바이스의 픽셀 비율(getX를 통해 구한)로 나눠줌으로써
    // 아이콘의 비율이 디바이스에 알맞은 비율로 들어갈 수 있도록 함함
    }
  }

  class IconsPath{ //아이콘 이미지의 위치도 함수로 받기 위해 포함시킴
    //원래는 svg파일로 바텀네비게이션 만드는 게 정석
    //코드의 길이를 줄일 수 있음

    //값을 공유하여 사용하고 싶을 때 static 사용, 어디서 불러와도 같은 값을 가져옴
    //값이 수정되는 것을 막고 싶으면 const를 추가할 것
    static String get homeOff => 'assets/images/bottom_nav_home_off_icon.jpg';
    static String get homeOn => 'assets/images/bottom_nav_home_on_icon.jpg';
    static String get searchOff => 'assets/images/bottom_nav_search_off_icon.jpg';
    static String get searchOn => 'assets/images/bottom_nav_search_on_icon.jpg';
    static String get uploadIcon => 'assets/images/bottom_nav_upload_icon.jpg';
    static String get activeOff => 'assets/images/bottom_nav_active_off_icon.jpg';
    static String get activeOn => 'assets/images/bottom_nav_active_on_icon.jpg';

    static String get logo => 'assets/images/logo.jpg';
    static String get directMessage => 'assets/images/direct_msg_icon.jpg';
    static String get plusIcon => 'assets/images/plus_icon.png';
    static String get postMoreIcon => 'assets/images/more_icon.jpg';
    static String get likeOffIcon => 'assets/images/like_off_icon.jpg';
    static String get likeOnIcon => 'assets/images/like_on_icon.jpg';
    static String get replyIcon => 'assets/images/reply_icon.jpg';
    static String get bookMarkOffIcon => 'assets/images/book_mark_off_icon.jpg';
    static String get bookMarkOnIcon => 'assets/images/book_mark_on_icon.jpg';
    static String get backBtnIcon => 'assets/images/back_icon.jpg';
    static String get menuIcon => 'assets/images/menu_icon.jpg';
    static String get addFriend => 'assets/images/add_friend_icon.jpg';
    static String get gridViewOff => 'assets/images/grid_view_off_icon.jpg';
    static String get gridViewOn => 'assets/images/grid_view_on_icon.jpg';
    static String get myTagImageOff => 'assets/images/my_tag_image_off_icon.jpg';
    static String get myTagImageOn => 'assets/images/my_tag_image_on_icon.jpg';
    static String get nextImage => 'assets/images/upload_next_icon.jpg';
    static String get closeImage => 'assets/images/close_icon.jpg';
    static String get imageSelectIcon => 'assets/images/image_select_icon.jpg';
    static String get cameraIcon => 'assets/images/camera_icon.jpg';
    static String get uploadComplete => 'assets/images/upload_complete_icon.jpg';
    static String get mypageBottomSheet01 =>
        'assets/images/mypage_bottom_sheet_01.jpg';
    static String get mypageBottomSheet02 =>
        'assets/images/mypage_bottom_sheet_02.jpg';
    static String get mypageBottomSheet03 =>
        'assets/images/mypage_bottom_sheet_03.jpg';
    static String get mypageBottomSheet04 =>
        'assets/images/mypage_bottom_sheet_04.jpg';
    static String get mypageBottomSheet05 =>
        'assets/images/mypage_bottom_sheet_05.jpg';
    static String get mypageBottomSheetSetting01 =>
        'assets/images/mypage_bottom_sheet_setting_01.jpg';
    static String get mypageBottomSheetSetting02 =>
        'assets/images/mypage_bottom_sheet_setting_02.jpg';
    static String get mypageBottomSheetSetting03 =>
        'assets/images/mypage_bottom_sheet_setting_03.jpg';
    static String get mypageBottomSheetSetting04 =>
        'assets/images/mypage_bottom_sheet_setting_04.jpg';
    static String get mypageBottomSheetSetting05 =>
        'assets/images/mypage_bottom_sheet_setting_05.jpg';
    static String get mypageBottomSheetSetting06 =>
        'assets/images/mypage_bottom_sheet_setting_06.jpg';
    static String get mypageBottomSheetSetting07 =>
        'assets/images/mypage_bottom_sheet_setting_07.jpg';
  }

