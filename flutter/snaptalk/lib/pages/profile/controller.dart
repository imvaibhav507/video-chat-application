import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snaptalk/common/store/store.dart';

class ProfileController extends GetxController {

  ProfileController();

  void logout() async {
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }

}