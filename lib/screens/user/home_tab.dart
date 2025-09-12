import 'package:flutter/material.dart';

class UserHomeScreen extends StatelessWidget {
  final bool isMember;
  final String userName;
  final Function(int) onNavigateTab;

  const UserHomeScreen({
    super.key,
    required this.isMember,
    required this.userName,
    required this.onNavigateTab,
  });

  @override
  Widget build(BuildContext context) {
    const primaryRed = Color(0xFFEC1337);
    const secondaryMaroon = Color(0xFF9A4C59);
    const backgroundPink = Color(0xFFFCF8F9);

    return Scaffold(
      backgroundColor: backgroundPink,
      appBar: AppBar(
        backgroundColor: backgroundPink.withOpacity(0.9),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "HelpNow",
          style: TextStyle(color: secondaryMaroon, fontWeight: FontWeight.bold),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: NetworkImage(
              "https://lh3.googleusercontent.com/aida-public/AB6AXuDnRoeqsLq2OubRusXNEJtkYCx7RJYeUGw2kjUltUDNzmZGJpszvvtMlszhxxsJ_JQtOUDxWog7vrmIE4hNCADovfjNrj50jqUIne7hGzYv-YR2f4HDZJr5a5o9C3pvioNMHBmduQXxvaz-kzLWpMeYN8_FE3YFIhtT18yzIL277PvTTJ8_mxbh8PPQlEjshk9is2jHUCc6YwveNXKKrAoOIrd7fCuX-PcnC9k0AwM_z6vMSvAlvL8KoWVf4Bx6eYB_XpDiKsNW",
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, Dilini 👋",
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: secondaryMaroon,
              ),
            ),
            const SizedBox(height: 35),

            // Achievements
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Achievements",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "Keep up the great work!",
                      style: TextStyle(fontSize: 13, color: secondaryMaroon),
                    ),
                  ],
                ),
                Text(
                  "View All",
                  style: TextStyle(
                    color: primaryRed,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Example badges
            Row(
              children: [
                Expanded(
                  child: _buildBadge(
                    icon: Icons.volunteer_activism,
                    color: primaryRed,
                    title: "Community Hero",
                    subtitle: "5/5 Cases",
                    progress: 1.0,
                  ),
                ),
                Expanded(
                  child: _buildBadge(
                    icon: Icons.diversity_3,
                    color: primaryRed,
                    title: "First Responder",
                    subtitle: "5/10 Cases",
                    progress: 0.4,
                  ),
                ),
                Expanded(
                  child: _buildBadge(
                    icon: Icons.military_tech,
                    color: primaryRed,
                    title: "Guardian Angel",
                    subtitle: "0/25 Cases",
                    progress: 0.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 36,
            ), // Increased space between Achievements and Active Cases
            // Active Cases
            const Text(
              "Your Active Cases",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            _buildCaseCard(
              caseId: "RPT-1757689333816",
              location: "Kolonnawa, Colombo",
              description:
                  "Needs books and uniforms for children starting school.",
              typeOfNeed: "Education",
              status: "In Progress",
              statusColor: Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildCaseCard(
              caseId: "RPT-1757689192819",
              location: "Malabe, Colombo",
              description:
                  "Community requests dry rations for 15 displaced families.",
              typeOfNeed: "Food",
              status: "Pending Review",
              statusColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required double progress,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 6,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                backgroundColor: Colors.grey.shade200,
              ),
            ),
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: Icon(icon, color: color, size: 36),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          textAlign: TextAlign.center, // 👈 allow wrapping
          style: const TextStyle(fontSize: 12, color: Color(0xFF9A4C59)),
        ),
      ],
    );
  }

  Widget _buildCaseCard({
    required String caseId,
    required String location,
    required String description,
    required String typeOfNeed,
    required String status,
    required Color statusColor,
  }) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon box
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: statusColor.withOpacity(0.2),
              ),
              child: Icon(Icons.help, color: statusColor, size: 40),
            ),
            const SizedBox(width: 12),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Case ID: $caseId",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9A4C59),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Location: $location",
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Description: $description",
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      CircleAvatar(radius: 4, backgroundColor: statusColor),
                      const SizedBox(width: 6),
                      Text(
                        "Type of Need: $typeOfNeed",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9A4C59),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Status: $status",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
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
}
