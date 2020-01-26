import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double _height;
  double _width;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    final double itemHeight = (_height - kToolbarHeight - 24) / 3;
    final double itemWidth = _width / 2;
    final emailField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Correo",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Contraseña",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.pinkAccent[200],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: Text('Bienvenido!',
                          style: TextStyle(
                              fontFamily: 'Montserrat', fontSize: 35.0)),
                      margin: EdgeInsets.all(30)),
                  SizedBox(
                    height: itemHeight,
                    child: Image.asset(
                      "assets/meditation.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 45.0),
                  emailField,
                  SizedBox(height: 25.0),
                  passwordField,
                  SizedBox(
                    height: 35.0,
                  ),
                  loginButon,
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
