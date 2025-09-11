import 'package:flutter/material.dart';

class CaseDetailScreen extends StatefulWidget {
  final Map<String, dynamic> caseData;
  CaseDetailScreen({required this.caseData});

  @override
  State<CaseDetailScreen> createState() => _CaseDetailScreenState();
}

class _CaseDetailScreenState extends State<CaseDetailScreen> {
  static const primaryRed = Color(0xFFEC1337);
  static const secondaryMaroon = Color(0xFF9A4C59);

  // Dummy volunteer list
  final List<Map<String, dynamic>> volunteers = [
    {
      "id": "V1001",
      "name": "Alice Johnson",
      "category": "Food Need",
      "rating": 4.5,
      "image": "https://i.pravatar.cc/150?img=1"
    },
    {
      "id": "V1002",
      "name": "Bob Smith",
      "category": "Medical",
      "rating": 4.8,
      "image": "https://i.pravatar.cc/150?img=2"
    },
    {
      "id": "V1003",
      "name": "Charlie Lee",
      "category": "Disaster",
      "rating": 4.2,
      "image": "https://i.pravatar.cc/150?img=3"
    },
  ];

  List<Map<String, dynamic>> assignedVolunteers = [];

  final List<Map<String, String>> relatedCases = [
    {
      "Case Id": "HN2001",
      "title": "Flood Relief Materials",
      "category": "Disaster",
      "location": "Matara",
      "status": "Pending"
    },
    {
      "Case Id": "HN2002",
      "title": "Medical Help for Children",
      "category": "Medical",
      "location": "Kandy",
      "status": "In Progress"
    },
  ];

  @override
  void initState() {
    super.initState();
    assignedVolunteers = List<Map<String, dynamic>>.from(widget.caseData['assignedVolunteers'] ?? []);
  }

  void _assignVolunteer() async {
    final availableVolunteers = volunteers
        .where((v) => v['category'] == widget.caseData['category'])
        .toList();

    if (availableVolunteers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No volunteers available for this category.")),
      );
      return;
    }

    final selectedVolunteer = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Select Volunteer",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ...availableVolunteers.map((v) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(v['image']),
                ),
                title: Text(v['name']),
                subtitle: Text("${v['category']} • ⭐ ${v['rating']}"),
                onTap: () => Navigator.pop(context, v),
              );
            }).toList(),
          ],
        );
      },
    );

    if (selectedVolunteer != null) {
      setState(() {
        assignedVolunteers.add(selectedVolunteer);
        widget.caseData['assignedVolunteers'] = assignedVolunteers;
        widget.caseData['status'] = "Assigned";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Volunteer ${selectedVolunteer['name']} assigned successfully!"),
        ),
      );
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange;
      case "In Progress":
        return Colors.blue;
      case "Assigned":
        return Colors.purple;
      case "Completed":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final caseData = widget.caseData;

    return Scaffold(
      appBar: AppBar(
        title: Text(caseData['title']),
        backgroundColor: primaryRed,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Case ID + Status
            Row(
              children: [
                Text(
                  "Case ID: ${caseData['Case Id']}",
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
                const Spacer(),
                Chip(
                  label: Text(caseData['status'] ?? "Unknown"),
                  backgroundColor: _getStatusColor(caseData['status'] ?? ""),
                  labelStyle: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Case Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(caseData['image'] ??
                      "https://via.placeholder.com/400x200.png?text=Case+Image"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Category + location
            Text(
              "${caseData['category']} • ${caseData['location']}",
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: secondaryMaroon),
            ),
            const SizedBox(height: 16),

            // Assign Volunteer button (only if Pending)
            if (caseData['status'] == "Pending")
              ElevatedButton(
                onPressed: _assignVolunteer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text("Assign Volunteer"),
              ),

            // Assigned Volunteer details (only if Assigned)
            if (caseData['status'] == "Assigned" && assignedVolunteers.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                "Assigned Volunteer",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: secondaryMaroon),
              ),
              const SizedBox(height: 8),
              Column(
                children: assignedVolunteers.map((vol) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(vol['image']),
                      ),
                      title: Text(vol['name']),
                      subtitle: Text("ID: ${vol['id']} • ⭐ ${vol['rating']}"),
                    ),
                  );
                }).toList(),
              ),
            ],

            const SizedBox(height: 16),

            // Reporter
            const Text(
              "Reported by: John Doe",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              caseData['description'] ??
                  "Description of the case goes here. Details about the problem, urgency, and help required.",
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 24),

            // Related Cases
            const Text(
              "Related Cases",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: secondaryMaroon),
            ),
            const SizedBox(height: 12),
            Column(
              children: relatedCases.map((c) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 3,
                  child: ListTile(
                    title: Text(c['title']!),
                    subtitle: Text("${c['category']} • ${c['location']}"),
                    leading: Text(
                      c['Case Id']!,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    trailing: Text(
                      c['status']!,
                      style: TextStyle(color: _getStatusColor(c['status']!)),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
