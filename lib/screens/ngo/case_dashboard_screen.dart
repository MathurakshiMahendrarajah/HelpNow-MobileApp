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
      "title": "Ramesh Perera",
      "category": "Food",
      "location": "Wellawatte, Colombo",
      "status": "Pending",
      "assignedVolunteers": [],
      "description": "Family struggling to afford daily meals due to unemployment.",
      "image": "https://via.placeholder.com/400x200.png?text=Food+Case"
    },
    {
      "Case Id": "HN1002",
      "title": "Nirosha Silva",
      "category": "Education",
      "location": "Dehiwala, Colombo",
      "status": "Pending",
      "assignedVolunteers": [],
      "description": "Single mother needs support to buy school books for two children.",
      "image": "https://via.placeholder.com/400x200.png?text=Education+Case"
    },
    {
      "Case Id": "HN1003",
      "title": "Kamal Fernando",
      "category": "Health",
      "location": "Borella, Colombo",
      "status": "Pending",
      "assignedVolunteers": [],
      "description": "Elderly couple in need of medical assistance and medicines.",
      "image": "https://via.placeholder.com/400x200.png?text=Health+Case"
    },
    {
      "Case Id": "HN1004",
      "title": "Shanika Jayawardena",
      "category": "Education",
      "location": "Nugegoda, Colombo",
      "status": "In Progress",
      "assignedVolunteers": [],
      "description": "Student requires laptop for online university studies.",
      "image": "https://via.placeholder.com/400x200.png?text=Education+Case"
    },
    {
      "Case Id": "HN1005",
      "title": "Mohamed Rizwan",
      "category": "Food",
      "location": "Pettah, Colombo",
      "status": "In Progress",
      "assignedVolunteers": [],
      "description": "Small business owner seeks food packages for flood-affected workers.",
      "image": "https://via.placeholder.com/400x200.png?text=Food+Case"
    },
    {
      "Case Id": "HN1006",
      "title": "Dilini Wickramasinghe",
      "category": "Shelter",
      "location": "Mount Lavinia, Colombo",
      "status": "Assigned",
      "assignedVolunteers": [],
      "description": "Family needs temporary shelter after house fire.",
      "image": "https://via.placeholder.com/400x200.png?text=Shelter+Case"
    },
    {
      "Case Id": "HN1007",
      "title": "Suresh Kumar",
      "category": "Financial",
      "location": "Kirulapone, Colombo",
      "status": "Assigned",
      "assignedVolunteers": [],
      "description": "Needs assistance with monthly rent as job was lost recently.",
      "image": "https://via.placeholder.com/400x200.png?text=Financial+Case"
    },
    {
      "Case Id": "HN1008",
      "title": "Tharushi Gunawardena",
      "category": "Education",
      "location": "Kolonnawa, Colombo",
      "status": "Completed",
      "assignedVolunteers": [],
      "description": "Needs books and uniforms for children starting school.",
      "image": "https://via.placeholder.com/400x200.png?text=Education+Case"
    },
    {
      "Case Id": "HN1009",
      "title": "Janaka Abeywardena",
      "category": "Food",
      "location": "Malabe, Colombo",
      "status": "Completed",
      "assignedVolunteers": [],
      "description": "Community requests dry rations for 15 displaced families.",
      "image": "https://via.placeholder.com/400x200.png?text=Food+Case"
    },
    {
      "Case Id": "HN1010",
      "title": "Shalini Peris",
      "category": "Health",
      "location": "Battaramulla, Colombo",
      "status": "Completed",
      "assignedVolunteers": [],
      "description": "Patient requires transport support for regular hospital visits.",
      "image": "https://via.placeholder.com/400x200.png?text=Health+Case"
    },
  ];

  static const primaryRed = Color(0xFFEC1337);
  static const backgroundPink = Color(0xFFFCF8F9);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
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
              Tab(text: "Completed"),
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
            buildCaseList(cases.where((c) => c['status'] == "Completed").toList()),
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
                            : Colors.green,
              ),
            ),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CaseDetailScreen(caseData: c)),
              );
              setState(() {});
            },
          ),
        );
      },
    );
  }
}
