import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String username = "";
  String email = "";
  String firstName = "";
  String lastName = "";
  File? _image;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final userService = UserService();
      final userProfile = await userService.getUserProfile();

      setState(() {
        username = userProfile['username'];
        email = userProfile['email'];
        firstName = userProfile['firstName'];
        lastName = userProfile['lastName'];
      });
    } catch (e) {
      print('Error loading user profile: $e');
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await showDialog<XFile?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choisissez une source d\'image'),
          actions: <Widget>[
            TextButton(
              child: Text('Galerie'),
              onPressed: () async {
                Navigator.of(context)
                    .pop(await picker.pickImage(source: ImageSource.gallery));
              },
            ),
            TextButton(
              child: Text('Caméra'),
              onPressed: () async {
                Navigator.of(context)
                    .pop(await picker.pickImage(source: ImageSource.camera));
              },
            ),
          ],
        );
      },
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // Envoi de l'image au serveur
      await _uploadProfilePicture(_image!);
    }
  }

  Future<void> _uploadProfilePicture(File imageFile) async {
    final uri = Uri.parse('http://localhost:4000/auths/profils');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(
          await http.MultipartFile.fromPath('profilePicture', imageFile.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = jsonDecode(responseData);
        print('File uploaded successfully: ${data['filePath']}');
      } else {
        print('Failed to upload file');
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Déconnexion'),
          content: Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Déconnexion'),
              onPressed: () {
                _logout();
              },
            ),
          ],
        );
      },
    );
  }

  void _logout() async {

    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, size: 30),
            onPressed: () {
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
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : AssetImage('images/profile_image.png') as ImageProvider,
                child: _image == null
                    ? Icon(Icons.add_a_photo, size: 15, color: Colors.white)
                    : null,
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromARGB(255, 174, 173, 171),
              ),
              child: Text(
                '$firstName $lastName',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: 300,
              height: 60,
               decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromARGB(255, 174, 173, 171),
              ),
              child: Text(
                '@$email',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showEditProfileModal(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 15, 88, 224),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    textStyle: TextStyle(fontSize: 22),
                  ),
                  child: Text('Modifier'),
                ),
                ElevatedButton(
                  onPressed: _showLogoutConfirmationDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 181, 3, 3),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    textStyle: TextStyle(fontSize: 22),
                  ),
                  child: Text('Déconnexion'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 253, 116, 4),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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

class UserService {
  final String baseUrl = 'http://localhost:4000'; // URL de votre backend

  Future<Map<String, dynamic>> getUserProfile() async {
    final response = await http.get(Uri.parse('$baseUrl/auths/profils'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user profile');
    }
  }
}
