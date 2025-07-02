import 'package:flutter/material.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_formKey.currentState!.validate()) {
      // Handle send message logic here (e.g., API call)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent successfully!')),
      );
      // Clear form
      _formKey.currentState!.reset();
    }
  }

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

  Widget infoRow(IconData icon, String label, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(info)),
        ],
      ),
    );
  }

  Widget faqItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Text(answer)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Us')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "We'd love to hear from you. Reach out with questions, ideas, or to learn how you can get involved.",
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 16),

            sectionTitle('Contact Information'),
            infoRow(Icons.email, 'Email Us', 'contact@helpnow.org'),
            infoRow(Icons.phone, 'Call Us', '(123) 456-7890'),
            infoRow(
              Icons.location_on,
              'Visit Us',
              '123 Hope Street, Compassion City',
            ),

            sectionTitle('Send us a Message'),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Your Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your name'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _subjectController,
                    decoration: const InputDecoration(
                      labelText: 'Subject',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter a subject'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      labelText: 'Your Message',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your message'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _sendMessage,
                    child: const Text('Send Message'),
                  ),
                ],
              ),
            ),

            sectionTitle('Frequently Asked Questions'),
            faqItem(
              'How does HelpNow work?',
              'HelpNow connects concerned citizens with NGOs and volunteers. Users report individuals in need, organizations receive these reports, and action is taken to provide assistance.',
            ),
            faqItem(
              'How can my organization join?',
              'We welcome NGOs and community organizations to partner with us. Please contact us using the form above, and our partnerships team will guide you through the registration process.',
            ),
            faqItem(
              'How can I volunteer?',
              'We\'re always looking for compassionate volunteers. You can start by contacting us, and we\'ll connect you with partner organizations that match your skills and availability.',
            ),
            faqItem(
              'Is my information secure?',
              'Absolutely. We take privacy and data security very seriously. All personal information is protected in accordance with data protection regulations.',
            ),
          ],
        ),
      ),
    );
  }
}
