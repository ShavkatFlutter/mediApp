import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String username;
  final String name;
  final String comment;
  List likes;
  final commentTime;
  final File profilePhoto;
  final String uid;
  final String id;

  Comment({
    required this.username,
    required this.name,
    required this.comment,
    required this.likes,
    required this.commentTime,
    required this.profilePhoto,
    required this.uid,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "comment": comment,
        "likes": [],
        "commentTime": commentTime,
        "profilePhoto": username,
        "uid": uid,
        "id": id,
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
      username: snapshot["username"],
      name: snapshot["name"],
      comment: snapshot["comment"],
      likes: snapshot["likes"],
      commentTime: snapshot["commentTime"],
      profilePhoto: snapshot["profilePhoto"],
      uid: snapshot["uid"],
      id: snapshot["id"],
    );
  }
}
