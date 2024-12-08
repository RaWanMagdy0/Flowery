import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  static const String _aboutContent = '''
    <div style="padding: 16px;">
      <h1 style="color: #FF69B4; text-align: center;">About Flowery</h1>

      <h2 style="color: #FF69B4;">Welcome to Flowery</h2>
      <p style="line-height: 1.6;">
        Flowery is your premier destination for beautiful floral arrangements and gifts. 
        Founded in 2024, we've been dedicated to bringing joy and beauty to every occasion 
        through our carefully curated selection of flowers and gifts.
      </p>

      <h3 style="color: #FF69B4;">Our Mission</h3>
      <p style="line-height: 1.6;">
        To deliver happiness and create memorable moments through stunning floral arrangements, 
        while providing exceptional customer service and maintaining the highest quality standards.
      </p>

      <h3 style="color: #FF69B4;">What We Offer</h3>
      <ul>
        <li>Fresh, hand-picked flowers</li>
        <li>Custom floral arrangements</li>
        <li>Same-day delivery</li>
        <li>Special occasion arrangements</li>
        <li>Gift packages</li>
      </ul>

      <h3 style="color: #FF69B4;">Contact Us</h3>
      <p style="line-height: 1.6;">
        Email: support@flowery.com<br>
        Phone: +0 (000) 000-0000<br>
        Address: 123 Flower Street, Garden City
      </p>

      <div style="text-align: center; margin-top: 20px;">
        <p>Version 1.0.0</p>
      </div>
    </div>
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About App',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Html(
            data: _aboutContent,
            style: {
              "body": Style(
                fontSize: FontSize(14.sp),
                fontFamily: 'Roboto',
              ),
              "h1": Style(
                fontSize: FontSize(24.sp),
                fontWeight: FontWeight.bold,
              ),
              "h2": Style(
                fontSize: FontSize(20.sp),
                fontWeight: FontWeight.bold,
              ),
              "h3": Style(
                fontSize: FontSize(18.sp),
                fontWeight: FontWeight.w600,
              ),
            },
          ),
        ),
      ),
    );
  }
}