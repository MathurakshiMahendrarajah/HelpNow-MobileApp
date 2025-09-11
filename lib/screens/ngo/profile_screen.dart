import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'change_password_screen.dart';
import 'about_screen.dart';
import 'privacy_policy_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const primaryRed = Color(0xFFEC1337);
  static const secondaryMaroon = Color(0xFF9A4C59);
  static const backgroundPink = Color(0xFFFCF8F9);

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String profileName = "NGO User";

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  void _editProfileName() {
    TextEditingController nameController = TextEditingController(text: profileName);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Name"),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: "Name"),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                profileName = nameController.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPink,
      appBar: AppBar(
        backgroundColor: primaryRed,
        title: const Text("Profile"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  backgroundImage:
                      _imageFile != null ? FileImage(File(_imageFile!.path)) : null,
                  child: _imageFile == null
                      ? const Icon(Icons.person, size: 50, color: Colors.grey)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: _showImagePickerOptions,
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.edit, size: 18, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  profileName,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: secondaryMaroon),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: _editProfileName,
                  child: const Icon(Icons.edit, size: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ProfileOptionTile(
            icon: Icons.lock,
            title: "Change Password",
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ChangePasswordScreen()));
            },
          ),
          ProfileOptionTile(
            icon: Icons.info,
            title: "About",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => AboutScreen()));
            },
          ),
          ProfileOptionTile(
            icon: Icons.privacy_tip,
            title: "Privacy Policy",
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => PrivacyPolicyScreen()));
            },
          ),
          ProfileOptionTile(
            icon: Icons.logout,
            title: "Logout",
            onTap: () {
              Navigator.pop(context); // Or navigate to login
            },
          ),
        ],
      ),
    );
  }
}

// Reusable tile widget
class ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const ProfileOptionTile(
      {required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: Colors.grey[700]),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
