import 'package:flutter/material.dart';

import 'dart:async';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController controlUsuario = new TextEditingController();
  TextEditingController controlContrasena = new TextEditingController();

  Future<List> obtenerUsuario() async {
    var url = "http://192.168.0.11/pruebas/obtenerUsuario.php";
    final response = await http.post(url, body: {
      "usuario": controlUsuario.text,
      "contrasena": controlContrasena.text
    });

    if(response.body == "CORRECTO") {
      Toast.show(
        "LOGIN CORRECTO",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white
      );
    } else if(response.body == "ERROR") {
      Toast.show(
          "LOGIN INCORRECTO",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 5, top: 30, right: 5),

        child: Column(
          children: <Widget>[

            Image.asset("assets/login.jpg"),

            Container(
              padding: EdgeInsets.only(left: 50, top: 25, right: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  TextField(
                    controller: controlUsuario,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: "USUARIO",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  TextField(
                    controller: controlContrasena,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "CONTRASEÑA",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(50),
              child: RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text("INICIAR SESIÓN"),
                onPressed: () {
                  obtenerUsuario();
                },
              ),
            ),

          ],
        ),

      ),
    );
  }

}

