import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkhead/Controller/userController.dart';
import 'package:linkhead/Models/userModel.dart';
import 'package:linkhead/Screens/HomeScreen.dart';
import 'package:linkhead/Services/DatabaseService.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> _firebaseUser = Rxn<User>();

  User? get userGetter => _firebaseUser.value;

  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  Future<String> logInWithGoogle() async {
    String retVal = 'Error';
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        // 'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    UserModel _userModel = UserModel();
    print('waitng for login');
    try {
      GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth =
          await _googleUser!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      UserCredential authResult = await _auth.signInWithCredential(credential);
      if (authResult.additionalUserInfo!.isNewUser) {
        _userModel.id = authResult.user!.uid;
        _userModel.email = authResult.user!.email;
        _userModel.name = authResult.user!.displayName;
        _userModel.imageUrl = authResult.user!.photoURL;
        _userModel.description = "LinkHead User";
        _userModel.userName = authResult.user!.email!.split("@")[0];
        DataBase().createUser(_userModel);
      }
      await Get.offAllNamed('/home');
      retVal = 'success';
    } catch (e) {
      Get.snackbar("Error in Signing In", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
      print(e);
      retVal = e.toString();
    }
    return retVal;
  }

  Future<void> createUser(String name, String email, String password) async {
    String userEmail = email;
    List<String> usersName = userEmail.split("@");

    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);

      UserModel _userModel = UserModel(
        id: _authResult.user!.uid,
        name: name,
        userName: usersName[0],
        email: email,
        description: "LinkHead User",
        imageUrl:
            'https://www.unigreet.com/wp-content/uploads/2020/12/smiley-dp.jpg',
      );

      if (await DataBase().createUser(_userModel)) {
        Get.find<UserController>().userSetter = _userModel;
        Get.snackbar(
          "SignedUp",
          'Account Created Successfuly',
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAll(HomeScreen());
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error in Creating Account", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> logIn(String email, String password) async {
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.put(UserController());
      Get.find<UserController>().userSetter =
          await DataBase().getUser(_authResult.user!.email!.split("@")[0]);
      Get.snackbar("Signedin", "Signedin Successfully",
          snackPosition: SnackPosition.BOTTOM);
      Get.offAllNamed('/home');
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error in Signing In", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().clear();
      await Get.offAllNamed('/signin');
    } catch (e) {
      Get.snackbar("Error in Signing Out", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
