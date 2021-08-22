import 'package:flutter/material.dart';
import 'package:untitled1/pages/login_page.dart';
import 'package:untitled1/pages/signup_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignupPage());
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
