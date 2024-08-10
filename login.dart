// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, unused_label, non_constant_identifier_names, avoid_types_as_parameter_names, avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_import, sort_child_properties_last, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmanager/Signup.dart';

import 'resetpassword.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  var scaffold = Scaffold(
    backgroundColor: Color.fromARGB(255, 204, 201, 201),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment:MainAxisAlignment.end,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*2/6,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),

                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _header(context),
                    Divider(),
                    _logo(context),
                    Divider(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                        children: [
                    _inputField(context),
                    _forgotpassword(context),
                    _signup(context),
                    ],)
                    ),
                 
                  ],
                ),
            ),
          ),
        ],
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
        ],
    );
  }

  _logo(context) {
    return Column(
      children: [
        Image.asset('images/logo.JPG',height: 150,),
        
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
  return TextButton(onPressed: (){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => ResetPasswordPage()),
    );
  }, child: Text(
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
      TextButton(onPressed:(){
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
        );
      }, 
      child: Text("Sign up"))

    ],
  );
}
}
