import 'package:get/get.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';


class SignUpController extends GetxController {
  bool _RegistrationInProgress = false;

  String failedMessage = '';
  String successMessage = "";
  bool get RegistrationInProgress => _RegistrationInProgress;

  Future<bool> registration(String email, String password,String firstName,String lastName,String mobile) async {
    _RegistrationInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller().postRequest(Urls.registration,
        body: {
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
          'mobile': mobile,
        },
        );
    _RegistrationInProgress = false;
    update();
    if (response.isSuccess) {
     return true;
    }
    update();
    return false;
  }
}
// can't work why ?