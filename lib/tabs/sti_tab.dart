import 'package:flutter/material.dart';

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
              'To provide holistic education that equips students with the necessary skills '
              'and values to succeed in their chosen fields.',
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
              'To be the leader in innovative and technology-based education in the Philippines.',
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
          ],
        ),
      ),
    );
  }
}
