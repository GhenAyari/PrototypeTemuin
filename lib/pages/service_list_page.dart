import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/service_provider.dart';
import 'service_detail_page.dart';

class ServiceListPage extends StatefulWidget {
  final String categoryName;

  const ServiceListPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<ServiceListPage> createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
  final Color bgPurple = const Color(0xFFFBFaff);
  final Color primaryPurple = const Color(0xFF533DEC);
  final Color lightPurple = const Color(0xFFEDE8FF);
  final Color textDark = const Color(0xFF1A1A1A);
  final Color textGray = const Color(0xFF8A8A8A);
  final Color tagBgColor = const Color(0xFF90F0D6);
  final Color tagTextColor = const Color(0xFF0F765E);

  // Data sekarang menggunakan Object ServiceProvider, bukan Map lagi
  final List<ServiceProvider> dummyDevelopers = [
    ServiceProvider(
      id: '1',
      name: 'Marcus Thorne',
      category: 'Web Developers',
      skill: 'Senior Full Stack Architect',
      rating: 4.9,
      price: 85,
      isTopRated: true,
      description: 'Specializing in React ecosystem and high-performance serverless...',
      tags: ['React', 'Node.js', 'AWS'],
      avatarUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&q=80&w=400',
    ),
    ServiceProvider(
      id: '2',
      name: 'Elena Rodriguez',
      category: 'Web Developers',
      skill: 'UI/UX & Brand Designer',
      rating: 5.0,
      price: 70,
      isTopRated: false,
      description: 'Expert in Vue.js and interactive UI/UX implementation. I bridge the gap...',
      tags: ['Vue 3', 'TypeScript', 'Tailwind'],
      avatarUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&q=80&w=400',
    ),
    ServiceProvider(
      id: '3',
      name: 'Julian Chen',
      category: 'Web Developers',
      skill: 'Python Developer',
      rating: 4.8,
      price: 65,
      isTopRated: false,
      description: 'Full-stack developer focused on Python/Django backends and robust...',
      tags: ['Python', 'PostgreSQL', 'Django'],
      avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=400',
    ),
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
        title: Text('Temuin', style: GoogleFonts.poppins(color: textDark, fontWeight: FontWeight.w600, fontSize: 18)),
        actions: [
          IconButton(icon: Icon(Icons.notifications, color: primaryPurple), onPressed: () {}),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text('MARKETPLACE', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: Colors.teal.shade700)),
                const SizedBox(height: 4),
                Text(widget.categoryName, style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF2B2052))),
                const SizedBox(height: 8),
                Text('Browse through our curated selection of high-end software architects and full-stack engineers.', style: GoogleFonts.poppins(color: textGray, fontSize: 13, height: 1.5)),
                const SizedBox(height: 20),
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
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              itemCount: dummyDevelopers.length,
              itemBuilder: (context, index) {
                return _buildDeveloperCard(dummyDevelopers[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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

  Widget _buildFilterSortButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: lightPurple, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Icon(icon, size: 16, color: primaryPurple),
          const SizedBox(width: 8),
          Text(label, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: textDark)),
        ],
      ),
    );
  }

  Widget _buildDeveloperCard(ServiceProvider dev) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: primaryPurple.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(dev.avatarUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
                ),
                if (dev.isTopRated)
                  Positioned(
                    bottom: -10,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: primaryPurple, borderRadius: BorderRadius.circular(12)),
                      child: Text('Top Rated', style: GoogleFonts.poppins(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dev.name, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: textDark)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: lightPurple, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                       Icon(Icons.star, color: primaryPurple, size: 14),
                      const SizedBox(width: 4),
                      Text(dev.rating.toString(), style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: primaryPurple)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(dev.description, style: GoogleFonts.poppins(color: textGray, fontSize: 13, height: 1.5)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: dev.tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: tagBgColor, borderRadius: BorderRadius.circular(16)),
                  child: Text(tag, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: tagTextColor)),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Starting at', style: GoogleFonts.poppins(color: textGray, fontSize: 11)),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(color: primaryPurple),
                        children: [
                          TextSpan(text: '\$${dev.price}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const TextSpan(text: '/hr', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke Detail Page yang sudah aman
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDetailPage(provider: dev)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPurple,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text('View Portfolio', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}