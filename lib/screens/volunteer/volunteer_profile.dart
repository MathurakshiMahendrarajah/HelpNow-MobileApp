import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VolunteerProfile extends StatefulWidget {
  @override
  _VolunteerProfileState createState() => _VolunteerProfileState();
}

class _VolunteerProfileState extends State<VolunteerProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _selectedGender;
  String? _selectedAvailability;

  // ImagePicker
  late XFile _image;
  bool _isImagePicked = false;

  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> availabilityOptions = ['Weekdays', 'Weekends', 'All Days'];

  @override
  void initState() {
    super.initState();
    // You can load profile data here (sample data)
    _nameController.text = "John Doe";
    _emailController.text = "john.doe@example.com";
    _phoneController.text = "123-456-7890";
    _dobController.text = "01/01/1990";
    _skillsController.text = "First Aid, Communication";
    _addressController.text = "123 Main Street, City, Country";
    _selectedGender = 'Male';
    _selectedAvailability = 'Weekdays';
  }

  // Function to pick the profile image from gallery or camera
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery, // Change to ImageSource.camera for camera
    );
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
        _isImagePicked = true;
      });
    }
  }

  // Function to allow the user to pick an image using gallery or camera
  Future<void> _showImageSourceDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Image Source"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage();
              },
              child: Text("From Gallery"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(); // Use ImageSource.camera for camera
              },
              child: Text("From Camera"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Picture Section
              _isImagePicked
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(
                        // Display the picked image
                        File(_image.path),
                      ),
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/default_profile.png'),
                    ),
              SizedBox(height: 10),

              // Edit icon to change profile picture
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: _showImageSourceDialog, // Show dialog to pick image
              ),

              SizedBox(height: 20),

              // Profile Fields
              _buildProfileField('Full Name', _nameController),
              _buildProfileField('Email Address', _emailController),
              _buildProfileField('Phone Number', _phoneController),
              _buildProfileField('Date of Birth', _dobController),
              _buildDropdownField(
                label: 'Gender',
                value: _selectedGender,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
                items: genderOptions,
              ),
              _buildDropdownField(
                label: 'Availability',
                value: _selectedAvailability,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedAvailability = newValue;
                  });
                },
                items: availabilityOptions,
              ),
              _buildProfileField('Skills/Expertise', _skillsController),
              _buildProfileField('Address', _addressController),
              SizedBox(height: 20),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  // Save profile changes logic
                  _saveProfileChanges();
                },
                child: Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 24, 167, 43),
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required Function(String?) onChanged,
    required List<String> items,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(value: item, child: Text(item));
        }).toList(),
      ),
    );
  }

  void _saveProfileChanges() {
    // Example: Print the changes
    print("Profile Updated:");
    print("Name: ${_nameController.text}");
    print("Email: ${_emailController.text}");
    print("Phone: ${_phoneController.text}");
    print("DOB: ${_dobController.text}");
    print("Gender: $_selectedGender");
    print("Availability: $_selectedAvailability");
    print("Skills: ${_skillsController.text}");
    print("Address: ${_addressController.text}");
    // You can add logic to save these changes to a database or API
  }
}
