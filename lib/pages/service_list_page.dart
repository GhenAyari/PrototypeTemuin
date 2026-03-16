// lib/pages/service_list_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceListPage extends StatefulWidget {
  final String categoryName;

  const ServiceListPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<ServiceListPage> createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
  // Warna sesuai desain
  final Color bgPurple = const Color(0xFFFBFaff);
  final Color primaryPurple = const Color(0xFF533DEC); // Sedikit lebih gelap
  final Color lightPurple = const Color(0xFFEDE8FF);
  final Color textDark = const Color(0xFF1A1A1A);
  final Color textGray = const Color(0xFF8A8A8A);
  final Color tagBgColor = const Color(0xFF90F0D6); // Hijau mint terang
  final Color tagTextColor = const Color(0xFF0F765E); // Hijau gelap

  // Data dummy khusus untuk tampilan ini agar sesuai gambar
  final List<Map<String, dynamic>> dummyDevelopers = [
    {
      'name': 'Marcus Thorne',
      'rating': '4.9',
      'isTopRated': true,
      'description': 'Specializing in React ecosystem and high-performance serverless...',
      'tags': ['React', 'Node.js', 'AWS'],
      'price': '85',
      'imageUrl': 'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&q=80&w=400',
    },
    {
      'name': 'Elena Rodriguez',
      'rating': '5.0',
      'isTopRated': false,
      'description': 'Expert in Vue.js and interactive UI/UX implementation. I bridge the gap...',
      'tags': ['Vue 3', 'TypeScript', 'Tailwind'],
      'price': '70',
      'imageUrl': 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&q=80&w=400',
    },
    {
      'name': 'Julian Chen',
      'rating': '4.8',
      'isTopRated': false,
      'description': 'Full-stack developer focused on Python/Django backends and robust...',
      'tags': ['Python', 'PostgreSQL', 'Django'],
      'price': '65',
      'imageUrl': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=400',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPurple,
      appBar: AppBar(
        backgroundColor: bgPurple,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Temuin',
          style: GoogleFonts.poppins(
            color: textDark,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: primaryPurple),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  'MARKETPLACE',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Colors.teal.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.categoryName, // Akan menampilkan "Web Developers" dsb
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2B2052), // Ungu sangat gelap
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Browse through our curated selection of high-end software architects and full-stack engineers.',
                  style: GoogleFonts.poppins(color: textGray, fontSize: 13, height: 1.5),
                ),
                const SizedBox(height: 20),
                // Filter & Sort Buttons
                Row(
                  children: [
                    _buildFilterSortButton(Icons.tune, 'Filter'),
                    const SizedBox(width: 12),
                    _buildFilterSortButton(Icons.sort, 'Sort'),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          
          // List of Services
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              itemCount: dummyDevelopers.length,
              itemBuilder: (context, index) {
                final dev = dummyDevelopers[index];
                return _buildDeveloperCard(dev);
              },
            ),
          ),
        ],
      ),
      // Bottom Nav (agar konsisten dengan gambar)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Aktif di tab Search/Marketplace
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryPurple,
        unselectedItemColor: Colors.grey.shade400,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'SEARCH'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'ORDERS'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'PROFILE'),
        ],
      ),
    );
  }

  // Widget untuk tombol Filter & Sort
  Widget _buildFilterSortButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: lightPurple,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: primaryPurple),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textDark,
            ),
          ),
        ],
      ),
    );
  }

  // Widget Card untuk setiap developer
  Widget _buildDeveloperCard(Map<String, dynamic> dev) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: primaryPurple.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Gambar & Badge Top Rated
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    dev['imageUrl'],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (dev['isTopRated'])
                  Positioned(
                    bottom: -10,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: primaryPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Top Rated',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Header Info (Nama & Rating)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dev['name'],
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: lightPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                     Icon(Icons.star, color: primaryPurple, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        dev['rating'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryPurple,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            
            // Deskripsi
            Text(
              dev['description'],
              style: GoogleFonts.poppins(color: textGray, fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 16),
            
            // Pill Tags
            Wrap(
              spacing: 8, // Jarak horizontal antar pill
              runSpacing: 8, // Jarak vertikal jika turun baris
              children: (dev['tags'] as List<String>).map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: tagBgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: tagTextColor,
                    ),
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 24),
            
            // Footer: Harga & Tombol Portfolio
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Starting at',
                      style: GoogleFonts.poppins(color: textGray, fontSize: 11),
                    ),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(color: primaryPurple),
                        children: [
                          TextSpan(
                            text: '\$${dev['price']}',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                            text: '/hr',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPurple,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'View Portfolio',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}