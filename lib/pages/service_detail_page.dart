import 'package:flutter/material.dart';
import '../models/service_provider.dart';
import 'booking_page.dart';

class ServiceDetailPage extends StatelessWidget {
  final ServiceProvider provider;

  const ServiceDetailPage({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Penyedia Jasa')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 250,
              color: Colors.blue[50],
              child: Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(provider.avatarUrl),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(provider.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(provider.skill, style: const TextStyle(fontSize: 16, color: Colors.blue)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 8),
                      Text('${provider.rating} Rating', style: const TextStyle(fontSize: 16)),
                      const Spacer(),
                      Text('Rp ${provider.price}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Divider(height: 48),
                  const Text('Deskripsi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(provider.description, style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.grey)),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookingPage(provider: provider)),
                        );
                      },
                      child: const Text('Pesan Jasa', style: TextStyle(fontSize: 18)),
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