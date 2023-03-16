import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/avatar_widget.dart';
import 'package:instagram_clone/src/components/image_data.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../model/post.dart';

class PostWidget extends StatelessWidget {
  final Post post; //코드 실행의 결과로 선언되는 값 => final 둘다 변경은 불가능
  const PostWidget({Key? key, required this.post}) : super(key: key);

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AvatarWidget(
              thumbPath: post.userInfo!.thumbnail!,
              type: AvatarType.TYPE3,
              nickname: post.userInfo!.nickname!,
              size: 35),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageData(
                IconsPath.postMoreIcon,
                width: 40,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _image() {
    return CachedNetworkImage(
      // imageUrl: randomUserImage('men'),
      imageUrl: post.thumbnail!,
      width: Get.width,
      height: Get.width,
      fit: BoxFit.cover,
    );
  }

  Widget _infoCount() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageData(IconsPath.likeOffIcon, width: 70),
              const SizedBox(width: 15),
              ImageData(IconsPath.replyIcon, width: 65),
              const SizedBox(width: 15),
              ImageData(IconsPath.directMessage, width: 60),
            ],
          ),
          ImageData(IconsPath.bookMarkOffIcon, width: 55),
        ],
      ),
    );
  }

  Widget _infoDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '좋아요 ${post.likeCount ?? 0}개', //널일경우 0으로
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          ExpandableText(
            //펼쳐지는 텍스트
            post.description ?? '',
            prefixText: post.userInfo!.nickname!,
            prefixStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            onPrefixTap: () {},
            expandText: '더보기',
            collapseText: '접기',
            maxLines: 3,
            expandOnTextTap: true,
            collapseOnTextTap: true,
            linkColor: Colors.grey,
          )
        ],
      ),
    );
  }

  Widget _replyTextBtn() {
    return GestureDetector(
        onTap: () {},
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            '댓글 199개 모두 보기',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ));
  }

  Widget _dateAgo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(timeago.format(post.createdAt!),
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 11,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(),
          const SizedBox(
            height: 10,
          ),
          _image(),
          const SizedBox(
            height: 15,
          ),
          _infoCount(),
          const SizedBox(
            height: 10,
          ),
          _infoDescription(),
          const SizedBox(
            height: 5,
          ),
          _replyTextBtn(),
          const SizedBox(
            height: 5,
          ),
          _dateAgo(),
        ],
      ),
    );
  }
}
