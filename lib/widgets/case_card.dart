import 'package:flutter/material.dart';

class CaseCard extends StatelessWidget {
  final Map caseData;

  const CaseCard({required this.caseData, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(caseData['image'], fit: BoxFit.cover, height: 180, width: double.infinity),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("📍 ${caseData['location']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(caseData['note']),
                const SizedBox(height: 4),
                Text("🗓️ ${caseData['date']}"),
                const SizedBox(height: 4),
                Text("Status: ${caseData['status']}", style: const TextStyle(color: Colors.deepPurple)),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: OutlinedButton(
                    onPressed: () {
                      // View details
                    },
                    child: const Text("View Details"),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
