
import 'package:flutter/material.dart';
import 'package:login_progressus/pages/ListUsersPage.dart';
import 'package:login_progressus/pages/Login.dart';

class Routes {
  BuildContext context;

  Routes({@required this.context});

  routes() => {
        '/': (BuildContext context) => Login(),
        'users': (BuildContext context) => ListUsers(),
      };
}
