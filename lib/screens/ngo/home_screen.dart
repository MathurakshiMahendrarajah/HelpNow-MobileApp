import 'package:flutter/material.dart';
import 'case_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _NGODashboardScreenState();
}

class _NGODashboardScreenState extends State<HomeScreen> {
  final List<Map<String, String>> dummyCases = [
    {'title': 'Food Distribution', 'status': 'Pending', 'location': 'Colombo'},
    {'title': 'Flood Relief', 'status': 'In Progress', 'location': 'Galle'},
    {'title': 'Medical Camp', 'status': 'Solved', 'location': 'Jaffna'},
  ];

  String selectedStatus = 'All Cases';

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredCases = selectedStatus == 'All Cases'
        ? dummyCases
        : dummyCases
            .where((caseItem) => caseItem['status'] == selectedStatus)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('NGO Dashboard'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Simulate data refresh
          await Future.delayed(const Duration(seconds: 1));
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Status Filters with Choice Chips
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: ['All Cases', 'Pending', 'In Progress', 'Solved']
                      .map(
                        (status) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ChoiceChip(
                            label: Text(status),
                            selected: selectedStatus == status,
                            selectedColor: Colors.deepPurpleAccent,
                            onSelected: (val) {
                              setState(() {
                                selectedStatus = status;
                              });
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),

              // Display Cases as Cards
              Expanded(
                child: ListView.builder(
                  itemCount: filteredCases.length,
                  itemBuilder: (context, index) {
                    final caseItem = filteredCases[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CaseListScreen(status: caseItem['status']!),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(caseItem['title']!,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Status: ${caseItem['status']}",
                                      style: TextStyle(
                                          color: Colors.grey[700], fontSize: 14)),
                                  Text(caseItem['location']!,
                                      style: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontWeight: FontWeight.w500)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
