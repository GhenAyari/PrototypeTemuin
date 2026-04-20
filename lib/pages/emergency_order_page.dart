import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chat_page.dart'; // Pastikan import ini ada buat pindah ke halaman chat

class EmergencyOrderPage extends StatefulWidget {
  const EmergencyOrderPage({super.key});

  @override
  State<EmergencyOrderPage> createState() => _EmergencyOrderPageState();
}

class _EmergencyOrderPageState extends State<EmergencyOrderPage> {
  String selectedService = "Tukang Ledeng";

  final List<Map<String, dynamic>> services = [
    {"name": "Tukang Ledeng", "icon": Icons.plumbing},
    {"name": "Ahli Kunci", "icon": Icons.vpn_key},
    {"name": "Montir Panggilan", "icon": Icons.build},
    {"name": "Tukang Listrik", "icon": Icons.electric_bolt},
  ];

  void _showFoundProviderModal(String serviceName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Tukang Ditemukan!",
                style: GoogleFonts.poppins(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  color: const Color(0xFF0F765E)
                ),
              ),
              const SizedBox(height: 24),
              const CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&q=80&w=200'),
              ),
              const SizedBox(height: 12),
              Text(
                "Rudiniger",
                style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                serviceName, 
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 18),
                  const SizedBox(width: 4),
                  Text("4.9 (88 Ulasan)", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.chat_bubble, color: Colors.white),
                  label: Text("Chat Sekarang", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF735BF2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    // Tutup modal
                    Navigator.pop(context);
                    // Pindah ke halaman chat
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatPage(providerName: "Rudiniger"),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Panggil Jasa Darurat")),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            color: Colors.blue.shade50,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 50, color: Colors.red),
                  Text("Lokasi Anda: Jl. Pramuka, Samarinda", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Pilih Jasa yang Dibutuhkan:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: services.length,
              itemBuilder: (context, index) {
                bool isSelected = selectedService == services[index]['name'];
                return GestureDetector(
                  onTap: () => setState(() => selectedService = services[index]['name']),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFEDE8FF) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF735BF2) : Colors.grey.shade200,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(services[index]['icon'], 
                          color: isSelected ? const Color(0xFF735BF2) : Colors.grey),
                        const SizedBox(width: 16),
                        Text(
                          services[index]['name'],
                          style: GoogleFonts.poppins(
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: isSelected ? const Color(0xFF1A1A1A) : Colors.grey.shade700,
                          ),
                        ),
                        const Spacer(),
                        if (isSelected) 
                          const Icon(Icons.check_circle, color: Color(0xFF735BF2))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF735BF2), 
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              onPressed: () async {
                // 1. Munculin Radar
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const SearchRadarDialog(),
                );

                // 2. Tunggu 3 detik (Simulasi cari tukang)
                await Future.delayed(const Duration(seconds: 3));

                // 3. Tutup radar
                if (!mounted) return;
                Navigator.pop(context);

                // 4. Munculin Modal Tukang (Rudiniger)
                _showFoundProviderModal(selectedService);
              },
              child: Text(
                "FIND ${selectedService.toUpperCase()} NOW",
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SearchRadarDialog extends StatefulWidget {
  const SearchRadarDialog({super.key});

  @override
  State<SearchRadarDialog> createState() => _SearchRadarDialogState();
}

class _SearchRadarDialogState extends State<SearchRadarDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF735BF2).withOpacity(1 - _controller.value),
                  border: Border.all(color: const Color(0xFF735BF2), width: 2),
                ),
                child: const Icon(Icons.search, color: Colors.white, size: 50),
              );
            },
          ),
          const SizedBox(height: 20),
          Text("Searching for Skills...", 
            style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}