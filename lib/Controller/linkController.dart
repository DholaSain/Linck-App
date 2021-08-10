import 'package:get/get.dart';
import 'package:linkhead/Controller/authController.dart';
import 'package:linkhead/Models/linksModel.dart';
import 'package:linkhead/Services/DatabaseService.dart';
import 'package:linkhead/main.dart';

class LinksController extends GetxController {
  Rxn<List<CustomLinksModel>> customLinksLink = Rxn<List<CustomLinksModel>>();
  Rxn<List<SocialLinksModel>> socialLinksLink = Rxn<List<SocialLinksModel>>();

  List<CustomLinksModel>? get customLinks => customLinksLink.value;
  List<SocialLinksModel>? get socialLinks => socialLinksLink.value;

  @override
  void onInit() {
    super.onInit();

    customLinksLink.bindStream(DataBase().customLinksStream(userName));
    socialLinksLink.bindStream(DataBase().socialLinksStream(userName));
  }
}
