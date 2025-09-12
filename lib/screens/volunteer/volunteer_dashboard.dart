import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/volunteer/volunteer_case_detail_screen.dart'; // Import Volunteer Case Detail Screen

class VolunteerDashboard extends StatefulWidget {
  @override
  _VolunteerDashboardScreenState createState() =>
      _VolunteerDashboardScreenState();
}

class _VolunteerDashboardScreenState extends State<VolunteerDashboard> {
  final List<Map<String, dynamic>> cases = [
    {
      "Case Id": "HN1001",
      "title": "Food Assistance",
      "category": "Food Need",
      "location": "Colombo",
      "status": "Pending",
      "assignedVolunteers": [],
      "description": "Food packets required for 50 families",
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
        },
      ],
      "description": "Elderly patients need medicines and checkup",
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
        },
      ],
      "description": "Stationery required for 100 students",
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
        },
      ],
      "description": "Flooded homes have been provided blankets and water",
    },
  ];

  static const primaryRed = Color(0xFFEC1337);
  static const backgroundPink = Color(0xFFFCF8F9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPink,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            DefaultTabController(
              length: 5,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(text: "All Cases"),
                      Tab(text: "Assigned"),
                      Tab(text: "In Progress"),
                      Tab(text: "Pending"),
                      Tab(text: "Completed"),
                    ],
                  ),
                  Container(
                    height: 500,
                    child: TabBarView(
                      children: [
                        buildCaseList(cases),
                        buildCaseList(
                          cases
                              .where(
                                (c) =>
                                    c['status'] == "Assigned" ||
                                    (c['assignedVolunteers'] != null &&
                                        c['assignedVolunteers'].isNotEmpty),
                              )
                              .toList(),
                        ),
                        buildCaseList(
                          cases
                              .where(
                                (c) =>
                                    c['status'] == "In Progress" ||
                                    (c['assignedVolunteers'] != null &&
                                        c['assignedVolunteers'].isNotEmpty),
                              )
                              .toList(),
                        ),
                        buildCaseList(
                          cases.where((c) => c['status'] == "Pending").toList(),
                        ),
                        buildCaseList(
                          cases
                              .where((c) => c['status'] == "Completed")
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCaseList(List<Map<String, dynamic>> caseList) {
    return ListView.builder(
      itemCount: caseList.length,
      itemBuilder: (context, index) {
        var c = caseList[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
          child: InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VolunteerCaseDetailScreen(caseData: c),
                ),
              );
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c['title'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          c['description'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${c['category']} • ${c['location']}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    c['status'],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(c['status']),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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
