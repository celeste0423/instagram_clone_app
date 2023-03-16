import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:instagram_clone/firebase_options.dart';
import 'package:instagram_clone/src/binding/init_bindings.dart';

import 'src/root.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();//파이어베이스 시작 전 세팅
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
    //어떤 플랫폼인지에 따라 어떻게 될 지 설정
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( //getX
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black),
        )
      ),
      initialBinding: InitBinding(),//pageindex 컨트롤러 메인 함수 시작하자 마자 처리
      home: const Root(),
    );
  }
}

