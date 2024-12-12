import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutSTIPage extends StatelessWidget {
  const AboutSTIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About STI'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/sti.png', // Replace with your image asset
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),

            // Title
            const Text(
              'About STI College',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),

            // Description
            const Text(
              'STI College is one of the leading educational institutions in the Philippines, '
              'offering programs in Information Technology, Business, Hospitality Management, '
              'and Engineering. With a network of campuses across the country, STI is committed '
              'to providing innovative, industry-based education to students.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16.0),

            // Mission
            const Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              '''
We are an institution committed to provide knowledge through the development and delivery of superior learning systems.

We strive to provide optimum value to all our stakeholders—our students, our faculty members, our employees, our partners, our shareholders, and our community.

We will pursue this mission with utmost integrity, dedication, transparency, and creativity.
''',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16.0),

            // Vision
            const Text(
              'Our Vision',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'To be the leader in innovative and relevant education that nurtures individuals to become competent and responsible members of society.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16.0),

            // Courses Offered
            const Text(
              'Programs Offered',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              '- Information Technology\n'
              '- Business Administration\n'
              '- Hospitality and Tourism Management\n'
              '- Engineering\n'
              '- Health Sciences\n'
              '- Senior High School Programs',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),

            // Contact Information
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Website: www.sti.edu\n'
              'Email: info@sti.edu\n'
              'Phone: +63 2 8843 5701',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),

            // Contact Information
            const Text(
              'STI Hymn',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              '''
Aim high with STI

The future is here today

Fly high with STI

Be the best that you can be



Onward to tomorrow

With dignity and pride

A vision of excellence

Our resounding battle cry



Aim high with STI

The future is here today

Fly high with STI

Be the best that you can be
''',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 5.0),
            GestureDetector(
              onTap: () async {
                await launchUrlString(
                    'https://www.youtube.com/watch?v=WBjx7ZVsu2k');
              },
              child: const Text(
                'https://www.youtube.com/watch?v=WBjx7ZVsu2k',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
