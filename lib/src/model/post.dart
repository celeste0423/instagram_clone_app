import 'package:instagram_clone/src/model/instagram_user.dart';

class Post {
  final String? thumbnail;
  final String? description;
  final String? id;
  final int? likeCount;
  final IUser? userInfo;
  final String? uid;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  Post({
    this.id,
    this.thumbnail,
    this.description,
    this.likeCount,
    this.userInfo,
    this.uid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Post.init(IUser userInfo) {
    var time = DateTime.now();
    return Post(
      thumbnail: '',
      userInfo: userInfo,
      uid: userInfo.uid,
      description: '',
      createdAt: time,
      updatedAt: time,
    );
  }

  factory Post.fromJson(String docId, Map<String, dynamic> json) {
    return Post(
      id: json['id'] == null ? '' : json['id'] as String?,
      thumbnail: json['thumbnail'] == null ? '' : json['thumbnail'] as String?,
      description:
          json['description'] == null ? '' : json['description'] as String?,
      likeCount: json['likeCount'] == null ? 0 : json['likeCount'] as int?,
      userInfo:
          json['userInfo'] == null ? null : IUser.fromJson(json['userInfo']),
      uid: json['uid'] == null ? '' : json['uid'] as String?,
      createdAt: json['createdAt'] == null
          ? DateTime.now()
          : json['createdAt'].toDate(),
      updatedAt: json['updatedAt'] == null
          ? DateTime.now()
          : json['updatedAt'].toDate(),
      deletedAt: json['deletedAt'] == null ? null : json['deletedAt'].toDate(),
    );
  }

  Post copyWith({
    String? thumbnail,
    String? description,
    String? id,
    int? likeCount,
    IUser? userInfo,
    String? uid,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Post(
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
      id: id ?? this.id,
      likeCount: likeCount ?? this.likeCount,
      userInfo: userInfo ?? this.userInfo,
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'thumbnail': thumbnail,
      'description': description,
      'likeCount': likeCount,
      'userInfo': userInfo!.toMap(),
      'uid': uid,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }
}
