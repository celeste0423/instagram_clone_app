import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/avatar_widget.dart';
import 'package:instagram_clone/src/components/image_data.dart';
import 'package:instagram_clone/src/components/user_card.dart';
import 'package:instagram_clone/src/controller/auth_controller.dart';
import 'package:instagram_clone/src/controller/mypage_controller.dart';
import 'package:instagram_clone/src/function/random_image.dart';

class MyPage extends GetView<MypageController> {
  //MypageController에 있는 controller를 이용하는 샷을 getview로 표현
  const MyPage({Key? key}) : super(key: key);

  Widget  _statisticsOne(String title, int value){
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _information() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AvatarWidget(
                  thumbPath: controller.targetUser.value.thumbnail!,
                  type: AvatarType.TYPE3,
                  size: 80,
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(child: _statisticsOne('포스트', 15)),
                      Expanded(child: _statisticsOne('팔로워', 515)),
                      Expanded(child: _statisticsOne('팔로잉', 513)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Text(
              controller.targetUser.value.description!,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _menu(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: const Color(0xffdedede))
              ),
              child: const Text(
                '프로필 편집',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: const Color(0xffdedede)),
              color: Color(0xffefefef)
            ),
            child: ImageData(
              IconsPath.addFriend,
            ),
          )
        ],
      ),
    );
  }

  Widget _discoverPeople(){
    return Column(
      children: [
        const Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '회원님을 위한 추천',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                '모두 보기',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: List.generate(10, (index) =>
                UserCard(UserId: '사람$index', description:'친구$index님이 팔로우합니다.')).toList(),
          ),
        ),
      ],
    );
  }

  Widget _tabMenu(){
    return TabBar(
      controller: controller.tabController,
      indicatorColor: Colors.black,
      indicatorWeight: 1,
      tabs: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ImageData(
            IconsPath.gridViewOn,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ImageData(
            IconsPath.myTagImageOff,
          ),
        )
      ],
    );
  }

  Widget _tabView(){
    return SizedBox(
      height: 1650,
      child: TabBarView(
        controller: controller.tabController,
        children: [
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 100,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
              itemBuilder: (BuildContext context, int index){
                return Image.network(randomNatureImage(), width: 50, height: 50,);
              }
          ),
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 100,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
              itemBuilder: (BuildContext context, int index){
                return Image.network(randomNatureImage(),width: 50, height: 50,);
              }
          ),
        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Obx(() => Text(
                //해당 창을 친구 프로필 볼때도 재활용하기
                // 위해 창을 열었을때 컨트롤러 내부에서 불러옴
                controller.targetUser.value.nickname!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 5,),
            const Icon(Icons.keyboard_arrow_down, color: Colors.black,size: 25,),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: (){

            },
            child: ImageData(
              IconsPath.uploadIcon,
              width: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: (){

              },
              child: ImageData(
                IconsPath.menuIcon,
                width: 50,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _information(),
            _menu(),
            _discoverPeople(),
            const SizedBox(height: 20,),
            _tabMenu(),
            _tabView(),
          ],
        ),
      )
    );
  }
}
