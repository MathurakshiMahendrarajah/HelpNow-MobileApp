import 'package:flutter/material.dart';

class CaseTable extends StatefulWidget {
  const CaseTable({super.key});

  @override
  State<CaseTable> createState() => _CaseTableState();
}

class _CaseTableState extends State<CaseTable> {
  String filter = "All";
  List<Map<String, dynamic>> caseList = [
    {
      'id': 'C001',
      'date': '2025-06-01',
      'location': 'Colombo',
      'status': 'Pending'
    },
    {
      'id': 'C002',
      'date': '2025-06-02',
      'location': 'Kandy',
      'status': 'In Progress'
    },
    {
      'id': 'C003',
      'date': '2025-06-05',
      'location': 'Galle',
      'status': 'Solved'
    }
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredCases = filter == "All"
        ? caseList
        : caseList.where((c) => c['status'] == filter).toList();

    return Column(
      children: [
        // Search + Filter
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search by Case ID',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  // Optional: implement real search
                },
              ),
            ),
            const SizedBox(width: 10),
            DropdownButton<String>(
              value: filter,
              items: ['All', 'Pending', 'In Progress', 'Solved']
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => filter = value);
              },
            )
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith(
                (states) => Colors.deepPurple.shade50,
              ),
              columns: const [
                DataColumn(label: Text('Case ID')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Location')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Actions')),
              ],
              rows: filteredCases.map((c) {
                return DataRow(
                  cells: [
                    DataCell(Text(c['id'])),
                    DataCell(Text(c['date'])),
                    DataCell(Text(c['location'])),
                    DataCell(Text(c['status'])),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          tooltip: 'Change Status',
                          onPressed: () {
                            // Change status logic
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.person_add),
                          tooltip: 'Assign Volunteer',
                          onPressed: () {
                            // Assign volunteer + simulate notification
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Volunteer assigned!')),
                            );
                          },
                        ),
                      ],
                    )),
                  ],
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}
