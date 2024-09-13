import 'package:flutter/material.dart';
import 'package:taskmanager/signupRequest.dart';
import 'package:taskmanager/database_helper.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final ApiService _apiService = ApiService();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> _register() async {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final email = _emailController.text;
    final username = _usernameController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      _showErrorDialog("Les mots de passe ne correspondent pas");
      return;
    }

    try {
      final success = await _apiService.registerUser(
        firstName: firstName,
        lastName: lastName,
        email: email,
        username: username,
        password: password,
      );

      if (success) {
        await _databaseHelper.insertUser({
          'firstname': firstName,
          'lastname': lastName,
          'email': email,
          'username': username,
          'password': password,
        });
        Navigator.pop(context);
      }
    } catch (e) {
      _showErrorDialog("L'inscription a echoue: $e");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 2 / 18,
          title: Text(
            "Créer votre compte",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red),
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
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            children: [
              _header(context),
              _inputFields(),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _register,
                child: Text(
                  "Créer mon compte",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      children: [
        Text(
          "Créer votre compte",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ],
    );
  }

  Widget _inputFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _firstNameController,
          decoration: InputDecoration(
            hintText: "Prénom",
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _lastNameController,
          decoration: InputDecoration(
            hintText: "Nom",
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: "Email",
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            hintText: "Nom d'utilisateur",
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "Mot de passe",
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            suffixIcon: Icon(Icons.password_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
          obscureText: true,
        ),
        SizedBox(height: 10),
        TextField(
          controller: _confirmPasswordController,
          decoration: InputDecoration(
            hintText: "Répetter mot de passe",
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            suffixIcon: Icon(Icons.password_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
          obscureText: true,
        ),
      ],
    );
  }
}
