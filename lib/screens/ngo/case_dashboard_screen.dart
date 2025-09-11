import 'package:flutter/material.dart';
import 'case_detail_screen.dart';

class CaseDashboardScreen extends StatefulWidget {
  @override
  _CaseDashboardScreenState createState() => _CaseDashboardScreenState();
}

class _CaseDashboardScreenState extends State<CaseDashboardScreen> {
  final List<Map<String, dynamic>> cases = [
    {
      "Case Id": "HN1001",
      "title": "Food Assistance",
      "category": "Food Need",
      "location": "Colombo",
      "status": "Pending",
      "assignedVolunteers": [],
      "description": "Food packets required for 50 families",
      "image": "https://via.placeholder.com/400x200.png?text=Food+Case"
    },
    {
      "Case Id": "HN1002",
      "title": "Medical Help for Elderly",
      "category": "Medical",
      "location": "Kandy",
      "status": "In Progress",
      "assignedVolunteers": [
        {
          "id": "V1002",
          "name": "Bob Smith",
          "category": "Medical",
          "rating": 4.8,
          "image": "https://i.pravatar.cc/150?img=2"
        }
      ],
      "description": "Elderly patients need medicines and checkup",
      "image": "https://via.placeholder.com/400x200.png?text=Medical+Case"
    },
    {
      "Case Id": "HN1003",
      "title": "School Supplies for Children",
      "category": "Education",
      "location": "Galle",
      "status": "Assigned",
      "assignedVolunteers": [
        {
          "id": "V1004",
          "name": "Diana Prince",
          "category": "Education",
          "rating": 4.6,
          "image": "https://i.pravatar.cc/150?img=4"
        }
      ],
      "description": "Stationery required for 100 students",
      "image": "https://via.placeholder.com/400x200.png?text=School+Supplies"
    },
    {
      "Case Id": "HN1004",
      "title": "Flood Relief",
      "category": "Disaster",
      "location": "Matara",
      "status": "Completed",
      "assignedVolunteers": [
        {
          "id": "V1003",
          "name": "Charlie Lee",
          "category": "Disaster",
          "rating": 4.2,
          "image": "https://i.pravatar.cc/150?img=3"
        }
      ],
      "description": "Flooded homes have been provided blankets and water",
      "image": "https://via.placeholder.com/400x200.png?text=Flood+Relief"
    },
  ];

  static const primaryRed = Color(0xFFEC1337);
  static const backgroundPink = Color(0xFFFCF8F9);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Added Completed tab
      child: Scaffold(
        backgroundColor: backgroundPink,
        appBar: AppBar(
          backgroundColor: primaryRed,
          title: const Text("Case Dashboard"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "All Cases"),
              Tab(text: "Assigned"),
              Tab(text: "In Progress"),
              Tab(text: "Pending"),
              Tab(text: "Completed"), // New tab
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildCaseList(cases),
            buildCaseList(cases.where((c) =>
                c['status'] == "Assigned" ||
                (c['assignedVolunteers'] != null && c['assignedVolunteers'].isNotEmpty)
            ).toList()),
            buildCaseList(cases.where((c) =>
                c['status'] == "In Progress" ||
                (c['assignedVolunteers'] != null && c['assignedVolunteers'].isNotEmpty)
            ).toList()),
            buildCaseList(cases.where((c) => c['status'] == "Pending").toList()),
            buildCaseList(cases.where((c) => c['status'] == "Completed").toList()), // Completed tab
          ],
        ),
      ),
    );
  }

  Widget buildCaseList(List<Map<String, dynamic>> caseList) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: caseList.length,
      itemBuilder: (context, index) {
        var c = caseList[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 5,
          child: ListTile(
            title: Text(c['title']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${c['category']} • ${c['location']}"),
                if (c['assignedVolunteers'] != null && c['assignedVolunteers'].isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "Volunteer: ${c['assignedVolunteers'].map((v) => v['name']).join(', ')}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.black87),
                    ),
                  ),
              ],
            ),
            trailing: Text(
              c['status'],
              style: TextStyle(
                color: c['status'] == "Pending"
                    ? Colors.orange
                    : c['status'] == "In Progress"
                        ? Colors.blue
                        : c['status'] == "Assigned"
                            ? Colors.purple
                            : Colors.green, // Completed is green
              ),
            ),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CaseDetailScreen(caseData: c)),
              );
              setState(() {}); // Refresh after returning from detail
            },
          ),
        );
      },
    );
  }
}
