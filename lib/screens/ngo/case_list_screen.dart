import 'package:flutter/material.dart';
import '../../widgets/case_card.dart';

class CaseListScreen extends StatelessWidget {
  final String status;
  const CaseListScreen({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    // Example dummy data (you can replace with your actual data source)
    final dummyCases = [
      {
        'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
        'location': 'Colombo',
        'note': 'Food needed for 5 families',
        'date': '2025-06-01',
        'status': 'Pending',
      },
      {
        'image': 'https://images.unsplash.com/photo-1587502536263-4b9c09ec43ee?auto=format&fit=crop&w=800&q=80',
        'location': 'Galle',
        'note': 'Medical aid required urgently',
        'date': '2025-06-05',
        'status': 'In Progress',
      },
      {
        'image': 'https://images.unsplash.com/photo-1526045612212-70caf35c14df?auto=format&fit=crop&w=800&q=80',
        'location': 'Kandy',
        'note': 'Clothing and blankets needed',
        'date': '2025-05-28',
        'status': 'Solved',
      },
    ];

    // Filter cases by status if needed (skip filter for 'All Cases')
    final filteredCases = status == 'All Cases'
        ? dummyCases
        : dummyCases.where((c) => c['status'] == status).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$status Cases'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: filteredCases.isEmpty
          ? Center(
              child: Text(
                'No $status cases available.',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredCases.length,
              itemBuilder: (context, index) {
                return CaseCard(caseData: filteredCases[index]);
              },
            ),
    );
  }
}
