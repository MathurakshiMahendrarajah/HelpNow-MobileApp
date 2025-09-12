import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class TrackTab extends StatefulWidget {
  final String? caseId;
  const TrackTab({super.key, this.caseId});

  @override
  State<TrackTab> createState() => _TrackTabState();
}

class _TrackTabState extends State<TrackTab> {
  final TextEditingController _caseIdController = TextEditingController();
  bool _loading = false;
  Map<String, dynamic>? _caseData;
  String? _errorMessage;

  final Color primaryRed = const Color(0xFFEC1337);
  final Color textAccent = const Color(0xFF9A4C59);
  final Color backgroundPink = const Color(0xFFFCF8F9);

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
      // GraphQL query to fetch the report by caseId
      final response = await Amplify.API
          .query(
            request: GraphQLRequest<String>(
              document: '''query GetUserCaseDetails(\$caseId: ID!) {
          getUserCaseDetails(caseId: \$caseId) {
            caseId
            name
            description
            location
            caseType
            status
            createdAt
          }
        }''',
              variables: {"caseId": caseId},
            ),
          )
          .response;

      debugPrint('GraphQL response: $response');

      final data = response.data;
      if (data == null) {
        setState(() {
          _errorMessage = 'No report found with this Case ID';
          _loading = false;
        });
        return;
      }

      // Parse JSON response
      final parsed = jsonDecode(data)['getUserCaseDetails'];
      if (parsed == null) {
        setState(() {
          _errorMessage = 'No report found with this Case ID';
          _loading = false;
        });
        return;
      }

      setState(() {
        _caseData = {
          'caseId': parsed['caseId'],
          'title': parsed['caseType'] ?? 'Case Report',
          'note': parsed['description'] ?? '',
          'location': parsed['location'] ?? '',
          'date': parsed['createdAt'] != null
              ? DateTime.parse(
                  parsed['createdAt'],
                ).toLocal().toString().split(' ')[0]
              : '',
          'status': parsed['status'] ?? 'Pending',
          'name': parsed['name'] ?? '',
        };
        _loading = false;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching report: $e';
        _loading = false;
      });
      debugPrint('Error fetching report: $e');
    }
  }

  Widget _buildCaseCard(Map<String, dynamic> data) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Case details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Case ID: ${data['caseId']}',
                    style: TextStyle(color: textAccent, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        'Status: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: primaryRed,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          data['status'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Reported on: ${data['date']}',
                    style: TextStyle(color: textAccent, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(data['note'] ?? '', style: TextStyle(color: textAccent)),
                  const SizedBox(height: 4),
                  Text(
                    'Location: ${data['location'] ?? ''}',
                    style: TextStyle(color: textAccent),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Replace image with icon
            const Icon(Icons.report, size: 50, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, IconData icon, bool active) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: active ? primaryRed : textAccent),
        Text(
          label,
          style: TextStyle(
            color: active ? primaryRed : textAccent,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPink,
      appBar: AppBar(
        backgroundColor: backgroundPink,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Track Case ID',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _caseIdController,
                    decoration: InputDecoration(
                      hintText: 'Enter Case ID',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _fetchCaseDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryRed,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Track',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Results
            if (_loading)
              const Center(child: CircularProgressIndicator())
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
