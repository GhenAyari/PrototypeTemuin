// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:temuin/main.dart'; // Pastikan ini benar (mengarah ke file main.dart yang berisi themeNotifier)
import 'package:temuin/pages/service_list_page.dart';
import 'my_orders_page.dart';
import 'profile_page.dart';
import 'emergency_order_page.dart';
import 'search_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // HAPUS SEMUA DEKLARASI WARNA DI SINI

  @override
  Widget build(BuildContext context) {
    // 1. PINDAHKAN SEMUA VARIABEL WARNA KE DALAM FUNGSI BUILD
    // --- AMBIL WARNA OTOMATIS DARI main.dart ---
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    final Color bgPurple = Theme.of(context).scaffoldBackgroundColor;
    final Color primaryPurple = Theme.of(context).primaryColor;
    final Color lightPurple = Theme.of(context).cardColor;
    
    // Pakai '??' (fallback) supaya Flutter gak protes soal Null Safety
    final Color textDark = Theme.of(context).textTheme.bodyLarge?.color ?? const Color(0xFF1A1A1A);
    final Color textGray = Theme.of(context).textTheme.bodyMedium?.color ?? const Color(0xFF8A8A8A);

    return Scaffold(
      backgroundColor: bgPurple,
      appBar: AppBar(
        backgroundColor: bgPurple,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Temuin',
          style: GoogleFonts.poppins(
            color: textDark, // Menggunakan warna dinamis
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              color: primaryPurple,
            ),
            onPressed: () {
              // Ganti nilai notifier
              themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
              // Panggil setState agar fungsi build (dan perhitungan warna) dijalankan ulang
              setState(() {}); 
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: primaryPurple),
            onPressed: () {},
          ),
        ],
      ),
      // Konten utama yang bisa di-scroll
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // PENTING: Kamu harus mengirim warna dinamis ke dalam fungsi-fungsi builder ini
              _buildHeroText(textDark, primaryPurple),
              const SizedBox(height: 30),
              _buildSearchBar(lightPurple),
              const SizedBox(height: 20),
              GestureDetector(
  onTap: () {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const EmergencyOrderPage())
    );
  },
  child: Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      // Pakai gradasi dari ungu ke pink tua supaya eye-catching tapi tetap estetik
      gradient: const LinearGradient(
        colors: [Color(0xFF735BF2), Color(0xFF9B51E0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF735BF2).withOpacity(0.3),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.flash_on_rounded, color: Colors.white, size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Need Help Fast?",
                style: GoogleFonts.poppins(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "Emergency service at your door",
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 18),
      ],
    ),
  ),
),
              _buildSectionTitle('EXPLORE', 'Specialized Talent', textDark, primaryPurple),
              const SizedBox(height: 16),
              _buildSpecializedTalent(lightPurple, primaryPurple, textGray),
              const SizedBox(height: 40),
              _buildSectionTitle('HANDPICKED', 'Featured Providers', textDark, primaryPurple),
              const SizedBox(height: 16),
              _buildFeaturedProviders(lightPurple, primaryPurple, textGray, textDark),
              const SizedBox(height: 40),
              _buildSectionTitle(
                'TRENDING',
                'Popular Services',
                textDark,
                primaryPurple,
                showExploreAll: true,
              ),
              const SizedBox(height: 16),
              _buildPopularServices(textDark, textGray),
              const SizedBox(height: 40), // Spacing bawah
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          // TAMBAHKAN KODE INI DI SINI
          if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SearchPage()),
      );
    }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyOrdersPage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: bgPurple, // Ikuti warna background Scaffold
        selectedItemColor: primaryPurple,
        unselectedItemColor: textGray,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // --- WIDGET BUILDERS UNTUK SETIAP BAGIAN ---
  // Parameter fungsi telah diperbarui untuk menerima warna dinamis

  Widget _buildHeroText(Color textDark, Color primaryPurple) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.poppins(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: textDark,
          height: 1.1,
        ),
        children: [
          const TextSpan(text: 'Find the\nperfect '),
          TextSpan(
            text: 'human\nskill',
            style: TextStyle(color: primaryPurple),
          ),
          const TextSpan(text: ' for your\nnext project.'),
        ],
      ),
    );
  }

  Widget _buildSearchBar(Color lightPurple) {
    return Container(
      decoration: BoxDecoration(
        color: lightPurple,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'What are you looking for?',
          hintStyle: GoogleFonts.poppins(color: Colors.grey.shade600),
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
    String overline,
    String title,
    Color textDark,
    Color primaryPurple, {
    bool showExploreAll = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          overline,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.teal.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: textDark,
              ),
            ),
            if (showExploreAll)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ServiceListPage(
                        categoryName: 'Popular Services',
                      ),
                    ),
                  );
                },
                child: Text(
                  'Explore All',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryPurple,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecializedTalent(Color lightPurple, Color primaryPurple, Color textGray) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const ServiceListPage(categoryName: 'Web Developers'),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: lightPurple,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.code, color: primaryPurple, size: 28),
                  const SizedBox(height: 40),
                  Text(
                    'Developers',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '2.4k available',
                    style: GoogleFonts.poppins(color: textGray, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const ServiceListPage(categoryName: 'Designers'),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: lightPurple,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.palette, color: primaryPurple, size: 28),
                  const SizedBox(height: 40),
                  Text(
                    'Designers',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '1.8k available',
                    style: GoogleFonts.poppins(color: textGray, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedProviders(Color lightPurple, Color primaryPurple, Color textGray, Color textDark) {
    return Column(
      children: [
        // Card 1: Marcus Thorne (Top Rated)
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: lightPurple, // Diubah agar mengikuti tema
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&q=80&w=200',
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF67F5D1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'TOP RATED',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade900, // Tambahkan warna agar kontras di dark mode
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '4.9',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: textDark),
                  ),
                  Text(
                    ' (124 reviews)',
                    style: GoogleFonts.poppins(color: textGray, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Marcus Thorne',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Senior Full Stack Architect specializing in React and Node ecosystem with 12+ years experience.',
                style: GoogleFonts.poppins(
                  color: textGray,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildTag('REACT', const Color(0xFF67F5D1)),
                  const SizedBox(width: 8),
                  _buildTag('AWS', const Color(0xFF67F5D1)),
                  const SizedBox(width: 8),
                  _buildTag('ARCHITECTURE', const Color(0xFF67F5D1)),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ServiceListPage(
                          categoryName: 'Featured Providers',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Explore All',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Card 2: Elena Rodriguez (Medium Card)
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: lightPurple,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: const NetworkImage(
                      'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&q=80&w=150',
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$85/hr',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textDark,
                        ),
                      ),
                      Text(
                        'Base Rate',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: textGray,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Elena Rodriguez',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    Text(
                      'UI/UX & Brand Designer',
                      style: GoogleFonts.poppins(color: textGray, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '5.0',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: textDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: textDark == Colors.white ? const Color(0xFF2C2C2C) : Colors.white, // Adaptasi warna tombol
                    foregroundColor: textDark == Colors.white ? Colors.white : const Color(0xFF1A1A1A),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Contact',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Card 3 & 4: Small List Tiles
        _buildSmallProviderCard(
          'Julian Vax',
          'Cloud Consultant',
          '4.8',
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=100',
          lightPurple,
          textDark,
          textGray
        ),
        const SizedBox(height: 12),
        _buildSmallProviderCard(
          'Sarah Chen',
          'Python Developer',
          '4.9',
          'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&q=80&w=100',
          lightPurple,
          textDark,
          textGray
        ),
        const SizedBox(height: 16),

        // Become a Provider Button
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: lightPurple, width: 2),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryPurple.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Become a Provider',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: textDark),
                  ),
                  Text(
                    'Join our curated list',
                    style: GoogleFonts.poppins(color: textGray, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: Colors.teal.shade900,
        ),
      ),
    );
  }

  Widget _buildSmallProviderCard(
    String name,
    String role,
    String rating,
    String imageUrl,
    Color lightPurple,
    Color textDark,
    Color textGray
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightPurple, // Adaptasi warna card
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: textDark),
                ),
                Text(
                  role,
                  style: GoogleFonts.poppins(color: textGray, fontSize: 12),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 14),
              const SizedBox(width: 4),
              Text(
                rating,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPopularServices(Color textDark, Color textGray) {
    return Column(
      children: [
        _buildServiceCard(
          'https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&q=80&w=600',
          'ANALYTICS',
          'Custom Business Intelligence Dashboards',
          'Starting from \$450 • 3 day delivery',
          textDark,
          textGray
        ),
        const SizedBox(height: 24),
        _buildServiceCard(
          'https://images.unsplash.com/photo-1626785774573-4b799315345d?auto=format&fit=crop&q=80&w=600',
          'BRANDING',
          'Minimalist Visual Identity Package',
          'Starting from \$800 • 1 week delivery',
          textDark,
          textGray
        ),
        const SizedBox(height: 24),
        _buildServiceCard(
          'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&q=80&w=600',
          'SYSTEMS',
          'End-to-End Cloud Migration',
          'Starting from \$1,200 • 2 week delivery',
          textDark,
          textGray
        ),
      ],
    );
  }

  Widget _buildServiceCard(
    String imageUrl,
    String tag,
    String title,
    String subtitle,
    Color textDark,
    Color textGray
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tag,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.black, // Tetap hitam agar kontras dengan background putih transparan
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: textDark),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: GoogleFonts.poppins(color: textGray, fontSize: 12),
        ),
      ],
    );
  }
}