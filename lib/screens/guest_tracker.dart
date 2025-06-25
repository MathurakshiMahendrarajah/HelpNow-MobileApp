import 'package:flutter/material.dart';

class GuestTracker extends StatefulWidget {
  @override
  _GuestTrackerState createState() => _GuestTrackerState();
}

class _GuestTrackerState extends State<GuestTracker> {
  String caseId = '';
  String status = '';

  void fetchStatus() {
    // TODO: Fetch case status from DB using caseId
    setState(() {
      status = "In Progress"; // Example
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Track Case")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Enter Case ID"),
              onChanged: (val) => caseId = val,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: fetchStatus,
              child: Text("Check Status"),
            ),
            SizedBox(height: 20),
            if (status.isNotEmpty) Text("Case Status: $status"),
          ],
        ),
      ),
    );
  }
}
