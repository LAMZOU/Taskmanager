import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final String username = "Nom d'utilisateur";
  final String email = "email@example.com";
  final String firstName = "Prénom";
  final String lastName = "Nom";
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Utilisateur'),
        backgroundColor: Color.fromARGB(255, 245, 118, 6),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, size: 30), //30
            onPressed: () {
              // Ouvrir la modal pour modifier le profil utilisateur
              _showEditProfileModal(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap:
                  _pickImage, // Permet à l'utilisateur de sélectionner une image
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : AssetImage('assets/images/profile_image.png')
                        as ImageProvider,
                child: _image == null
                    ? Icon(Icons.add_a_photo,
                        size: 15, color: Colors.white) //30
                    : null,
              ),
            ),
            SizedBox(height: 16),

            // Nom complet
            Text(
              '$firstName $lastName',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8), //8

            // Nom d'utilisateur
            Text(
              '@$username',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),

            // Adresse e-mail
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email, color: Colors.grey[600]),
                SizedBox(width: 8),
                Text(
                  email,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
            SizedBox(height: 32), //32

            // Bouton Modifier le profil
            ElevatedButton(
              onPressed: () {
                // Ouvrir la modal pour modifier le profil utilisateur
                _showEditProfileModal(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(
                    255, 250, 70, 4), // Couleur de fond du bouton
                padding:
                    EdgeInsets.symmetric(horizontal: 32, vertical: 16), //32,8
                textStyle: TextStyle(fontSize: 25),
              ),
              child: Text('Modifier votre profil'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Permet à la modal de s'étendre à la hauteur du contenu
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Modifier votre profil',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                _buildTextField(label: 'Nom', initialValue: firstName),
                SizedBox(height: 12),
                _buildTextField(label: 'Prénom', initialValue: lastName),
                SizedBox(height: 12),
                _buildTextField(label: 'Email', initialValue: email),
                SizedBox(height: 12),
                _buildTextField(
                    label: "Nom d'utilisateur", initialValue: username),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    // Ajoutez la logique de sauvegarde ici
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 253, 116, 4),
                    padding: EdgeInsets.symmetric(
                        horizontal: 15, vertical: 8), //32-16
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('Enregistrer les modifications'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(
      {required String label, required String initialValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            hintText: initialValue,
          ),
        ),
      ],
    );
  }
}
