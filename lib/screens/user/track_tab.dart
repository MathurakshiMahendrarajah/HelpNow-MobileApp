import 'package:flutter/material.dart';

class TrackTab extends StatefulWidget {
  final String? caseId;

  const TrackTab({super.key, this.caseId});

  @override
  State<TrackTab> createState() => _CaseTrackerScreenState();
}

class _CaseTrackerScreenState extends State<TrackTab> {
  final TextEditingController _caseIdController = TextEditingController();
  bool _loading = false;
  Map<String, dynamic>? _caseData;

  @override
  void initState() {
    super.initState();
    if (widget.caseId != null) {
      _caseIdController.text = widget.caseId!;
      _fetchCaseDetails();
    }
  }

  void _fetchCaseDetails() async {
    setState(() {
      _loading = true;
    });

    await Future.delayed(const Duration(seconds: 2)); // Simulate fetch

    // Mock Case Data (replace with Firebase or API logic later)
    _caseData = {
      'location': 'Colombo, Sri Lanka',
      'note': 'Flood-affected area, needs clean water and food packs.',
      'date': '2025-06-14',
      'status': 'In Progress',
      'volunteer': 'Nimal Perera',
      'imageUrl': 'https://via.placeholder.com/150',
    };

    setState(() {
      _loading = false;
    });
  }

  Widget _buildCaseCard(Map<String, dynamic> data) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Case Details', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            _buildRow('Location', data['location']),
            _buildRow('Note', data['note']),
            _buildRow('Date', data['date']),
            _buildRow('Status', data['status']),
            if (data['volunteer'] != null)
              _buildRow('Assigned Volunteer', data['volunteer']),
            const SizedBox(height: 12),
            if (data['imageUrl'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  data['imageUrl'],
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Your Case'),
        backgroundColor: Color(0xFFFFCCBC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _caseIdController,
              decoration: InputDecoration(
                labelText: 'Enter Case ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _fetchCaseDetails,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_loading)
              const CircularProgressIndicator()
            else if (_caseData != null)
              Expanded(
                child: SingleChildScrollView(child: _buildCaseCard(_caseData!)),
              ),
          ],
        ),
      ),
    );
  }
}
