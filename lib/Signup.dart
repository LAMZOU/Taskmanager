// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_key_in_widget_constructors, sort_child_properties_last, unused_import, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmanager/login.dart';
import 'package:taskmanager/resetpassword.dart';

class SignUpScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return SafeArea(child: Scaffold(
          backgroundColor: Colors.grey,
      appBar: AppBar(
      backgroundColor: Colors.white,
      shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Rayon des coins (optionnel)
      side: BorderSide(
      color: Colors.white, // Couleur des contours
      width: 2.0, // Épaisseur des contours
    ),
  ),
      toolbarHeight: MediaQuery.of(context).size.height*2/10,
      title: Text("Creer votre compte", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.red),), 
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
      ),

    
      body: Container(
        margin: EdgeInsets.all(24),
        child: Column( 
          children: [
            _header(context),
            _inputFields(context),
          ],
          ),
          ),
      ),
   );
  }

_header(context){
  return Column(
    children: [
      Text("Creer votre compte", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,color: Colors.red),), 
      
    ],
  );
}

_inputFields(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      TextField(
        decoration: InputDecoration(
          hintText: "Prenom/Nom",
          fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none),
          ),
      ),
      SizedBox(
        height: 10,
      ),
      TextField(
        decoration: InputDecoration(
          hintText: "Email",
          fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none),
          ),
      ),
      
      SizedBox(
        height: 10,
      ),
      TextField(
        decoration: InputDecoration(
          hintText: "Nom d'utilisateur",
          fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none),
          ),
      ),

      SizedBox(
        height: 10,
      ),

      TextField(
        decoration: InputDecoration(
          hintText: "Mot de passe",
          fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
          filled: true,
          suffixIcon: Icon(Icons.password_outlined),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none),
          ),
          obscureText: true,
      ),

      SizedBox(
        height: 10,
      ),

      TextField(
        decoration: InputDecoration(
          hintText: "Repeter mot de passe",
          fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
          filled: true,
          suffixIcon: Icon(Icons.password_outlined),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none),
          ),
          obscureText: true,
      ), 
      SizedBox(
        height: 10,
      ),
      ElevatedButton(onPressed: (){
        Navigator.pop(context);
      },
      child: Text(
        
        "Creer mon compte",
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.red,
      ),
      ),
      
    ],
  );
}

}