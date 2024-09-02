// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_element, non_constant_identifier_names, annotate_overrides, unnecessary_new, prefer_const_literals_to_create_immutables, deprecated_member_use, sized_box_for_whitespace, unused_import, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmanager/login.dart';
import 'package:taskmanager/Signup.dart';

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 197, 191, 191),
      appBar: MyAppBar(),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _body(context),
            _email(context),
            _Reinit(context),
          ],
        ),
      ),
    );
  }
}
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(100);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Rayon des coins (optionnel)
      side: BorderSide(
      color: Colors.white, // Couleur des contours
      width: 2.0, // Épaisseur des contours
    ),
  ),
      toolbarHeight: 200,
      title: Text( 'Mot de passe oublie',
    style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          ),
          ),
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.chevron_left,
          color: Color.fromARGB(255, 11, 0, 0),
          size: 30,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Color.fromARGB(255, 14, 2, 2),
            size: 23,
          ),
          onPressed: null,
        )
      ],
    );
  }
}
_body(context) {
  return Column(
    children: [
      Icon(
        Icons.password_outlined,
        size: 50,
      ),
      Text(
        'Probleme de connexion ?',
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          ),
      ),
      Text(
        'Entrer votre email et nous vous enverrons un lien pour reinitialiser votre mot de passe',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          ),
          textAlign: TextAlign.center,
      ),
    ],
  );
  
  
 } 
_email(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          SizedBox(height: 12,)
            ],
            );


}
_Reinit(context) {
  return Column(
    children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 243, 44, 33)), 
              ),
              onPressed: () {},
              child: Text(
                'Réinitialiser le mot de passe',
                style: TextStyle(
                  color: Colors.white,
                ),
                ),
            ),
    ],
  );
} 

