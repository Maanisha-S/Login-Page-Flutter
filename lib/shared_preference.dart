import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('email', user.email);
    prefs.setString('phone', user.password);

    prefs.setString('token', user.token);
    return prefs.commit();
  }

  // Future<User> getUser() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   String? email = prefs.getString("email");
  //   String password = prefs.getString("password");
  //
  //   String token = prefs.getString("token");
  //
  //   return User(
  //     email: email,
  //     password: password,
  //     token: token,
  //   );
  // }
}
