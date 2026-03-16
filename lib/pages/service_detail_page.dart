import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/service_provider.dart';
import 'booking_page.dart'; 
import 'chat_page.dart';

class ServiceDetailPage extends StatelessWidget {
  final ServiceProvider provider;

  const ServiceDetailPage({Key? key, required this.provider}) : super(key: key);

  final Color bgPurple = const Color(0xFFFBFaff);
  final Color primaryPurple = const Color(0xFF533DEC);
  final Color textDark = const Color(0xFF1A1A1A);
  final Color textGray = const Color(0xFF8A8A8A);
  final Color greenHeading = const Color(0xFF0F765E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPurple,
      appBar: AppBar(
        backgroundColor: bgPurple,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context)),
        title: Text('Temuin',
            style: GoogleFonts.poppins(
                color: textDark, fontWeight: FontWeight.w600, fontSize: 18)),
        actions: [
          IconButton(
              icon: Icon(Icons.notifications, color: primaryPurple),
              onPressed: () {})
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('ABOUT ME'),
                  const SizedBox(height: 12),
                  Text(
                    'With over 12 years of experience in interior floral design and space curation, I help bring life into residential and commercial spaces.',
                    style: GoogleFonts.poppins(
                        color: textGray, fontSize: 13, height: 1.6),
                  ),
                  const SizedBox(height: 32),
                  _buildSectionTitle('SERVICES OFFERED'),
                  const SizedBox(height: 16),
                  _buildServiceCard(
                      icon: Icons.local_florist,
                      title: 'Custom Curation',
                      desc: 'Full space analysis and custom arrangement installation.',
                      price: '\$180',
                      priceSuffix: ' /session'),
                  const SizedBox(height: 32),
                  _buildSectionTitle('PORTFOLIO'),
                  const SizedBox(height: 16),
                  _buildPortfolioGrid(),
                  const SizedBox(height: 32),
                  _buildSectionTitle('REVIEWS'),
                  const SizedBox(height: 16),
                  _buildReviewItem('Sarah Jenkins', '2 weeks ago',
                      ' master at his craft.', 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100'),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFEDE8FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                icon: const Icon(Icons.chat_bubble_outline,
                    color: Color(0xFF735BF2)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChatPage(providerName: provider.name)),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF735BF2),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BookingPage(provider: provider)));
                },
                child: const Text("Book Now",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title,
        style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: greenHeading));
  }

  Widget _buildHeroSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.network(provider.avatarUrl,
                height: 250, width: double.infinity, fit: BoxFit.cover),
          ),
          Positioned(
            bottom: -20,
            child: Container(
              width: 300,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10))
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(provider.name,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textDark)),
                      const SizedBox(width: 4),
                      const Icon(Icons.verified, color: Colors.blue, size: 16),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Color(0xFF0F765E), size: 14),
                          const SizedBox(width: 4),
                          Text('${provider.rating} (124 reviews)',
                              style: GoogleFonts.poppins(
                                  fontSize: 11, color: textGray),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
      {required IconData icon,
      required String title,
      required String desc,
      required String price,
      required String priceSuffix}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Color(0xFFF0EDFF), shape: BoxShape.circle),
            child: Icon(icon, color: primaryPurple, size: 20),
          ),
          const SizedBox(height: 16),
          Text(title,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text(desc,
              style: GoogleFonts.poppins(
                  color: textGray, fontSize: 12, height: 1.5)),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(color: primaryPurple),
              children: [
                TextSpan(
                    text: price,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: priceSuffix,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPortfolioGrid() {
    return SizedBox(
      height: 260,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                  'https://images.unsplash.com/photo-1563241598-bb5ca3db3db0?w=400',
                  fit: BoxFit.cover,
                  height: double.infinity),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 1,
            child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF0EDFF),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text('+12\nMore',
                        style: GoogleFonts.poppins(
                            color: primaryPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                        textAlign: TextAlign.center))),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(
      String name, String time, String review, String avatarUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 20, backgroundImage: NetworkImage(avatarUrl)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 13)),
                  Row(
                      children: List.generate(
                          5,
                          (index) => const Icon(Icons.star,
                              color: Color(0xFF0F765E), size: 12))),
                ],
              ),
            ),
            Text(time,
                style: GoogleFonts.poppins(
                    color: Colors.grey.shade500, fontSize: 11)),
          ],
        ),
        const SizedBox(height: 8),
        Text(review,
            style: GoogleFonts.poppins(
                color: textGray, fontSize: 12, height: 1.5)),
        const SizedBox(height: 16),
      ],
    );
  }
}