import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/avatar_widget.dart';
import 'package:instagram_clone/src/function/random_image.dart';

class ActiveHistory extends StatelessWidget {
  const ActiveHistory({Key? key}) : super(key: key);

  Widget _activeItemOne() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          AvatarWidget(
            thumbPath: randomUserImage('men'),
            type: AvatarType.TYPE2,
            size: 40,
          ),
          const SizedBox(width: 10,),
          const Expanded(
            child: Text.rich( //여러 스타일의 글자를 적을 수 있음
              TextSpan(
                text: '재엽님',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                  text: '님이 회원님의 게시물을 좋아합니다.',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: '5일전',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ]
              )
            ),
          )
        ],
      ),
    );
  }

  Widget _newRecentlyActiveView(String date){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:[
          Text(
            date,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15,),
          _activeItemOne(),
          _activeItemOne(),
          _activeItemOne(),
          _activeItemOne(),
          _activeItemOne(),
        ],
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
          '활동',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _newRecentlyActiveView('오늘'),
            _newRecentlyActiveView('이번주'),
            _newRecentlyActiveView('이번달'),
          ],
        ),
      ),
    );
  }
}
