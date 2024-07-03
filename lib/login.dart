// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  var scaffold = Scaffold(
      body: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotpassword(context),
              _signup(context),

          
            ],
          ),
      ),
      );
  return SafeArea(
    child: scaffold,

  );
  }
  _header(context) {
    // ignore: duplicate_ignore
    // ignore: prefer_const_constructors
    return Column(
      children: [
        Text("Task Manager",
         style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          ),
          ),
        Text("Enter your credential to login"),
        ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon:Icon(Icons.mail)
            ),
          ),
          SizedBox(height: 10),
          TextField(
          decoration: InputDecoration(
            hintText: "Mot de passe",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon:Icon(Icons.toggle_off_rounded),
            ),
            obscureText: true,
          ),
          SizedBox(height: 10),
          ElevatedButton
          (onPressed: (){}, 
          // ignore: sort_child_properties_last
          child: Text(
            "Connexion",
            style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.red,

            ),
            )
      ],
    );

  }

_forgotpassword(context) {
  return TextButton(onPressed: (){}, child: Text(
    "Mot de passe oublie?",
    style: TextStyle(color: Colors.blue),
  )
  );
}

_signup(context) {
  return Row (
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Vous n'avez pas de compte?"),
      TextButton(onPressed:(){}, child: Text("Sign up"))
    ],
  );
}

}


