import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:instagram_clone/src/function/random_image.dart';
import 'package:quiver/iterables.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'search/search_focus.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  //2중 배열 각각이 사진한장
  List<List<int>> groupBox = [[], [], []];
  List<int> groupIndex = [0, 0, 0];

  @override
  void initState(){
    super.initState();
    for(var i = 0; i < 100; i++){ //작은 값을 찾아서 거기에 박스 추가해줌
      var gi = groupIndex.indexOf(min<int>(groupIndex)!);
      var size = 1;
      if(gi != 1){
        size = Random().nextInt(100) % 4 == 0 ? 2 : 1; //나온 숫자가 짝수면 0, 홀수면 1이 나오게, 랜덤 크기
      }
      groupBox[gi].add(size); //image박스들을 계속해서 더해줌
      //if문에 따라 사이즈가 랜덤으로 더해짐
      groupIndex[gi] += size;
    }
  }


  Widget _appbar(){
    return SafeArea( //상태표시줄, 하단 바 영역을 지켜주는
      //SafeArea안에 넣게 되면 위아래에 겹치지 않음
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (){
                // Get.to(SearchFocus()); //기존 방식으로 바꿨기 때문에 get 대체
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchFocus()));
                },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                margin: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xffefefef),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    Text(
                      '검색',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff838383),
                      ),
                    )
                  ],
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: const Icon(Icons.location_pin),
          ),
        ],
      ),
    );
  }

  Widget _body(){
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(groupBox.length, (index) => Expanded(
            child: Column(
              children: List.generate(groupBox[index].length,
              (jndex) => Container( //2차원 배열이니까 새롭게 jndex추가
                height: Get.width * 0.33 * groupBox[index][jndex],
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
                  ),
                child: CachedNetworkImage(
                  imageUrl: randomNatureImage(),
                  fit: BoxFit.cover,
                ),
                )
              ),
            ),
          )
        ).toList()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appbar(),
          Expanded(child: _body(),),
        ],
      )
    );
  }
}
