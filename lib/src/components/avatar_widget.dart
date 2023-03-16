import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum AvatarType{TYPE1, TYPE2, TYPE3} //아바타의 상태에 따라 타입을 받기 위해
//enum으로 받음

class AvatarWidget extends StatelessWidget {
  bool? hasStory;//스토리가 있으면 테두리 들어감
  String thumbPath;
  String? nickname;
  AvatarType type;
  double? size;
  //이렇게 5가지의 값을 받을 수 있도록 함

  AvatarWidget({
    Key? key,
    this.hasStory,
    required this.thumbPath,
    this.nickname,
    required this.type,
    this.size = 75,
  }) : super(key: key);

  Widget type1Widget(){
    return Container( //container를 색칠하고 child에 이미지를 넣음으로써 테두리를 만듦
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: const BoxDecoration(
        gradient: LinearGradient( //그라디언트
          begin: Alignment.topRight,  //대각선 위부터
          end: Alignment.bottomLeft, //대각선아래로 그라디언트
          stops: [
            0.2,
            0.4,
            0.7,
            1.0,
          ],
          colors: [
            Colors.pinkAccent,
            Colors.purple,
            Colors.orange,
            Colors.deepOrangeAccent,
          ],
        ),
        shape: BoxShape.circle
      ),
      child: type2Widget(),
    );
  }

  Widget type2Widget(){
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size!),
        child: SizedBox(
          width: size,
          height: size,
          child: CachedNetworkImage( //인터넷의 이미지를 가져와서 캐시에 저장해주는
              imageUrl: thumbPath,
              fit: BoxFit.cover
          ),
        ),
      ),
    );
  }

  Widget type3Widget(){
    return Row(
      children: [
        type1Widget(),
        Text(
          nickname
            ??'',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    switch(type){
      case AvatarType.TYPE1: //그라데이션 있는 놈
        return type1Widget();
      case AvatarType.TYPE2:
        return type2Widget();
      case AvatarType.TYPE3:
        return type3Widget();
        break;
    }
    return Container();
  }
}
