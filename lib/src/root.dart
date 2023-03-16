import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/controller/auth_controller.dart';

import 'app.dart';
import 'model/instagram_user.dart';
import 'pages/login.dart';
import 'pages/signup_page.dart';

class Root extends GetView<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //StreamBuilder는 수시로 변하는 값에 사용
      //FutureBuilder는 일회성으로 변하는 값에 사용

      //초기 로그인 창 세팅
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext _, AsyncSnapshot<User?> user) { //user값 받아옴 snapshot에
        if (user.hasData) {
          //내부 파이어베이스 유저 정보 조회를 해야함
          //user.data.uid를 통해 받아올 것임
          return FutureBuilder<IUser?>(
            future: controller.loginUser(user.data!.uid), //auth_controller에 정의해놓음
            builder: (context, snapshot) {
              if(snapshot.hasData){
              return const App();
              }else{
                return Obx(()=> controller.user.value.uid != null
                //받은 컨트롤러의 유저 데이터가 이미 있을경우 앱으로, 아니면 회원가입창으로
                  ?const App()
                  : SignupPage(uid: user.data!.uid));
                //SignupPage에 uid 넣어줌, 구글로그인을 통해 받은 uid
              }
            }
          );
        } else {
          return const Login();
        }
      },
    );
  }
}
