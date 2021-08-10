import 'package:get/get.dart';
import 'package:linkhead/Controller/authController.dart';
import 'package:linkhead/Models/userModel.dart';
import 'package:linkhead/Services/DatabaseService.dart';
import 'package:linkhead/main.dart';

class UserController extends GetxController {
  Rxn<UserModel> _userModel = Rxn<UserModel>();

  UserModel? get userGetter => _userModel.value;

  @override
  void onInit() {
    super.onInit();

    _userModel.bindStream(Stream.fromFuture(DataBase().getUser(userName)));
  }

  set userSetter(UserModel value) {
    this._userModel.value = value;
  }

  void clear() {
    _userModel.value = UserModel();
  }
}
