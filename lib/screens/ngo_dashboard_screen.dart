import 'package:flutter/material.dart';
import 'case_list_screen.dart';
import '../widgets/case_table.dart';

class NGODashboardScreen extends StatelessWidget {
  const NGODashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NGO Dashboard'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var status in ['All Cases', 'Pending', 'In Progress', 'Solved'])
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CaseListScreen(status: status),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: Text(status),
                  )
              ],
            ),
            const SizedBox(height: 20),
            // Main Table
            const Expanded(child: CaseTable()),
          ],
        ),
      ),
    );
  }
}
