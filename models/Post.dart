// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    this.posts,
  });

  List<PostElement> posts;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        posts: List<PostElement>.from(
            json["posts"].map((x) => PostElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
      };
}

class PostElement {
  PostElement({
    this.id,
    this.userId,
    this.postusername,
    this.description,
    this.photo,
    this.likes,
    this.comments,
    this.likeCount,
    this.createdAt,
    this.username,
    this.userphoto,
    this.usertype,
    this.lastComment,
    this.v,
  });

  String id;
  String userId;
  String postusername;
  String description;
  String photo;
  List<String> likes;
  List<Comment> comments;
  int likeCount;
  String createdAt;
  String username;
  String userphoto;
  String usertype;
  Comment lastComment;
  int v;

  factory PostElement.fromlastcommentJson(Map<String, dynamic> json) =>
      PostElement(
        id: json["_id"],
        userId: json["userId"]["_id"],
        description: json["description"],
        photo: json["photo"],
        likes: List<String>.from(json["likes"].map((x) => x)),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromlastcommentJson(x))),
        likeCount: json["likeCount"],
        createdAt: json["createdAt"],
        username: json["userId"]["username"],
        usertype: json["userId"]["role"],
        userphoto: json["userId"]["profile_image"],
        lastComment: Comment.fromJson(json),
        v: json["__v"],
      );
  factory PostElement.fromJson(Map<String, dynamic> json) => PostElement(
        id: json["_id"],
        userId: json["userId"]["_id"],
        description: json["description"],
        photo: json["photo"],
        likes: json["likes"] == null
            ? []
            : List<String>.from(json["likes"].map((x) => x)),
        comments: json["comments"] == null
            ? []
            : List<Comment>.from(
                json["comments"].map((x) => Comment.fromJson(x))),
        likeCount: json["likeCount"],
        createdAt: json["createdAt"], username: json["userId"]["username"],
        usertype: json["userId"]["role"],
        userphoto: json["userId"]["profile_image"],
        v: json["__v"],
      );
  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": postusername,
        "description": description,
        "photo": photo,

        "likeCount": likeCount,

      };
}
