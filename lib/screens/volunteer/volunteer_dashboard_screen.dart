import 'package:flutter/material.dart';

class VolunteerDashboard extends StatelessWidget {
  // Sample data for tasks (this could be dynamic in a real app)
  final List<Map<String, String>> nearbyCases = [
    {
      "caseId": "C1",
      "location": "City Park",
      "status": "Assigned",
      "volunteer": "John Doe",
    },
    {
      "caseId": "C2",
      "location": "River Side",
      "status": "In Progress",
      "volunteer": "Jane Smith",
    },
  ];

  final List<Map<String, String>> myCases = [
    {
      "caseId": "C3",
      "location": "Beach Cleanup",
      "status": "Assigned",
      "volunteer": "Alice",
    },
  ];

  final List<Map<String, String>> completedCases = [
    {
      "caseId": "C4",
      "location": "School Help",
      "status": "Completed",
      "volunteer": "Bob",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volunteer Dashboard'),
        backgroundColor: Colors.greenAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              // Logic to sign out the volunteer
              Navigator.pop(context); // Navigate back to the login screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Welcome message
            _buildWelcomeMessage(),

            const SizedBox(height: 20),

            // Menu Bar (Navigation)
            _buildMenuBar(context),

            const SizedBox(height: 20),

            // Nearby Cases Section
            _buildSectionTitle('Nearby Cases'),
            _buildCaseList(nearbyCases),

            const SizedBox(height: 20),

            // My Cases Section
            _buildSectionTitle('My Cases'),
            _buildCaseList(myCases),

            const SizedBox(height: 20),

            // Completed Cases Section
            _buildSectionTitle('Completed Cases'),
            _buildCaseList(completedCases),
          ],
        ),
      ),
    );
  }

  // Widget to build the section title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  // Widget to build the case list (dummy data)
  Widget _buildCaseList(List<Map<String, String>> caseList) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...caseList.map((caseItem) {
              return ListTile(
                title: Text('Case ID: ${caseItem["caseId"]}'),
                subtitle: Text(
                  'Location: ${caseItem["location"]}\nStatus: ${caseItem["status"]}\nVolunteer: ${caseItem["volunteer"]}',
                ),
                leading: const Icon(Icons.assignment),
                onTap: () {
                  // Logic for selecting and viewing the case details
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  // Widget to build the welcome message
  Widget _buildWelcomeMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Welcome to your Dashboard!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Here are your current tasks and their status.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  // Menu Bar (Navigation Bar)
  Widget _buildMenuBar(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMenuButton(context, 'Nearby Cases', () {
              // Logic to navigate to Nearby Cases section
            }),
            _buildMenuButton(context, 'My Cases', () {
              // Logic to navigate to My Cases section
            }),
            _buildMenuButton(context, 'Completed Cases', () {
              // Logic to navigate to Completed Cases section
            }),
          ],
        ),
      ),
    );
  }

  // Widget to build each menu button
  Widget _buildMenuButton(
    BuildContext context,
    String label,
    VoidCallback onTap,
  ) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent,
        minimumSize: const Size(100, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label),
    );
  }
}
