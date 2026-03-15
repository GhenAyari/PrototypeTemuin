import 'package:flutter/material.dart';
import '../models/service_provider.dart';

class BookingPage extends StatelessWidget {
  final ServiceProvider provider;

  const BookingPage({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Pemesanan')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Pesan jasa dari ${provider.name}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                labelText: 'Tanggal Pekerjaan (DD/MM/YYYY)',
                prefixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Deskripsi Kebutuhan Lengkap',
                alignLabelWithHint: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
                    content: const Text(
                      'Pesanan Berhasil Terkirim!\n\nPenyedia jasa akan segera menghubungi Anda.',
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      Center(
                        child: TextButton(
                          onPressed: () {
                            // Menutup dialog dan kembali ke Home Page (pop 3 kali)
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          },
                          child: const Text('Kembali ke Beranda'),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Kirim Pesanan', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}