import 'package:flutter/material.dart';

class VolunteerDashboard extends StatelessWidget {
  // Sample data for tasks (this could be dynamic in a real app)
  final List<Map<String, String>> tasks = [
    {"task": "Help distribute food at City Park", "status": "Pending"},
    {"task": "Assist in cleaning at Riverside", "status": "In Progress"},
    {"task": "Teach children at Local School", "status": "Completed"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volunteer Dashboard'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Welcome message
            _buildWelcomeMessage(),

            const SizedBox(height: 20),

            // Assigned Tasks Section
            _buildAssignedTasks(),

            const SizedBox(height: 20),

            // Status Section
            _buildTaskStatus(),

            const SizedBox(height: 20),

            // Sign Out Button
            _buildSignOutButton(context),
          ],
        ),
      ),
    );
  }

  // Welcome message widget
  Widget _buildWelcomeMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Welcome to the Volunteer Dashboard!',
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

  // Assigned tasks widget
  Widget _buildAssignedTasks() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Assigned Tasks',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...tasks.map((task) {
              return ListTile(
                title: Text(task["task"] ?? ""),
                subtitle: Text('Status: ${task["status"] ?? "Unknown"}'),
                leading: Icon(Icons.task),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  // Task status widget
  Widget _buildTaskStatus() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Task Status Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatusColumn('Pending', Colors.orange),
                _buildStatusColumn('In Progress', Colors.blue),
                _buildStatusColumn('Completed', Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build status columns
  Widget _buildStatusColumn(String status, Color color) {
    int count = tasks.where((task) => task["status"] == status).length;
    return Column(
      children: [
        Icon(Icons.circle, color: color, size: 30),
        const SizedBox(height: 5),
        Text(
          '$status',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text('$count tasks', style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  // Sign out button widget
  Widget _buildSignOutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Logic for logging out (You may want to clear tokens or user data here)
        Navigator.pop(
          context,
        ); // Navigate back to the login screen (or RoleSelectionScreen)
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Colors.redAccent, // Use 'backgroundColor' instead of 'primary'
        minimumSize: Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text('Sign Out', style: TextStyle(fontSize: 16)),
    );
  }
}
