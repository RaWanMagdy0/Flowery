import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  static const String _termsContent = '''
    <div style="padding: 16px;">
      <h1 style="color: #FF69B4; text-align: center;">Terms and Conditions</h1>
      
      <p style="line-height: 1.6;">
        Welcome to Flowery. By accessing and using this application, you accept and agree 
        to be bound by the terms and provision of this agreement.
      </p>

      <h2 style="color: #FF69B4;">1. Acceptance of Terms</h2>
      <p style="line-height: 1.6;">
        By accessing and using Flowery, you accept and agree to be bound by the terms 
        and provision of this agreement. If you do not agree to abide by these terms, 
        please do not use this application.
      </p>

      <h2 style="color: #FF69B4;">2. Use License</h2>
      <p style="line-height: 1.6;">
        Permission is granted to temporarily download one copy of the application for 
        personal, non-commercial transitory viewing only.
      </p>

      <h2 style="color: #FF69B4;">3. Product Information</h2>
      <p style="line-height: 1.6;">
        We strive to display our products as accurately as possible. However, actual 
        colors may vary depending on your device's display settings.
      </p>

      <h2 style="color: #FF69B4;">4. Pricing and Payment</h2>
      <p style="line-height: 1.6;">
        All prices are subject to change without notice. We reserve the right to 
        modify or discontinue services without notice.
      </p>

      <h2 style="color: #FF69B4;">5. Delivery Policy</h2>
      <p style="line-height: 1.6;">
        We aim to deliver all orders within the specified timeframe. However, delays 
        may occur due to unforeseen circumstances.
      </p>

      <h2 style="color: #FF69B4;">6. Privacy Policy</h2>
      <p style="line-height: 1.6;">
        Your privacy is important to us. Please review our Privacy Policy to understand 
        how we collect and use your information.
      </p>

      <h2 style="color: #FF69B4;">7. Contact Information</h2>
      <p style="line-height: 1.6;">
        For any questions regarding these terms, please contact us at:<br>
        Email: legal@flowery.com<br>
        Phone: +0 (000) 000-0000
      </p>

      <div style="text-align: center; margin-top: 20px;">
        <p>Last updated: December 2024</p>
      </div>
    </div>
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms & Conditions',
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
            data: _termsContent,
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