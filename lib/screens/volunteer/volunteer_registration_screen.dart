import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/volunteer/volunteer_main_screen.dart'; // Import Volunteer Main Screen

class VolunteerRegistrationScreen extends StatefulWidget {
  @override
  _VolunteerRegistrationScreenState createState() =>
      _VolunteerRegistrationScreenState();
}

class _VolunteerRegistrationScreenState
    extends State<VolunteerRegistrationScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController availabilityController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool agreementChecked = false; // Agreement checkbox state

  int currentPage = 0; // Track current page

  // Color constants for theme
  static const primaryRed = Color(0xFFEC1337);
  static const secondaryMaroon = Color(0xFF9A4C59);
  static const backgroundPink = Color(0xFFFCF8F9);

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [backgroundPink, Color(0xFFFAE6F0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Reusing the animated handshake icon
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, 0),
                        child: Icon(
                          Icons.handshake,
                          size: 80,
                          color: primaryRed,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: [
                      Text(
                        'Volunteer Registration',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: secondaryMaroon,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Join us and make a difference!',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 28),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 10,
                        color: Colors.white.withOpacity(0.95),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              // Display form steps based on currentPage
                              currentPage == 0
                                  ? buildPersonalInfoStep()
                                  : currentPage == 1
                                  ? buildSkillsAndAvailabilityStep()
                                  : buildAccountInfoStep(),
                              const SizedBox(height: 24),
                              // Side arrows for navigation
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Left Arrow for previous page
                                  currentPage > 0
                                      ? GestureDetector(
                                          onTap: _previousPage,
                                          child: SlideTransition(
                                            position: _slideAnimation,
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              size: 40, // Smaller size
                                              color: primaryRed,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  // Right Arrow for next page
                                  currentPage < 2
                                      ? GestureDetector(
                                          onTap: _nextPage,
                                          child: SlideTransition(
                                            position: _slideAnimation,
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 40, // Smaller size
                                              color: primaryRed,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                              const SizedBox(height: 24),
                              // Register Button
                              currentPage == 2
                                  ? ElevatedButton(
                                      onPressed: () {
                                        if (passwordController.text ==
                                            confirmPasswordController.text) {
                                          if (agreementChecked) {
                                            // Register the user logic here
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    VolunteerMainScreen(),
                                              ),
                                            );
                                          } else {
                                            // Show an error if agreement is not checked
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text("Error"),
                                                content: Text(
                                                  "You must agree to the terms and conditions.",
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("OK"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        } else {
                                          // Show an error if passwords don't match
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text("Error"),
                                              content: Text(
                                                "Passwords do not match.",
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("OK"),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryRed,
                                        minimumSize: Size(double.infinity, 48),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'Register',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Step 1: Personal Information
  Widget buildPersonalInfoStep() {
    return Column(
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
          controller: phoneController,
          label: 'Phone Number',
          icon: Icons.phone,
        ),
        const SizedBox(height: 16),
        buildInputField(
          controller: addressController,
          label: 'Residential Address',
          icon: Icons.home,
        ),
      ],
    );
  }

  // Step 2: Skills and Availability
  Widget buildSkillsAndAvailabilityStep() {
    return Column(
      children: [
        buildInputField(
          controller: dobController,
          label: 'Date of Birth',
          icon: Icons.calendar_today,
        ),
        const SizedBox(height: 16),
        buildInputField(
          controller: skillsController,
          label: 'Skills/Expertise',
          icon: Icons.build,
        ),
        const SizedBox(height: 16),
        buildInputField(
          controller: availabilityController,
          label: 'Availability',
          icon: Icons.access_time,
        ),
        const SizedBox(height: 16),
        buildInputField(
          controller: genderController,
          label: 'Gender',
          icon: Icons.person_outline,
        ),
      ],
    );
  }

  // Step 3: Account Information
  Widget buildAccountInfoStep() {
    return Column(
      children: [
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
          icon: Icons.lock,
          obscureText: true,
        ),
        const SizedBox(height: 16),
        // Agreement/Consent Checkbox
        Row(
          children: [
            Checkbox(
              value: agreementChecked,
              onChanged: (value) {
                setState(() {
                  agreementChecked = value!;
                });
              },
            ),
            const Text("I agree to the terms and conditions"),
          ],
        ),
      ],
    );
  }

  // Navigation to the next page
  void _nextPage() {
    if (currentPage < 2) {
      setState(() {
        currentPage++;
      });
    }
  }

  // Navigation to the previous page
  void _previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
    }
  }

  // Reusable input field
  Widget buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }
}
