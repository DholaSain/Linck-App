import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:linkhead/Models/linksModel.dart';
import 'package:linkhead/Models/userModel.dart';

class DataBase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createUser(UserModel _userModel) async {
    try {
      await _firestore.collection("users").doc(_userModel.userName).set({
        "name": _userModel.name,
        "userName": _userModel.userName,
        "email": _userModel.email,
        "description": _userModel.description,
        "imageUrl": _userModel.imageUrl,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<UserModel> getUser(String userName) async {
    try {
      DocumentSnapshot _docSnapShot =
          await _firestore.collection("users").doc(userName).get();
      return UserModel.fromDocumentSnapShot(_docSnapShot);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<UserModel?> userStreamm(String userName) {
    return _firestore
        .collection('users')
        .doc(userName)
        .snapshots()
        .map((DocumentSnapshot documentSnapshot) {
      List<UserModel> retVal = [];
      var data = documentSnapshot.data() as Map<String, dynamic>;
      data.forEach((key, value) {
        retVal.add(UserModel.fromDocumentSnapShot(value));
      });
    });
  }

  Future<void> updateProfilePic(String userName, String imageUrl) async {
    try {
      await _firestore
          .collection("users")
          .doc(userName)
          .update({"imageUrl": imageUrl});
      print('Image uploaded.');
    } catch (e) {
      print('Image Upload Error: ${e.toString()}');
      Get.snackbar("Error in Image Uploading", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> addSocialLink(
      String linkName, String link, String userName) async {
    try {
      await _firestore
          .collection('users')
          .doc(userName)
          .collection('socialLinks')
          .doc(linkName)
          .set({
        'linkName': linkName,
        'link': link,
      });
      Get.snackbar("Succefully Added", link,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xff00ff00));
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error Adding Link", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> addCustomLink(
      String linkName, String link, String userName) async {
    try {
      await _firestore
          .collection('users')
          .doc(userName)
          .collection('customLinks')
          .doc(linkName)
          .set({
        'linkName': linkName,
        'link': link,
      });
      Get.snackbar("Succefully Added", link,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xff00ff00));
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error Adding Link", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Stream<List<SocialLinksModel>> socialLinksStream(String userName) {
    return _firestore
        .collection('users')
        .doc(userName)
        .collection('socialLinks')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<SocialLinksModel> retVal = [];
      querySnapshot.docs.forEach((element) {
        retVal.add(SocialLinksModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<CustomLinksModel>> customLinksStream(String userName) {
    return _firestore
        .collection('users')
        .doc(userName)
        .collection('customLinks')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<CustomLinksModel> retVal = [];
      querySnapshot.docs.forEach((element) {
        retVal.add(CustomLinksModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  // Stream<List<CustomLinksModel>> userStream(String userName) {
  //   return _firestore
  //       .collection('users')
  //       .doc(userName)
  //       .collection('customLinks')
  //       .snapshots()
  //       .map((QuerySnapshot querySnapshot) {
  //     List<CustomLinksModel> retVal = [];
  //     querySnapshot.docs.forEach((element) {
  //       retVal.add(CustomLinksModel.fromDocumentSnapshot(element));
  //     });
  //     return retVal;
  //   });
  // }

  // Future<bool> updateName(String uid, String newName) async {
  //   try {
  //     await _firestore.collection("users").doc(uid).update({'name': newName});
  //     return true;
  //   } catch (e) {
  //     print(e.toString());
  //     return false;
  //   }
  // }

  // Future<bool> addDescription(String uid, String newValue) async {
  //   try {
  //     print(
  //         "Upadting Description :::::::::::::::::::::::::::::::::::::::::::: Firebase");
  //     print("User ID " "$uid");
  //     await _firestore
  //         .collection("users")
  //         .doc(uid)
  //         .update({'description': newValue});
  //     return true;
  //   } catch (e) {
  //     print(e.toString());
  //     return false;
  //   }
  // }

  // Future<void> addSocialMediaThroughUserName(
  //   String uid,
  //   String socialMediaName,
  //   String socialMediaUserName,
  //   String socialMediaLink,
  // ) async {
  //   try {
  //     await _firestore
  //         .collection("users")
  //         .doc(uid)
  //         .collection("socialMedia")
  //         .doc(socialMediaName)
  //         .set({
  //       "userName": socialMediaUserName,
  //       "link": socialMediaLink,
  //       "pos": "",
  //       "socialMediaName": socialMediaName,
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //     rethrow;
  //   }
  // }

  // Future<void> addSocialMediaThroughLink(
  //     String uid, String socialMediaName, String socialMediaLink) async {
  //   try {
  //     print("adding SocialMediaLink :::::::::::::::::: Firebase");
  //     print("User ID " "$uid");
  //     print("Social Media Name " "$socialMediaName");
  //     await _firestore
  //         .collection("users")
  //         .doc(uid)
  //         .collection("socialMedia")
  //         .doc(socialMediaName)
  //         .set({
  //       "link": socialMediaLink,
  //       "pos": "",
  //       "socialMediaName": socialMediaName,
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //     rethrow;
  //   }
  // }

  // Future<void> updateSocialMediaThroughUserName(
  //   String uid,
  //   String socialMediaName,
  //   String socialMediaUserName,
  //   String socialMediaLink,
  // ) async {
  //   try {
  //     print("Updating SocialMediaLink :::::::::::::::::::: Firebase");
  //     print("User ID " "$uid");
  //     print("Social Media Name " "$socialMediaName");
  //     await _firestore
  //         .collection("users")
  //         .doc(uid)
  //         .collection("socialMedia")
  //         .doc(socialMediaName)
  //         .update({
  //       "userName": socialMediaUserName,
  //       "link": socialMediaLink,
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //     rethrow;
  //   }
  // }

  // Future<void> updateSocialMediaThroughLink(
  //     String uid, String socialMediaName, String socialMediaLink) async {
  //   try {
  //     print(
  //         "Updating SocialMediaLink :::::::::::::::::::::::::::::::::::::::::::: Firebase");
  //     print("User ID " "$uid");
  //     print("Social Media Name " "$socialMediaName");
  //     await _firestore
  //         .collection("users")
  //         .doc(uid)
  //         .collection("socialMedia")
  //         .doc(socialMediaName)
  //         .update({
  //       "link": socialMediaLink,
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //     rethrow;
  //   }
  // }

  // Future<bool> deleteSocialMediaFromFirebase(
  //     String uid, String socialMediaName) async {
  //   try {
  //     print("Deleting SocialMediaLink ::::::::::::::::::::::::::::::::");
  //     print("User ID " "$uid");
  //     print("Social Media Name " "$socialMediaName");
  //     await _firestore
  //         .collection("users")
  //         .doc(uid)
  //         .collection("socialMedia")
  //         .doc(socialMediaName)
  //         .delete();
  //     return true;
  //   } catch (e) {
  //     print(e.toString());
  //     return false;
  //   }
  // }

  // Future<String> getSocialMediaProfileLink(
  //     String uid, String socialMediaName) async {
  //   // print(
  //   //     "Checking $socialMediaName added is Firebase :::::::::::::::::::::::::");
  //   try {
  //     DocumentSnapshot _doc = await _firestore
  //         .collection("users")
  //         .doc(uid)
  //         .collection("socialMedia")
  //         .doc(socialMediaName)
  //         .get();
  //     String link = _doc['link'];

  //     return link;
  //   } catch (e) {
  //     print("Error in Profile Link Function Firebase");
  //     print(e.toString());
  //     return "";
  //   }
  // }

  // Future<String> getSocialMediaProfileUserName(
  //     String uid, String socialMediaName) async {
  //   print(
  //       "Getting $socialMediaName userName from Firebase :::::::::::::::::::::::::");
  //   try {
  //     DocumentSnapshot _doc = await _firestore
  //         .collection("users")
  //         .doc(uid)
  //         .collection("socialMedia")
  //         .doc(socialMediaName)
  //         .get();
  //     String userName = _doc['userName'];
  //     print("$socialMediaName userName ::::::::::::::::::::::: "
  //         "$userName ::::::::::::::::::::::::: Firebase");

  //     return userName;
  //   } catch (e) {
  //     print("Error in Profile UserName Function Firebase");
  //     return "";
  //   }
  // }

  // Future<bool> checkSocialMediaAdded(String uid, String socialMediaName) async {
  //   print(
  //       "Checking $socialMediaName added is Firebase ::::::::::::::::::::::::: firebase");
  //   try {
  //     DocumentSnapshot doc = await _firestore
  //         .collection("users")
  //         .doc(uid)
  //         .collection("socialMedia")
  //         .doc(socialMediaName.toLowerCase())
  //         .get();
  //     print("${doc.exists}" " exist :::::::::::::::::::");
  //     return doc.exists ? true : false;
  //   } catch (e) {
  //     print(e.toString());
  //     return false;
  //   }
  // }

  //Streams Come Here

  // Stream<UserModel> userStream(String uid) {
  //   return _firestore
  //       .collection('users')
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     UserModel retValue = UserModel();
  //     query.docs.forEach((element) {
  //       retValue.add(UserModel.fromDocumentSnapShot(element));
  //     });
  //     return retValue;
  //   });
  // }

}
