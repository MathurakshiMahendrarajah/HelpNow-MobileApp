import 'package:flutter/material.dart';
import '../../widgets/case_card.dart';

class CaseListScreen extends StatelessWidget {
  final String status;
  const CaseListScreen({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    final dummyCases = [
      {
        'image': 'https://via.placeholder.com/150',
        'location': 'Colombo',
        'note': 'Food needed for 5 families',
        'date': '2025-06-01',
        'status': 'Pending'
      },
      {
        'image': 'https://via.placeholder.com/150',
        'location': 'Galle',
        'note': 'Medical aid required urgently',
        'date': '2025-06-05',
        'status': 'In Progress'
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('$status Cases'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView.builder(
        itemCount: dummyCases.length,
        itemBuilder: (context, index) {
          return CaseCard(caseData: dummyCases[index]);
        },
      ),
    );
  }
}
