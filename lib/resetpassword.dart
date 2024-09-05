import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:taskmanager/sent_reset_link.dart';

class ResetPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final SentResetLink sentResetLink = SentResetLink('http://localhost:4000');

  Future<void> _sendResetLink(BuildContext context) async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez entrer votre email.')),
      );
      return;
    }

    try {
      final success = await sentResetLink.resetPassword(email);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Un lien de réinitialisation a été envoyé.')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Une erreur est survenue.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Une erreur est survenue: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 197, 191, 191),
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _body(context),
            SizedBox(height: 20),
            _email(context),
            SizedBox(height: 20),
            _Reinit(context, () => _sendResetLink(context)),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'images/mdp1.png',
           width: 50, 
           height: 50,
        ),
        Text(
          'Problème de connexion ?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Entrez votre email et nous vous enverrons un lien pour réinitialiser votre mot de passe',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _email(BuildContext context) {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
        filled: true,
        prefixIcon: Icon(Icons.mail),
      ),
    );
  }

  Widget _Reinit(BuildContext context, VoidCallback onPressed) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Color.fromARGB(255, 243, 44, 33),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        'Réinitialiser le mot de passe',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
      toolbarHeight: 200,
      title: Text(
        'Mot de passe oublié',
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
          onPressed: () {
            // Action when pressed
          },
        )
      ],
    );
  }
}
