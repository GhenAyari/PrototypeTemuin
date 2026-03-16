// lib/pages/booking_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/service_provider.dart';
import 'home_page.dart'; // Untuk navigasi kembali ke home setelah sukses

class BookingPage extends StatefulWidget {
  final ServiceProvider provider;

  const BookingPage({Key? key, required this.provider}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  // Warna Utama
  final Color bgPurple = const Color(0xFFFDFBFF);
  final Color primaryPurple = const Color(0xFF533DEC);
  final Color lightPurple = const Color(0xFFEDE8FF);
  final Color textDark = const Color(0xFF1A1A1A);
  final Color textGray = const Color(0xFF8A8A8A);
  final Color greenAccent = const Color(0xFF0F765E);
  final Color lightGreen = const Color(0xFF90F0D6);

  // State untuk pilihan interaktif (Prototype)
  int _selectedDateIndex = 4; // Default pilih tanggal ke-5 (angka 2)
  int _selectedTimeIndex = 1; // Default pilih jam ke-2 (10:30 AM)
  int _selectedPayment = 0; // 0: Card, 1: PayPal

  @override
  Widget build(BuildContext context) {
    // Perhitungan Harga Dinamis
    double serviceFee = widget.provider.price.toDouble();
    double bookingCharge = 4.50;
    double discount = 10.00;
    double totalAmount = serviceFee + bookingCharge - discount;

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepper(),
            const SizedBox(height: 32),
            _buildServiceSummary(),
            const SizedBox(height: 32),
            _buildSectionHeader('Select Date & Time', trailing: 'October 2024'),
            const SizedBox(height: 16),
            _buildDateSelector(),
            const SizedBox(height: 24),
            Text('AVAILABLE SLOTS', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: primaryPurple.withOpacity(0.7))),
            const SizedBox(height: 12),
            _buildTimeSelector(),
            const SizedBox(height: 32),
            _buildSectionHeader('Additional Instructions'),
            const SizedBox(height: 16),
            _buildInstructionField(),
            const SizedBox(height: 32),
            _buildSectionHeader('Payment Method'),
            const SizedBox(height: 16),
            _buildPaymentMethods(),
            const SizedBox(height: 32),
            _buildOrderSummary(serviceFee, bookingCharge, discount, totalAmount),
            const SizedBox(height: 32),
            _buildTrustBadges(),
            const SizedBox(height: 48),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildStepper() {
    return Row(
      children: [
        _buildStepItem(isActive: false, isCompleted: true, label: 'Select Service', step: '1'),
        Expanded(child: Divider(color: lightPurple, thickness: 2)),
        _buildStepItem(isActive: true, isCompleted: false, label: 'Details', step: '2'),
        Expanded(child: Divider(color: lightPurple, thickness: 2)),
        _buildStepItem(isActive: false, isCompleted: false, label: 'Payment', step: '3'),
      ],
    );
  }

  Widget _buildStepItem({required bool isActive, required bool isCompleted, required String label, required String step}) {
    Color circleColor = isCompleted ? const Color(0xFF0F765E) : (isActive ? primaryPurple : lightPurple);
    Color textColor = isCompleted ? Colors.white : (isActive ? Colors.white : textGray);

    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : Text(step, style: GoogleFonts.poppins(color: textColor, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: isActive || isCompleted ? FontWeight.bold : FontWeight.normal,
            color: isActive ? primaryPurple : textGray,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceSummary() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: primaryPurple.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Header (Bisa diganti dengan ilustrasi dari desain)
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 120,
              width: double.infinity,
              color: const Color(0xFF1E3240), // Warna gelap ilustrasi
              child: Image.network(widget.provider.avatarUrl, fit: BoxFit.cover, opacity: const AlwaysStoppedAnimation(0.5)),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: lightGreen, borderRadius: BorderRadius.circular(12)),
            child: Text(widget.provider.category.toUpperCase(), style: GoogleFonts.poppins(fontSize: 9, fontWeight: FontWeight.bold, color: greenAccent, letterSpacing: 1)),
          ),
          const SizedBox(height: 12),
          Text(widget.provider.name, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: textDark)),
          const SizedBox(height: 8),
          Text(widget.provider.description, style: GoogleFonts.poppins(color: textGray, fontSize: 12, height: 1.5), maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.schedule, size: 16, color: Color(0xFF533DEC)),
              const SizedBox(width: 4),
              Text('60 Mins', style: GoogleFonts.poppins(fontSize: 12, color: textGray)),
              const SizedBox(width: 16),
              const Icon(Icons.star, size: 16, color: Color(0xFF533DEC)),
              const SizedBox(width: 4),
              Text('${widget.provider.rating} (124 reviews)', style: GoogleFonts.poppins(fontSize: 12, color: textGray)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {String? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: textDark)),
        if (trailing != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: lightPurple, borderRadius: BorderRadius.circular(16)),
            child: Text(trailing, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: primaryPurple)),
          ),
      ],
    );
  }

  Widget _buildDateSelector() {
    // Dummy Data Tanggal untuk menyamakan dengan desain
    List<Map<String, String>> dates = [
      {'day': 'MO', 'date': '28'}, {'day': 'TU', 'date': '29'}, {'day': 'WE', 'date': '30'},
      {'day': 'TH', 'date': '1'}, {'day': 'FR', 'date': '2'}, {'day': 'SA', 'date': '3'}, {'day': 'SU', 'date': '4'},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: dates.map((d) => Text(d['day']!, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: textGray))).toList(),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(dates.length, (index) {
              bool isSelected = _selectedDateIndex == index;
              bool isPast = index < 3; // Contoh styling abu-abu untuk tanggal lalu

              return GestureDetector(
                onTap: () => setState(() => _selectedDateIndex = index),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isSelected ? primaryPurple : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      dates[index]['date']!,
                      style: GoogleFonts.poppins(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.white : (isPast ? lightPurple : textDark),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSelector() {
    List<String> times = ['09:00 AM', '10:30 AM', '01:00 PM', '03:30 PM'];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(times.length, (index) {
        bool isSelected = _selectedTimeIndex == index;
        return GestureDetector(
          onTap: () => setState(() => _selectedTimeIndex = index),
          child: Container(
            width: (MediaQuery.of(context).size.width - 60) / 2, // 2 Kolom
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: isSelected ? primaryPurple : lightPurple,
              borderRadius: BorderRadius.circular(24),
              border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
              boxShadow: isSelected ? [BoxShadow(color: primaryPurple.withOpacity(0.3), blurRadius: 10)] : [],
            ),
            child: Center(
              child: Text(
                times[index],
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : primaryPurple,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildInstructionField() {
    return Container(
      decoration: BoxDecoration(color: lightPurple.withOpacity(0.5), borderRadius: BorderRadius.circular(24)),
      child: TextField(
        maxLines: 4,
        style: GoogleFonts.poppins(fontSize: 13),
        decoration: InputDecoration(
          hintText: 'Any specific focus areas or special requirements for the session?',
          hintStyle: GoogleFonts.poppins(color: textGray, fontSize: 13),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      children: [
        _buildPaymentOption(0, Icons.credit_card, 'Credit or Debit Card', 'Visa, Mastercard, Amex'),
        const SizedBox(height: 16),
        _buildPaymentOption(1, Icons.paypal, 'PayPal', 'Fast & Secure checkout'),
      ],
    );
  }

  Widget _buildPaymentOption(int index, IconData icon, String title, String subtitle) {
    bool isSelected = _selectedPayment == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedPayment = index),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isSelected ? primaryPurple : Colors.transparent, width: 2),
        ),
        child: Row(
          children: [
            Icon(icon, color: primaryPurple),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(subtitle, style: GoogleFonts.poppins(color: textGray, fontSize: 11)),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? primaryPurple : Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(double fee, double charge, double discount, double total) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: primaryPurple.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: textDark)),
          const SizedBox(height: 24),
          _buildSummaryRow('Service Fee', '\$${fee.toStringAsFixed(2)}'),
          const SizedBox(height: 12),
          _buildSummaryRow('Booking Charge', '\$${charge.toStringAsFixed(2)}'),
          const SizedBox(height: 12),
          _buildSummaryRow('Discount', '-\$${discount.toStringAsFixed(2)}', valueColor: greenAccent),
          const SizedBox(height: 24),
          const Divider(height: 1, thickness: 1),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TOTAL AMOUNT', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1, color: textGray)),
                  Text('\$${total.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: primaryPurple)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('SAVINGS', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1, color: greenAccent)),
                  Text('-\$${discount.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: greenAccent)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _showSuccessDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPurple,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Confirm Booking ', style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                  const Icon(Icons.arrow_forward, size: 18, color: Colors.white),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'By confirming, you agree to Temuin\'s Terms of Service and Privacy Policy.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 10, color: textGray),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(color: textGray, fontSize: 13)),
        Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13, color: valueColor ?? textDark)),
      ],
    );
  }

  Widget _buildTrustBadges() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTrustItem(Icons.security, 'SECURE PAYMENT'),
        _buildTrustItem(Icons.verified_user, 'VERIFIED EXPERT'),
        _buildTrustItem(Icons.update, '24H CANCELLATION'),
      ],
    );
  }

  Widget _buildTrustItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: textGray, size: 20),
        const SizedBox(height: 8),
        Text(label, style: GoogleFonts.poppins(fontSize: 8, fontWeight: FontWeight.bold, color: textGray)),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Temuin', style: GoogleFonts.poppins(color: primaryPurple, fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 12),
                    Text('The fluid atelier for human potential. Discover curated services that inspire growth.', style: GoogleFonts.poppins(color: textGray, fontSize: 11, height: 1.5)),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('MARKETPLACE', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1, color: primaryPurple)),
                    const SizedBox(height: 12),
                    Text('Home\nSearch Experts\nCategories', style: GoogleFonts.poppins(color: textDark, fontSize: 11, height: 2)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SUPPORT', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1, color: primaryPurple)),
                    const SizedBox(height: 12),
                    Text('Help Center\nSafety Rules\nRefund Policy', style: GoogleFonts.poppins(color: textDark, fontSize: 11, height: 2)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SOCIAL', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1, color: primaryPurple)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: lightPurple, shape: BoxShape.circle), child: Icon(Icons.link, size: 16, color: primaryPurple)),
                        const SizedBox(width: 8),
                        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: lightPurple, shape: BoxShape.circle), child: Icon(Icons.public, size: 16, color: primaryPurple)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Center(
            child: Text('© 2024 Temuin Inc. All rights reserved.', style: GoogleFonts.poppins(color: textGray, fontSize: 10)),
          ),
        ],
      ),
    );
  }

  // --- FUNGSI DIALOG SUKSES ---
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.all(32),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: lightGreen, shape: BoxShape.circle),
              child: Icon(Icons.check_circle, color: greenAccent, size: 64),
            ),
            const SizedBox(height: 24),
            Text('Booking Confirmed!', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: textDark)),
            const SizedBox(height: 12),
            Text(
              'Your session with ${widget.provider.name} is successfully booked. Check your email for details.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: textGray, fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  // Kembali ke Home Page dan reset stack navigasi
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
                child: Text('Back to Home', style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}