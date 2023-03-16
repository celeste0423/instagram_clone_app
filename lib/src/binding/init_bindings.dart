import 'package:get/get.dart';
import 'package:instagram_clone/src/controller/bottom_nav_controller.dart';

import '../controller/auth_controller.dart';
import '../controller/home_controller.dart';
import '../controller/mypage_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    //원래는 다 사용하고 난 컨트롤러는 자동으로 메모리에서 제거됨
    //permanent속성을 켜주게 되면 다 사용해도 계속해서 남아있음
    //제거되지 않는 컨트롤러 생성 가능
    //GetXService를 extends해서 사용도 가능
    Get.put(BottomNavController(), permanent: true);
    //앱이 종료되는 시점까지 BottomNavController가 살아있도록 함
    Get.put(AuthController(), permanent: true); //로그인 담당도 실햄되게 함
  }

  static additionalBinding() {
    Get.put(MypageController(), permanent: true);
    Get.put(HomeController(), permanent: true);
  }
}
