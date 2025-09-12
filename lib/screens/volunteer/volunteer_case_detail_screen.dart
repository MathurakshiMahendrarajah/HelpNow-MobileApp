import 'package:flutter/material.dart';

class VolunteerCaseDetailScreen extends StatelessWidget {
  final Map<String, dynamic>
  caseData; // This will hold the case data passed from the dashboard

  // Constructor to receive the case data
  const VolunteerCaseDetailScreen({Key? key, required this.caseData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(caseData['title']), // Title of the case
        backgroundColor: Color(0xFFEC1337), // AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // Case Title and Category
            Text(
              caseData['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Category: ${caseData['category']}",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              "Location: ${caseData['location']}",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Case Description
            Text(
              "Description: ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(caseData['description'], style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),

            // Status of the Case
            Text(
              "Status: ${caseData['status']}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _getStatusColor(caseData['status']),
              ),
            ),
            const SizedBox(height: 16),

            // Assigned Volunteers (if any)
            if (caseData['assignedVolunteers'] != null &&
                caseData['assignedVolunteers'].isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Assigned Volunteers: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...caseData['assignedVolunteers'].map<Widget>((volunteer) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(volunteer['image']),
                            radius: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            volunteer['name'],
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "(Rating: ${volunteer['rating']})",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),

            const SizedBox(height: 16),

            // Action Buttons (e.g., Mark as Complete, etc.)
            ElevatedButton(
              onPressed: () {
                // You can implement action here (e.g., mark case as completed)
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Action'),
                    content: Text('Do you want to mark this case as complete?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Implement the action logic here
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Case marked as completed')),
                          );
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEC1337),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text('Mark as Complete', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  // Method to get color based on case status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'In Progress':
        return Colors.blue;
      case 'Assigned':
        return Colors.purple;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}
