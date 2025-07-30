import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

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
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.caseId != null) {
      _caseIdController.text = widget.caseId!;
      _fetchCaseDetails();
    }
  }

  Future<void> _fetchCaseDetails() async {
    final caseId = _caseIdController.text.trim();
    if (caseId.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a valid Case ID';
        _caseData = null;
      });
      return;
    }

    setState(() {
      _loading = true;
      _errorMessage = null;
      _caseData = null;
    });

    try {
      // GraphQL query to fetch report by caseId
      // Note: Replace 'listReports' or 'getReportByCaseId' with your actual query name
      const query = '''
        query GetReportByCaseId(\$caseId: String!) {
          listReports(filter: { caseId: { eq: \$caseId } }) {
            items {
              id
              caseId
              title
              description
              location
              createdAt
            }
          }
        }
      ''';

      final variables = {'caseId': caseId};

      final request = GraphQLRequest<String>(
        document: query,
        variables: variables,
      );

      final response = await Amplify.API.query(request: request).response;

      if (response.errors.isNotEmpty) {
        setState(() {
          _errorMessage =
              'Error fetching case details: ${response.errors.first.message}';
          _loading = false;
        });
        return;
      }

      final data = response.data;
      if (data == null) {
        setState(() {
          _errorMessage = 'No data returned from server';
          _loading = false;
        });
        return;
      }

      // Parse JSON string into Map
      final Map<String, dynamic> jsonData = await parseJson(data);

      final items = jsonData['listReports']['items'] as List<dynamic>;

      if (items.isEmpty) {
        setState(() {
          _errorMessage = 'No case found for Case ID: $caseId';
          _loading = false;
          _caseData = null;
        });
        return;
      }

      final caseItem = items.first as Map<String, dynamic>;

      setState(() {
        _caseData = {
          'location': caseItem['location'] ?? '',
          'note': caseItem['description'] ?? '',
          'date': caseItem['createdAt']?.substring(0, 10) ?? '',
          'status':
              'In Progress', // you can extend your schema to include status
          'volunteer': null,
          'imageUrl': null,
          'title': caseItem['title'] ?? '',
        };
        _loading = false;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch case details. Please try again.';
        _loading = false;
      });
      debugPrint('Error fetching case details: $e');
    }
  }

  // Helper method to parse JSON string safely
  Future<Map<String, dynamic>> parseJson(String data) async {
    return Future.microtask(
      () => data.isNotEmpty ? Map<String, dynamic>.from(jsonDecode(data)) : {},
    );
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
            Text(
              data['title'] ?? 'Case Details',
              style: Theme.of(context).textTheme.titleLarge,
            ),
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
        backgroundColor: const Color(0xFFFFCCBC),
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
            else if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red))
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
