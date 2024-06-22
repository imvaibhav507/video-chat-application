import 'package:snaptalk/common/entities/entities.dart';
import 'package:snaptalk/common/utils/utils.dart';

class ContactAPI {

  /// refresh
  static Future<ContactResponseEntity> post_contact() async {
    var response = await HttpUtil().post(
      'api/contacts',
    );
    return ContactResponseEntity.fromJson(response);
  }


}
