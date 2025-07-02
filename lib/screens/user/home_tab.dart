import 'package:flutter/material.dart';
import 'package:helpnow_mobileapp/screens/user/user_login_screen.dart';

class UserHomeScreen extends StatelessWidget {
  final bool isMember;
  final String? userName;
  final void Function(int)? onNavigateTab; // New callback

  const UserHomeScreen({
    super.key,
    required this.isMember,
    this.userName,
    this.onNavigateTab, // Accept callback
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFFFCCBC),
        title: Text(
          isMember ? 'Welcome Back, $userName' : 'Welcome to HelpNow',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 6,
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image with overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: isMember
                  ? _buildMemberContent(context)
                  : _buildGuestContent(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero image
          const SizedBox(height: 18),
          Text(
            'Be the reason someone smiles today.',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: [Shadow(blurRadius: 8, color: Colors.black26)],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 100, // ← Set desired height here
                  child: _buildActionCard(
                    context,
                    title: 'Report Help',

                    icon: Icons.report_problem_rounded,
                    color: Colors.deepOrangeAccent,
                    gradient: const LinearGradient(
                      colors: [Colors.deepOrange, Colors.orangeAccent],
                    ),
                    onTap: () {
                      // Switch to the Report tab (index 1)
                      if (onNavigateTab != null) {
                        onNavigateTab!(1);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 100, // ← Same height for uniform look
                  child: _buildActionCard(
                    context,
                    title: 'Track My Case',
                    icon: Icons.track_changes_rounded,
                    color: Colors.deepOrangeAccent,
                    gradient: const LinearGradient(
                      colors: [Colors.deepOrange, Colors.orangeAccent],
                    ),
                    onTap: () {
                      // Switch to the Track tab (index 2)
                      if (onNavigateTab != null) {
                        onNavigateTab!(2);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),
          _buildInfoSection('Why Join HelpNow?', [
            'Track your reports anytime',
            'Get notified about updates',
            'Join a helping community',
          ]),
          const SizedBox(height: 32),
          Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 4,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              icon: Icon(Icons.person_add_alt_1, color: Colors.white),
              label: Text(
                'Create an Account',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget _buildMemberContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero image
          const SizedBox(height: 18),
          Text(
            'Here is your recent performance, $userName!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: [Shadow(blurRadius: 8, color: Colors.black26)],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Cases Reported',
                  '12',
                  Icons.assignment,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Resolved',
                  '8',
                  Icons.check_circle,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Pending',
                  '4',
                  Icons.hourglass_bottom,
                  Colors.amber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            'Recent Reports',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: [Shadow(blurRadius: 6, color: Colors.black26)],
            ),
          ),
          const SizedBox(height: 10),
          _buildReportItem('Water Leakage at Temple Road', 'Pending'),
          _buildReportItem('Accident at Cross Street', 'Resolved'),
          const SizedBox(height: 24),
          _buildProgressCard(),
          const SizedBox(height: 28),
          _buildInfoSection('Tips for Better Reports', [
            'Add a clear photo of the problem',
            'Mention accurate location',
            'Be respectful in description',
          ]),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required Gradient gradient,
    required VoidCallback onTap,
    String? image,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.25),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            if (image != null)
              Positioned(
                right: 8,
                bottom: 8,
                child: Opacity(
                  opacity: 0.18,
                  child: Image.asset(image, width: 60, height: 60),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(icon, color: color, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        shadows: [Shadow(blurRadius: 4, color: Colors.black26)],
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String count,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white.withOpacity(0.92),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.18),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 10),
            Text(
              count,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 13, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportItem(String title, String status) {
    final isResolved = status == 'Resolved';
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.white.withOpacity(0.96),
      child: ListTile(
        leading: Icon(
          isResolved ? Icons.check_circle : Icons.hourglass_bottom,
          color: isResolved ? Colors.green : Colors.amber,
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        trailing: Chip(
          label: Text(
            status,
            style: TextStyle(
              color: isResolved ? Colors.green[800] : Colors.amber[900],
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: isResolved ? Colors.green[100] : Colors.yellow[100],
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.teal[50]?.withOpacity(0.95),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Badge Progress',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.teal[900],
              ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Colors.teal[100],
              color: Colors.teal,
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 10),
            Text(
              '🌱 Beginner Helper → 🔥 Community Hero',
              style: TextStyle(
                color: Colors.teal[800],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<String> items) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.white.withOpacity(0.93),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.deepOrange,
              ),
            ),
            const SizedBox(height: 10),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, size: 18, color: Colors.teal),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
