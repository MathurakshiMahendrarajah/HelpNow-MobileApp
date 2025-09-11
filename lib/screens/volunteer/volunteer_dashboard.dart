import 'package:flutter/material.dart';

class VolunteerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to Your Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          _buildDashboardCard('Assigned Cases', 'Case #12345'),
          _buildDashboardCard('In Progress', 'Case #67890'),
          _buildDashboardCard('Completed Cases', 'Case #11223'),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(String title, String caseId) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title),
        subtitle: Text(caseId),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Handle case navigation
        },
      ),
    );
  }
}
