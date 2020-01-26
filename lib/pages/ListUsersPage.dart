import 'package:flutter/material.dart';
import 'package:login_progressus/models/userModel.dart';

class ListUsers extends StatefulWidget {
  ListUsers({Key key}) : super(key: key);
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  double _height;
  double _width;

  List UsersList = [];

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    final List<UserModel> navigatorParamData =
        ModalRoute.of(context).settings.arguments;

    if (navigatorParamData != null) {
      UsersList = navigatorParamData;
    }

    final double itemHeight = (_height - kToolbarHeight - 24) / 2;
    final double itemWidth = _width / 2;
    return Scaffold(
      body: Container(
      child: Center(
        child: Text('Listado'),
        ),
      ));

  }
}
