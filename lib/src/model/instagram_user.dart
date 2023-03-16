class IUser{ //인스타그램 유저로 지칭 ㅎㅎ
  //우리 앱 많의 유저 정보 저장 틀
  String? uid;
  String? nickname;
  String? thumbnail;
  String? description;
  IUser({
    this.uid,
    this.nickname,
    this.thumbnail,
    this.description,
  });//함수를 어떻게 받아올 지

  factory IUser.fromJson(Map<String, dynamic> json){
    return IUser(
      uid : json['uid'] == null ? '' : json['uid'] as String, //null이면 빈값, 아니면 String
      nickname : json['nickname'] == null ? '' : json['nickname'] as String,
      thumbnail : json['thumbnail'] == null ? '' : json['thumbnail'] as String,
      description : json['description'] == null ? '' : json['description'] as String,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'uid' : uid,
      'nickname' : nickname,
      'thumbnail' : thumbnail,
      'description' : description,
    };
  }

  IUser copyWith({
    String? uid,
    String? nickname,
    String? thumbnail,
    String? description,
    }){
      return IUser(
        uid: uid ?? this.uid, //널이면 기존의 값 유지
        nickname: nickname ?? this.nickname,
        thumbnail: thumbnail ?? this.thumbnail,
        description: description ?? this.description,
      );
    }
  }