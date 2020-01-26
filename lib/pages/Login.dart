import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_progressus/models/userModel.dart';
import 'package:login_progressus/providers/users_provider.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final userProvider = new UserProvider();
  var _showCircularProgress = false;
  var _passwordVisible = false;
  var _passwordConfirmVisible = false;
  var _iniciarSesion = true;

  String _password;
  String _email;
  String _confirm_password;
  String _name;

  double _height;
  double _width;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    final double itemHeight = (_height - kToolbarHeight - 24) / 3;
    final double itemWidth = _width / 2;

    Future _mensajeError(BuildContext context, _message) {
      return showDialog(
        builder: (context) {
          return AlertDialog(
            title: Text('Mensaje de Error'),
            content: Text(_message),
            actions: <Widget>[
              FlatButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        },
        context: context,
      );
    }

    /// widgets ---->
    var emailField = TextFormField(
      obscureText: false,
      style: style,
      onSaved: (value) => _email = value,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Correo",
          hintText: "Correo",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    var passwordField = TextFormField(
      obscureText: !_passwordVisible,
      style: style,
      onSaved: (value) => _password = value,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Contraseña",
          hintText: "Contraseña",
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.black87,
            ),
            onPressed: () {
              setState(() => _passwordVisible = !_passwordVisible);
            },
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    var nameField = AnimatedOpacity(
        opacity: _iniciarSesion ? 0 : 1,
        duration: Duration(milliseconds: 1000),
        child: _iniciarSesion
            ? Container()
            : Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  obscureText: false,
                  style: style,
                  onSaved: (value) => _name = value,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      labelText: "Nombre",
                      hintText: "Nombre",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                )));

    var confirmPasswordField = AnimatedOpacity(
        opacity: _iniciarSesion ? 0 : 1,
        duration: Duration(milliseconds: 1000),
        child: _iniciarSesion
            ? Container()
            : Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  obscureText: !_passwordConfirmVisible,
                  style: style,
                  onSaved: (value) => _confirm_password = value,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      labelText: "Confirmar Contraseña",
                      hintText: "Contraseña",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black87,
                        ),
                        onPressed: () {
                          setState(() => _passwordConfirmVisible =
                              !_passwordConfirmVisible);
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                )));

    var loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.pinkAccent[200],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          setState(() => _showCircularProgress = true);
          // valida el estado del formulario.
          if (_formKey.currentState.validate()) {
            // guarda  los campos..
            _formKey.currentState.save();
            try {
              Map<String, dynamic> resp;

              if (_iniciarSesion) {
                resp = await userProvider
                    .login({"email": _email, "password": _password});
              } else {
                resp = await userProvider.register({
                  "email": _email,
                  "password": _password,
                  "c_password": _confirm_password,
                  "name": _name
                });
              }

              setState(() => _showCircularProgress = false);

              if (resp.containsKey('error')) {
                if (resp['error'] is String)
                  return _mensajeError(context, resp['error']);

                if (resp['error'].containsKey('email'))
                  return _mensajeError(context, resp['error']['email'][0]);

                if (resp['error'].containsKey('password'))
                  return _mensajeError(context, resp['error']['password'][0]);
              } else {
                Navigator.of(context)
                    .pushNamed('users', arguments: resp['success']['token']);
              }
            } on Exception catch (error) {
              setState(() => _showCircularProgress = false);
              return _mensajeError(context, error);
            }
          }
        },
        child: _showCircularProgress
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white70))
            : Text(_iniciarSesion ? "Iniciar sesión" : "Crear cuenta",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final textoBienvenida = Container(
        child: Text('Bienvenido!',
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 35.0)),
        margin: EdgeInsets.all(30));

    final crearCuenta = Container(
        margin: EdgeInsets.only(bottom: 0),
        child: InkWell(
            child: Text(_iniciarSesion ? '¿Crear cuenta?' : 'Ya tengo cuenta!',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.pink[200],
                    fontWeight: FontWeight.bold)),
            onTap: () => setState(() => _iniciarSesion = !_iniciarSesion)));

    /// widgets end ---->

// ui login
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      textoBienvenida,
                      SizedBox(
                        height: itemHeight,
                        child: Image.asset(
                          "assets/meditation.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      nameField,
                      SizedBox(height: 15.0),
                      emailField,
                      SizedBox(height: 25.0),
                      passwordField,
                      SizedBox(
                        height: 30.0,
                      ),
                      confirmPasswordField,
                      loginButon,
                      SizedBox(
                        height: 30.0,
                      ),
                      crearCuenta,
                      SizedBox(
                        height: 35.0,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
