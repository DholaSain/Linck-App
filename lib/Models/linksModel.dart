import 'package:cloud_firestore/cloud_firestore.dart';

class SocialLinksModel {
  String? linkName;
  String? link;

  SocialLinksModel({
    linkName,
    link,
  });

  SocialLinksModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    linkName = documentSnapshot.get('linkName');
    link = documentSnapshot.get('link');
  }
}

class CustomLinksModel {
  String? linkName;
  String? link;

  CustomLinksModel({
    linkName,
    link,
  });

  CustomLinksModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    linkName = documentSnapshot.get('linkName');
    link = documentSnapshot.get('link');
  }
}
