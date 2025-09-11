import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:amplify_flutter/amplify_flutter.dart'; // For Amplify API/Storage
import 'package:dotted_border/dotted_border.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:aws_common/aws_common.dart';

class ReportTab extends StatefulWidget {
  const ReportTab({super.key});

  @override
  State<ReportTab> createState() => _ReportTabState();
}

class _ReportTabState extends State<ReportTab> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _locationCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  bool _isSubmitting = false;
  bool _isSubmitted = false;
  String? _caseId;

  // Theme colors
  final Color primaryColor = const Color(0xFFEC1337);
  final Color secondaryColor = const Color(0xFFF3E7E9);
  final Color textPrimary = const Color(0xFF1B0D10);
  final Color textSecondary = const Color(0xFF9A4C59);
  final Color backgroundPink = const Color(0xFFFCF8F9);

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
    final pickedFile = await _picker.pickImage(source: source, maxWidth: 800);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  String generateCaseId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return "RPT-$timestamp";
  }

  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Generate Case ID
      final caseId = generateCaseId();

      // Simulate a delay as if submitting to backend
      await Future.delayed(const Duration(seconds: 1));

      // Clear form and show success
      setState(() {
        _isSubmitting = false;
        _isSubmitted = true;
        _caseId = caseId;

        _nameCtrl.clear();
        _locationCtrl.clear();
        _descriptionCtrl.clear();
        _selectedImage = null;
      });

      
    } catch (e) {
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error submitting report: $e')));
      debugPrint('Submit report error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPink,
      appBar: AppBar(
        backgroundColor: backgroundPink.withOpacity(0.9),
        title: const Text(
          "Report a Case",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 12,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name (Optional)
                        TextFormField(
                          controller: _nameCtrl,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFF8F6F8),
                            hintText: "Your Name (Optional)",
                            prefixIcon: const Icon(
                              Icons.person_outline,
                              color: Color(0xFF9A4C59),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(color: Color(0xFF9A4C59)),
                        ),
                        const SizedBox(height: 24),
                        // Location
                        TextFormField(
                          controller: _locationCtrl,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFF8F6F8),
                            hintText: "Enter location or use GPS",
                            prefixIcon: const Icon(
                              Icons.location_on,
                              color: Color(0xFF9A4C59),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.my_location,
                                color: Color(0xFF9A4C59),
                              ),
                              onPressed: _getLocation,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(color: Color(0xFF9A4C59)),
                          validator: (val) => val == null || val.isEmpty
                              ? "Location required"
                              : null,
                        ),
                        const SizedBox(height: 24),
                        // Short Description
                        const Text(
                          "Short Description",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _descriptionCtrl,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "Describe the issue in a few words...",
                            filled: true,
                            fillColor: Color(0xFFF8F6F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(color: Color(0xFF9A4C59)),
                          validator: (val) => val == null || val.length < 10
                              ? "Description too short"
                              : null,
                        ),
                        const SizedBox(height: 24),
                        // Upload Image
                        const Text(
                          "Upload Image",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Clear photos help us understand the situation better. Ensure good lighting and focus on the main issue.",
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => _pickImage(ImageSource.gallery),
                          child: DottedBorder(
                            radius: const Radius.circular(16),
                            dashPattern: const [8, 4],
                            color: const Color(0xFF9A4C59),
                            strokeWidth: 1.5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                width: double.infinity,
                                height: 140,
                                alignment: Alignment.center,
                                child: _selectedImage == null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.add_a_photo,
                                            size: 38,
                                            color: Color(0xFF9A4C59),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Tap to upload a photo",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            "PNG, JPG, GIF up to 5MB",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black45,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Image.file(
                                        _selectedImage!,
                                        height: 140,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isSubmitting ? null : _submitReport,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: textSecondary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: _isSubmitting
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Submit Case",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_isSubmitted)
            AnimatedSlide(
              offset: _isSubmitted ? Offset(0, 0) : const Offset(0, 1),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.3),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: _buildSuccessScreen(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSuccessScreen() {
    return AnimatedSlide(
      offset: _isSubmitted
          ? Offset(0, 0)
          : const Offset(0, 1), // slide from bottom
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      child: Container(
        color: Colors.black.withOpacity(0.3), // semi-transparent background
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              color: Colors.white,
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 36,
                  horizontal: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 64),
                    const SizedBox(height: 16),
                    const Text(
                      "Report Submitted!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Case ID: $_caseId",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => setState(() => _isSubmitted = false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          "OK",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
