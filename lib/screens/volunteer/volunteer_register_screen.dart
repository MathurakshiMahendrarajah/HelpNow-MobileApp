import 'package:flutter/material.dart';

class VolunteerRegisterScreen extends StatefulWidget {
  @override
  _VolunteerRegisterScreenState createState() =>
      _VolunteerRegisterScreenState();
}

class _VolunteerRegisterScreenState extends State<VolunteerRegisterScreen> {
  final PageController _pageController = PageController();

  // Step 1 controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Step 2 controllers
  final TextEditingController incomeController = TextEditingController();
  String? selectedDistrict;
  String? selectedAvailability;

  int currentPage = 0;

  void nextPage() {
    if (currentPage < 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void prevPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _getCurrentDistrict() {
    // TODO: Replace with actual GPS + reverse geocode logic
    setState(() {
      selectedDistrict = 'Colombo'; // Example auto-set district
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Current district set to Colombo')));
  }

  void _pickIncomeProof() {
    // TODO: Implement actual file picker here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Upload proof clicked - implement file picker!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Volunteer Registration'),
        backgroundColor: Colors.greenAccent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header with Icon and Title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Icon(
                    Icons.volunteer_activism,
                    size: 60,
                    color: Colors.greenAccent,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Become a Volunteer',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Fill out your details to join us',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),

            // Form Steps with button below each form
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                children: [
                  buildStepWithButton(
                    stepWidget: buildStep1(),
                    buttonText: "Next",
                    onButtonPressed: nextPage,
                  ),
                  buildStepWithButton(
                    stepWidget: buildStep2(),
                    buttonText: "Register",
                    onButtonPressed: () {
                      // Submit form logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Registered successfully!")),
                      );
                      Navigator.pop(context);
                    },
                    showBackButton: true,
                    onBackPressed: prevPage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStepWithButton({
    required Widget stepWidget,
    required String buttonText,
    required VoidCallback onButtonPressed,
    bool showBackButton = false,
    VoidCallback? onBackPressed,
  }) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          stepWidget,
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              ),
              child: Text(buttonText, style: TextStyle(fontSize: 16)),
            ),
          ),
          if (showBackButton && onBackPressed != null) ...[
            const SizedBox(height: 12),
            Center(
              child: OutlinedButton(
                onPressed: onBackPressed,
                child: Text("Back"),
                style: OutlinedButton.styleFrom(minimumSize: Size(100, 40)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget buildStep1() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            buildInputField(
              controller: nameController,
              label: 'Full Name',
              icon: Icons.person,
            ),
            const SizedBox(height: 16),
            buildInputField(
              controller: emailController,
              label: 'Email',
              icon: Icons.email,
            ),
            const SizedBox(height: 16),
            buildInputField(
              controller: passwordController,
              label: 'Password',
              icon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            buildInputField(
              controller: confirmPasswordController,
              label: 'Confirm Password',
              icon: Icons.lock_outline,
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStep2() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Select District',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    value: selectedDistrict,
                    items:
                        [
                          'Colombo',
                          'Gampaha',
                          'Kalutara',
                          'Kandy',
                          'Matale',
                          'Nuwara Eliya',
                          'Galle',
                          'Matara',
                          'Hambantota',
                          'Jaffna',
                          'Kilinochchi',
                          'Mannar',
                          'Vavuniya',
                          'Mullaitivu',
                          'Batticaloa',
                          'Ampara',
                          'Trincomalee',
                          'Kurunegala',
                          'Puttalam',
                          'Anuradhapura',
                          'Polonnaruwa',
                          'Badulla',
                          'Moneragala',
                          'Ratnapura',
                          'Kegalle',
                        ].map((district) {
                          return DropdownMenuItem(
                            value: district,
                            child: Text(district),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDistrict = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _getCurrentDistrict,
                  icon: Icon(Icons.my_location),
                  label: Text("Locate me"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                    minimumSize: Size(120, 48),
                    backgroundColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: buildInputField(
                    controller: incomeController,
                    label: 'Annual Income',
                    icon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: _pickIncomeProof,
                    icon: Icon(Icons.upload_file),
                    label: Text('Upload Proof'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      minimumSize: Size(double.infinity, 48),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Availability',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              value: selectedAvailability,
              items: [
                DropdownMenuItem(value: 'Weekdays', child: Text('Weekdays')),
                DropdownMenuItem(value: 'Weekends', child: Text('Weekends')),
                DropdownMenuItem(value: 'Anytime', child: Text('Anytime')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedAvailability = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }
}
