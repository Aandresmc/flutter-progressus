import 'package:flutter/material.dart';
import 'package:login_progressus/models/userModel.dart';
import 'package:login_progressus/providers/users_provider.dart';

class ListUsers extends StatefulWidget {
  ListUsers({Key key}) : super(key: key);
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  final userProvider = new UserProvider();
  List<UserModel> _users = [];
  double _height;
  double _width;

  List UsersList = [];

  @override
  Widget build(BuildContext context) {
    final String _token = ModalRoute.of(context).settings.arguments;

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    final textoBienvenida = Text('Listado de Usuarios!',
        style: TextStyle(
            fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white));

    return Scaffold(
        appBar: AppBar(
          title: textoBienvenida,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(
          child: FutureBuilder(
            future: userProvider.users(_token),
            builder: (BuildContext context,
                AsyncSnapshot<List<UserModel>> snapshot) {
              if (snapshot.hasData) {
                _users = snapshot.data;
                return ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  itemCount: _users.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple[100],
                        child: Text(
                          _users[index].nombre[0],
                          style: TextStyle(color: Colors.black54),
                        )),
                    title: Text(_users[index].nombre),
                    subtitle: Text(_users[index].correo),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
