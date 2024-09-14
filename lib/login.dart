import 'package:flutter/material.dart';
import 'loginRequest.dart'; // Assurez-vous que le chemin est correct
import 'package:taskmanager/Signup.dart';
import 'package:taskmanager/task_list.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiService apiService = ApiService('http://localhost:4000');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 204, 201, 201),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 2 / 6,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _inputField(context),
                          _signup(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _header(BuildContext context) {
    return Column(
      children: [
        Text(
          "Task Manager",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  _logo(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'images/logo.JPG',
          height: 150,
        ),
      ],
    );
  }

  _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(
              Icons.account_balance_wallet,
              size: 34, // Spécifiez la taille uniforme pour l'icône
            ),
          ),
        ),
        SizedBox(height: 15),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "Mot de passe",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: SizedBox(
              width: 14, // Spécifiez la largeur pour l'icône
              height: 24, // Spécifiez la hauteur pour l'icône
              child: Image.asset('images/logo_mdp.png'),
            ),
          ),
          obscureText: true,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            final email = _emailController.text;
            final password = _passwordController.text;

            final success = await apiService.login(email, password);

            if (success) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TaskList()),
              );
            } else {
              // Affichez un message d'erreur ici
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Échec de la connexion. Veuillez vérifier vos informations.'),
                ),
              );
            }
          },
          child: Text(
            "Connexion",
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

  _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Vous n'avez pas de compte?"),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: Text("Sign up"),
        ),
      ],
    );
  }
}
