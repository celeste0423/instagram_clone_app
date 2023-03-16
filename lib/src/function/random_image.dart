import 'dart:math';

int getRandomNumber(int min, int max){
  final _random = Random();
  return min + _random.nextInt(max - min);
} //min과 max 사이에서 랜덤한 숫자를 추출


String randomUserImage(String genderType){
  return 'https://randomuser.me/api/portraits/${genderType}/${getRandomNumber(0, 100)}.jpg';
  //랜덤한 유저 사진을 반환
}

String randomNatureImage(){
  return 'https://picsum.photos/500/500?random=${getRandomNumber(0,100)}';
}

