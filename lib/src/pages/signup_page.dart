import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/src/model/instagram_user.dart';

import '../controller/auth_controller.dart';

//회원가입 페이지
class SignupPage extends StatefulWidget {
  final String uid;
  const SignupPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  TextEditingController nicknameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  //텍스트 편집용 컨트롤러,
  //stful위젯(setState)과 병행햐며 사용
  final ImagePicker _picker = ImagePicker();
  XFile? thumbnailXFile; //외부 파일을 가져오는

  Widget _avatar(){
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            width: 100,
            height: 100,
            child: thumbnailXFile != null
              ? Image.file(
                  File(thumbnailXFile!.path),
                  fit: BoxFit.cover,
                )
              : Image.asset(
                    'assets/images/default_image.png',
                    fit: BoxFit.cover,
                ),
          ),
        ),
        const SizedBox(height: 15,),
        ElevatedButton(
          onPressed: () async{
            thumbnailXFile = await _picker.pickImage( //future로 감싸져있기 때문에 await 필요
              source: ImageSource.gallery,
              imageQuality: 10, //안쓰면 서버의 용량을 아주 낭비하게 될 수도...
            );
            setState(() {});
          },
          child: const Text(
            '이미지 변경',
          ),
        )
      ],
    );
  }

  Widget _nickname(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        controller: nicknameController,
        //컨트롤러로 텍스트를 반환함
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: '닉네임',
        ),
      ),
    );
  }

  Widget _description(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        controller: descriptionController,
        //컨트롤러로 텍스트를 반환함
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: '설명',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '회원가입',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30,),
            _avatar(),
            const SizedBox(height: 30,),
            _nickname(),
            const SizedBox(height: 30,),
            _description(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        child: ElevatedButton(
          onPressed: () async{
            //validation을 원래 해줘야함 => 입력해야할 제한조건을 마련해줘야함
            var signupUser = IUser(
              uid: widget.uid, //해당 위젯에서 가져옴
              nickname: nicknameController.text,
              description: descriptionController.text,
            );
            AuthController.to.signup(signupUser, thumbnailXFile);
            //정의해놓은 auth_controller 사용
          },
          child: const Text(
            '회원가입',
          ),
        ),
      ),
    );
  }
}
