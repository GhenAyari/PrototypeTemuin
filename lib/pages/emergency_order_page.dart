import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Panggil Jasa Darurat")),
      body: Column(
        children: [
          // Simulasi Map / Lokasi Keberadaan
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
          // Pilihan Jasa (Horizontal atau Grid)
          // Ganti bagian ListView.builder di emergency_order_page.dart
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

// Update Button Panggil di bawah
Container(
  padding: const EdgeInsets.all(24),
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF735BF2), // Pakai primaryPurple
      minimumSize: const Size(double.infinity, 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
    ),
    onPressed: () {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const SearchRadarDialog(),
    
  );
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
    
   Future.delayed(const Duration(seconds: 3), () {
  if (!mounted) return;
  Navigator.pop(context); // Tutup radar

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text(
        "Provider found! On the way to your location.",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: const Color(0xFF735BF2),
      behavior: SnackBarBehavior.floating, // Wajib floating
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 150, // Muncul di atas
        left: 20,
        right: 20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      duration: const Duration(seconds: 4),
    ),
  );
});
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