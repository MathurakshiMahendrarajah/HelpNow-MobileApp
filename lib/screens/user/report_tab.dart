import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpnow_mobileapp/screens/user/user_main_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class ReportTab extends StatefulWidget {
  const ReportTab({super.key});

  @override
  State<ReportTab> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportTab> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _locationCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  File? _selectedImage;
  bool _isSubmitted = false;
  String? _caseId;
  bool _isSubmitting = false;

  Future<void> _getLocation() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _locationCtrl.text = "${pos.latitude}, ${pos.longitude}";
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission denied")),
      );
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });
      await Future.delayed(const Duration(seconds: 2)); // Simulate network
      setState(() {
        _caseId = const Uuid().v4().substring(0, 8).toUpperCase();
        _isSubmitted = true;
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFFFCCBC),
        title: const Text(
          "Report Help",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(blurRadius: 6, color: Colors.black26)],
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: _isSubmitted
                ? _buildSuccessScreen()
                : _isSubmitting
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepOrangeAccent,
                    ),
                  )
                : _buildForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          color: Colors.white.withOpacity(0.97),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 22),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  Text(
                    "Please fill out the form to report your case",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Name (optional)
                  TextFormField(
                    controller: _nameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Name (optional)',
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Location
                  TextFormField(
                    controller: _locationCtrl,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      prefixIcon: Icon(Icons.location_on_outlined),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.gps_fixed),
                        onPressed: _getLocation,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (val) => val == null || val.isEmpty
                        ? "Location is required"
                        : null,
                  ),
                  const SizedBox(height: 18),

                  // Description
                  TextFormField(
                    controller: _noteCtrl,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Note/Description',
                      prefixIcon: Icon(Icons.description_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) => val == null || val.length < 10
                        ? "Description too short"
                        : null,
                  ),
                  const SizedBox(height: 18),

                  // Image Upload
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _pickImage(ImageSource.camera),
                          icon: const Icon(Icons.camera_alt),
                          label: const Text("Camera"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 248, 180, 160),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            textStyle: const TextStyle(fontSize: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _pickImage(ImageSource.gallery),
                          icon: const Icon(Icons.image),
                          label: const Text("Gallery"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 248, 180, 160),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            textStyle: const TextStyle(fontSize: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (_selectedImage != null) ...[
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(_selectedImage!, height: 140),
                    ),
                  ],
                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      icon: Icon(Icons.send_rounded, color: Colors.white),
                      label: const Text(
                        "Submit Report",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          color: Colors.white.withOpacity(0.97),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Illustration
                const SizedBox(height: 22),
                const Text(
                  "Thank You!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Your report has been submitted.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 22),
                Text(
                  "Case ID: $_caseId",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: _caseId ?? ''));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Case ID copied!")),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserMainScreen(
                          selectedIndex: 2, // Track tab
                          caseId: _caseId, // Your variable
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.track_changes),
                  label: const Text("Track My Case"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
