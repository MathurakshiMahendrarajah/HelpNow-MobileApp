import 'package:flutter/material.dart';

class VolunteerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final assignedTasks = [
      {'id': '003', 'note': 'Old lady needs medicine', 'status': 'Pending'}
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Volunteer Dashboard")),
      body: ListView.builder(
        itemCount: assignedTasks.length,
        itemBuilder: (context, index) {
          final task = assignedTasks[index];
          return Card(
            child: ListTile(
              title: Text(task['note']!),
              subtitle: Text("Status: ${task['status']}"),
              trailing: ElevatedButton(
                child: Text("Mark Helped"),
                onPressed: () {
                  // TODO: Update status in DB
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
