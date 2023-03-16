import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/instagram_user.dart';

class UserRepository {//유저 값 저장소 repository = 저장소
  static Future<IUser?> loginUserByUid(String uid) async {
    print(uid);
    var data = await FirebaseFirestore.instance //파이어스토어의 규칙
        .collection('users') //콜렉션은 users라는 데이터베이스 참조, 없으면 만들어짐
        .where('uid', isEqualTo: uid)
        .get();
    //해당 위치의 값을 얻어 data에 넣음

    if(data.size == 0){
      print('데이터 없음');
      return null;
    }else{//데이터 있음
      // print(data.docs.first.data());
      return IUser.fromJson(data.docs.first.data());
      // return true; //현재는 불을 반환하므로 //이제는 아님 ㅎㅎ
    }
  }

  static Future<bool> signup(IUser user) async{
    try {
      await FirebaseFirestore.instance
          .collection('users').add(user.toMap());
      //add를 할때는 map으로 넣어야 하기에 toMap함수를 만들어서 사용하겠음
      return true;
    }catch(e){//오루가 날 떼는
      return false;
    }
  }
}
