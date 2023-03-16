import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/image_data.dart';
import 'package:instagram_clone/src/controller/bottom_nav_controller.dart';

import 'pages/active_history.dart';
import 'pages/home.dart';
import 'pages/mypage.dart';
import 'pages/search.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: controller.willPopAction, //뒤로가기 버튼을 눌렀을 때
        // Obx() 아래의 모든 위젯은 GetX()와 마찬가지로 controller에서 변경되는
        // 데이터를 실시간으로 반영할 수 있는 상태가 됩니다. 사용 방식은 거의 동일하지만
        // 차이가 있다면 GetX()와 달리 controller의 이름을 지정할 수가 없어서 Get.find() 방식으로 접근해야 합니다.
        child: Obx(
            () => Scaffold(
            body: IndexedStack(
              index: controller.pageIndex.value,
              children: [
                const Home(),//홈화면
                Navigator( //search 화면
                  key: controller.searchPageNavigationKey, //해당 키를 가지고 네비게이터 안쪽 키 처리 가능
                  onGenerateRoute: (routeSetting){ //플러터 내장 중첩 라우팅
                    return MaterialPageRoute(builder: (context) => const Search(),);
                  },
                ),
                Container(child: Text('Upload'),),
                const ActiveHistory(),//액티비티 창
                const MyPage(),//마이페이지
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed, //액티브때 고정
              showSelectedLabels: false, //라벨 안보이게
              showUnselectedLabels: false,
              currentIndex: controller.pageIndex.value,
              //controller내부의 pageIndex값을 이용해서 이동
              onTap: controller.changeBottomNav,
                //GetX를 이용하여 이동할것임
                //원래는 currentIndex값을 수정하여 페이지를 이동할 수 있도록 함
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.homeOff), //만든 아이콘 컴포넌트 불러오기
                  activeIcon: ImageData(IconsPath.homeOn),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.searchOff),
                  activeIcon: ImageData(IconsPath.searchOn),
                  label: 'search',
                ),
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.uploadIcon),
                  label: 'upload',
                ),
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.activeOff),
                  activeIcon: ImageData(IconsPath.activeOn),
                  label: 'active',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey
                    ),
                  ),
                  label: 'my',
                ),
              ],
            ),
          ),
        ),
      );
  }
}
