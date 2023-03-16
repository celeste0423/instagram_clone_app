import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/avatar_widget.dart';
import 'package:instagram_clone/src/components/image_data.dart';
import 'package:instagram_clone/src/components/post_widget.dart';
import 'package:instagram_clone/src/controller/home_controller.dart';
import 'package:instagram_clone/src/function/random_image.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  PreferredSizeWidget _appBarWidget() {
    return AppBar(
      elevation: 0,
      title: ImageData(IconsPath.logo, width: 270),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ImageData(
              IconsPath.likeOffIcon,
              width: 60,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(
              IconsPath.directMessage,
              width: 60,
            ),
          ),
        ),
      ],
    );
  }

  Widget _myStory() {
    return Stack(
      children: [
        AvatarWidget(
            thumbPath:
                'https://scontent-ssn1-1.cdninstagram.com/v/t51.2885-19/328403807_516040393750328_7384883027761203578_n.jpg?stp=dst-jpg_s320x320&_nc_ht=scontent-ssn1-1.cdninstagram.com&_nc_cat=108&_nc_ohc=xCWMFcpfNsIAX_bsv1H&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfDK6G9FlgXLJ7LkQyqgeIvtWMi21RDbrgGFMUKXYsYVDw&oe=6413A930&_nc_sid=8fd12b',
            type: AvatarType.TYPE2,
            size: 79),
        Positioned(
            //위치 고정
            right: 10,
            bottom: 10,
            child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    )),
                child: const Center(
                    child: Text(
                  '+',
                  style:
                      TextStyle(fontSize: 20, color: Colors.white, height: 1.1),
                )))),
      ],
    );
  }

  Widget _storyBoardList() {
    return SingleChildScrollView(
      //한줄 스크롤
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        const SizedBox(width: 5),
        _myStory(),
        const SizedBox(width: 5),
        ...List.generate(
          //...은 리스트 배열을 나열하겠다는 뜻,
          // Row의 각 child요소로 들어가게 됨
          100,
          (index) => AvatarWidget(
            thumbPath: randomUserImage('men'),
            type: AvatarType.TYPE1,
          ),
        )
      ]),
    );
  }

  Widget _postList() {
    return Obx(
      () => Column(
        children: List.generate(controller.postList.length,
            (index) => PostWidget(post: controller.postList[index])).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBarWidget(),
        body: ListView(
          children: [
            _storyBoardList(),
            _postList(),
          ],
        ));
  }
}
