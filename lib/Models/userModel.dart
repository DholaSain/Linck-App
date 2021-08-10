// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? userName;
  String? email;
  String? description;
  String? imageUrl;

  UserModel({
    this.id,
    this.name,
    this.userName,
    this.email,
    this.description,
    this.imageUrl,
  });

  UserModel.fromDocumentSnapShot(DocumentSnapshot doc) {
    id = doc.id;
    name = doc['name'];
    userName = doc['userName'];
    email = doc['email'];
    description = doc['description'];
    imageUrl = doc['imageUrl'];
  }

  // void add(UserModel userModel) {}

  // UserModel.fromMap(DocumentSnapshot doc) {
  //   id = doc.id;
  //   name = doc['name'];
  //   userName = doc['userName'];
  //   email = doc['email'];
  //   description = doc['description'];
  //   imageUrl = doc['imageUrl'];
  // }
  // UserModel.fromMap(DocumentSnapshot map)
  //     : assert(map['userName'] != null),
  //       userName = map['userName'];
}
