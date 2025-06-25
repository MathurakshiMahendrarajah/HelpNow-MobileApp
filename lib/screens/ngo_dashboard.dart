import 'package:flutter/material.dart';

class NGODashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace with real-time list from database
    final reports = [
      {'id': '001', 'note': 'Need food', 'status': 'Pending'},
      {'id': '002', 'note': 'Injured person', 'status': 'In Progress'},
    ];

    return Scaffold(
      appBar: AppBar(title: Text("NGO Dashboard")),
      body: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final report = reports[index];
          return ListTile(
            title: Text(report['note']!),
            subtitle: Text("Status: ${report['status']}"),
            trailing: DropdownButton<String>(
              value: report['status'],
              items: ["Pending", "In Progress", "Helped"]
                  .map((s) => DropdownMenuItem(child: Text(s), value: s))
                  .toList(),
              onChanged: (val) {
                // TODO: Update status in database
              },
            ),
          );
        },
      ),
    );
  }
}
