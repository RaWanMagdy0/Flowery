import 'dart:developer';

import 'package:flowery/presentation/order/view_model/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../generated/l10n.dart';

class PaymentWebView extends StatefulWidget {
  final String paymentLink;

  const PaymentWebView({super.key, required this.paymentLink});

  @override
  State<PaymentWebView> createState() => _NewPolicyPaymentViewState();
}

class _NewPolicyPaymentViewState extends State<PaymentWebView> {
  late InAppWebViewController _webViewController;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    log(widget.paymentLink, name: 'NewPolicyPaymentView -- Payment Link');
  }

  @override
  Widget build(BuildContext context) {
    final locale = S.of(context);
    final kColors = Theme.of(context).colorScheme;

    return WillPopScope(
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          return false;
        }
        log('NewPolicyPaymentView', name: 'NewPolicyPaymentView');

        return true;
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
          child: Stack(
            children: [
              // WebView
              InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(widget.paymentLink)),
                initialSettings: InAppWebViewSettings(
                  useOnLoadResource: true,
                  javaScriptEnabled: true,
                  // Add other settings if needed
                ),
                onLoadStart: (controller, url) {
                  if (url.toString().startsWith(
                          'http://139.185.43.128/index.php/payment/success') ||
                      url.toString().startsWith(
                          'http://139.185.43.128/index.php/policy/status?status=active')) {
                    Navigator.of(context).pop();
                  }
                },
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
                onProgressChanged: (controller, progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                },
                onReceivedError: (controller, request, error) {
                  // Handle load error
                  if (request.url.toString().startsWith(
                          'http://139.185.43.128/index.php/payment/success') ||
                      request.url.toString().startsWith(
                          'http://139.185.43.128/index.php/policy/status?status=active')) {
                    return;
                  }
                },
                onReceivedHttpError: (controller, request, response) {
                  // Handle HTTP error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'HTTP error ${response.statusCode}: ${response.reasonPhrase}')),
                  );
                },
              ),

              // Show loading indicator when page is loading
              if (_progress < 1.0)
                // Loading indicator
                Positioned.fill(
                  child: Container(
                    color: Colors.white
                        .withOpacity(0.8), // Semi-transparent overlay
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kColors.primary),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
