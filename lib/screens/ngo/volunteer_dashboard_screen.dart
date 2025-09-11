import 'package:flutter/material.dart';
import 'volunteer_detail_screen.dart';

class VolunteerDashboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> dummyVolunteers = [
    {
      "id": "V1001",
      "name": "Alice Johnson",
      "type": "Food Assistance",
      "location": "Colombo",
      "photo": "",
      "rating": 4.5,
      "isActive": true,
      "pendingCases": 1,
      "assignedCases": 2,
      "completedCases": 3,
      "totalCases": 6,
      "progress": [
        {"caseTitle": "Food Assistance - Colombo", "progressPercent": 100.0, "status": "Completed"},
        {"caseTitle": "School Supplies - Galle", "progressPercent": 60.0, "status": "In Progress"},
      ]
    },
    {
      "id": "V1002",
      "name": "Bob Smith",
      "type": "Medical Aid",
      "location": "Kandy",
      "photo": "",
      "rating": 4.8,
      "isActive": true,
      "pendingCases": 0,
      "assignedCases": 2,
      "completedCases": 1,
      "totalCases": 3,
      "progress": [
        {"caseTitle": "Medical Help - Kandy", "progressPercent": 40.0, "status": "Assigned"},
      ]
    },
    {
      "id": "V1003",
      "name": "Catherine Lee",
      "type": "Education Support",
      "location": "Galle",
      "photo": "",
      "rating": 4.2,
      "isActive": false,
      "pendingCases": 1,
      "assignedCases": 1,
      "completedCases": 2,
      "totalCases": 4,
      "progress": [
        {"caseTitle": "School Supplies - Galle", "progressPercent": 50.0, "status": "In Progress"},
      ]
    },
  ];

  static const primaryRed = Color(0xFFEC1337);
  static const backgroundPink = Color(0xFFFCF8F9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPink,
      appBar: AppBar(
        backgroundColor: primaryRed,
        title: const Text("Volunteer Dashboard"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dummyVolunteers.length,
        itemBuilder: (context, index) {
          var v = dummyVolunteers[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, color: Colors.grey),
              ),
              title: Text(v['name']),
              subtitle: Text("${v['type']} • ${v['location']}"),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VolunteerDetailScreen(
                        volunteerData: v, // <-- pass the selected volunteer dynamically
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryRed,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14))),
                child: const Text("View"),
              ),
            ),
          );
        },
      ),
    );
  }
}
