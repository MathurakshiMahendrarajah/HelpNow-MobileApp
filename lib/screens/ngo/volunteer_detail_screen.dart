import 'package:flutter/material.dart';
import 'case_detail_screen.dart';

class VolunteerDetailScreen extends StatefulWidget {
  final Map<String, dynamic> volunteerData;
  VolunteerDetailScreen({required this.volunteerData});

  @override
  State<VolunteerDetailScreen> createState() => _VolunteerDetailScreenState();
}

class _VolunteerDetailScreenState extends State<VolunteerDetailScreen> {
  static const primaryRed = Color(0xFFEC1337);
  static const secondaryMaroon = Color(0xFF9A4C59);
  static const backgroundPink = Color(0xFFFCF8F9);

  String selectedStatus = "Pending"; // Default selected statistic

  // Dummy cases for demonstration
  final List<Map<String, dynamic>> dummyCases = [
    {
      "caseTitle": "Food Assistance",
      "status": "Pending",
      "progressPercent": 10,
      "assignedVolunteers": [],
    },
    {
      "caseTitle": "Medical Help for Elderly",
      "status": "Assigned",
      "progressPercent": 40,
      "assignedVolunteers": [
        {"id": "V1002", "name": "Bob Smith"}
      ],
    },
    {
      "caseTitle": "School Supplies for Children",
      "status": "In Progress",
      "progressPercent": 60,
      "assignedVolunteers": [
        {"id": "V1003", "name": "Charlie Lee"}
      ],
    },
    {
      "caseTitle": "Flood Relief",
      "status": "Completed",
      "progressPercent": 100,
      "assignedVolunteers": [
        {"id": "V1001", "name": "Alice Johnson"}
      ],
    },
    {
      "caseTitle": "Clothes Distribution",
      "status": "Completed",
      "progressPercent": 100,
      "assignedVolunteers": [
        {"id": "V1002", "name": "Bob Smith"}
      ],
    },
    {
      "caseTitle": "Medical Camp",
      "status": "Assigned",
      "progressPercent": 50,
      "assignedVolunteers": [
        {"id": "V1003", "name": "Charlie Lee"}
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter cases based on selected status
    List<Map<String, dynamic>> filteredCases = dummyCases.where((c) {
      switch (selectedStatus) {
        case "Pending":
          return c['status'] == "Pending";
        case "Assigned/In Progress":
          return c['status'] == "Assigned" || c['status'] == "In Progress";
        case "Completed":
          return c['status'] == "Completed";
        case "Total":
          return true;
        default:
          return false;
      }
    }).toList();

    // Count for statistics cards
    int pendingCount = dummyCases.where((c) => c['status'] == "Pending").length;
    int assignedCount = dummyCases.where((c) => c['status'] == "Assigned" || c['status'] == "In Progress").length;
    int completedCount = dummyCases.where((c) => c['status'] == "Completed").length;
    int totalCount = dummyCases.length;

    return Scaffold(
      backgroundColor: backgroundPink,
      appBar: AppBar(
        backgroundColor: primaryRed,
        title: Text(widget.volunteerData['name']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Profile info
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: widget.volunteerData['image'] != null
                    ? NetworkImage(widget.volunteerData['image'])
                    : null,
                backgroundColor: Colors.grey[300],
                child: widget.volunteerData['image'] == null
                    ? const Icon(Icons.person, size: 50, color: Colors.grey)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                widget.volunteerData['name'],
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: secondaryMaroon),
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                "Volunteer ID: ${widget.volunteerData['id']}",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                widget.volunteerData['location'] ?? "",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ),
            const SizedBox(height: 12),
            // 🔹 Ratings
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.amber, size: 22),
                const SizedBox(width: 4),
                Text(
                  "${widget.volunteerData['rating'] ?? 0.0} / 5.0",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // 🔹 Active status
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Status: ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Chip(
                  label: Text(widget.volunteerData['isActive'] == true ? "Active" : "Inactive"),
                  backgroundColor: widget.volunteerData['isActive'] == true ? Colors.green : Colors.grey,
                  labelStyle: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 🔹 Statistics cards (clickable)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard("Pending", pendingCount, Colors.orange),
                _buildStatCard("Assigned/In Progress", assignedCount, Colors.purple),
                _buildStatCard("Completed", completedCount, Colors.green),
                _buildStatCard("Total", totalCount, primaryRed),
              ],
            ),
            const SizedBox(height: 16),

            // 🔹 Case list based on selected statistic
            Column(
              children: filteredCases.map((c) {
                double progressPercent = c['progressPercent']?.toDouble() ?? 0.0;
                String status = c['status'] ?? "Pending";

                Color statusColor;
                switch (status) {
                  case "Pending":
                    statusColor = Colors.orange;
                    break;
                  case "In Progress":
                  case "Assigned":
                    statusColor = Colors.blue;
                    break;
                  case "Completed":
                    statusColor = Colors.green;
                    break;
                  default:
                    statusColor = Colors.grey;
                }

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 3,
                  child: ListTile(
                    title: Text(c['caseTitle']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LinearProgressIndicator(
                          value: progressPercent / 100,
                          backgroundColor: Colors.grey[300],
                          color: statusColor,
                          minHeight: 8,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${progressPercent.toStringAsFixed(0)}% Completed",
                          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        ),
                        if (c['assignedVolunteers'] != null && c['assignedVolunteers'].isNotEmpty)
                          Text(
                            "Volunteer(s): ${c['assignedVolunteers'].map((v) => v['name']).join(', ')}",
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),
                    trailing: Chip(
                      label: Text(status),
                      backgroundColor: statusColor,
                      labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CaseDetailScreen(caseData: c),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Reusable statistic card
  Widget _buildStatCard(String title, int value, Color color) {
    bool isSelected = (selectedStatus == title) ||
        (title == "Assigned/In Progress" && selectedStatus == "Assigned/In Progress");
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedStatus = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? primaryRed : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : color),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: isSelected ? Colors.white : Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
