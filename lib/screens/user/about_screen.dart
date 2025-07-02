import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget paragraph(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Text(text, style: const TextStyle(fontSize: 16, height: 1.5)),
    );
  }

  Widget teamMember(String name, String position, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          Text(
            position,
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(description, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About HelpNow')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            paragraph(
              'We connect those in need with organizations and volunteers who can make a meaningful difference.',
            ),
            sectionTitle('Our Mission'),
            paragraph(
              'At HelpNow, our mission is to create a seamless connection between individuals in need and the resources that can help them. We believe that everyone deserves dignity, support, and the opportunity for a better life.',
            ),
            paragraph(
              'Through our platform, we empower communities to identify and respond to vulnerable individuals quickly and effectively, ensuring that no one falls through the cracks of our social safety net.',
            ),
            paragraph(
              'We envision a world where technology amplifies human compassion, making it easier than ever to reach out and make a positive impact on someone\'s life.',
            ),

            sectionTitle('Our Core Values'),
            paragraph('The principles that guide everything we do'),

            const SizedBox(height: 8),
            Text(
              'Compassion',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.green[700],
              ),
            ),
            paragraph(
              'We approach every person with genuine care, understanding, and respect for their dignity.',
            ),
            Text(
              'Impact',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.green[700],
              ),
            ),
            paragraph(
              'We focus on creating meaningful, measurable change in the lives of those we help.',
            ),
            Text(
              'Community',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.green[700],
              ),
            ),
            paragraph(
              'We believe in the power of people coming together to support each other.',
            ),
            Text(
              'Innovation',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.green[700],
              ),
            ),
            paragraph(
              'We constantly seek better ways to connect people with the help they need.',
            ),

            sectionTitle('Our Team'),
            paragraph('The passionate people behind HelpNow'),

            teamMember(
              'Sarah Johnson',
              'Founder & Executive Director',
              'With 15+ years of experience in social work, Sarah founded HelpNow to bridge the gap between technology and humanitarian aid.',
            ),
            teamMember(
              'David Chen',
              'Technology Director',
              'David brings his expertise in tech for social good, leading our platform development with a focus on accessibility and ease of use.',
            ),
            teamMember(
              'Maya Patel',
              'NGO Partnerships Manager',
              'Maya coordinates our network of NGO partners, ensuring seamless collaboration to maximize our collective impact.',
            ),

            paragraph(
              'Our team also includes dozens of dedicated volunteers and partner organizations who make our work possible.',
            ),

            sectionTitle('Get in Touch With Our Team'),
            paragraph('Join Our Mission'),
            paragraph(
              'There are many ways to get involved and make a difference',
            ),
          ],
        ),
      ),
    );
  }
}
