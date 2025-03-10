import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery/core/routes/page_route_name.dart';
import 'package:flowery/core/styles/images/app_images.dart';
import 'package:flowery/core/utils/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../widget/stepper_indecator.dart';
import '../widget/tracking_line.dart';

class TrackOrderScreen extends StatefulWidget {
  final String orderId;
  const TrackOrderScreen({super.key, required this.orderId});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  String orderStatus = "Loading...";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    print("📌 Received orderId: ${widget.orderId}");
    fetchOrderStatus();
    startAutoRefresh();
  }

  void startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (orderStatus != "Delivered") {
        fetchOrderStatus();
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> fetchOrderStatus() async {
    if (widget.orderId.isEmpty) return;

    try {
      DocumentSnapshot orderSnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .doc(widget.orderId)
          .get();

      if (orderSnapshot.exists) {
        setState(() {
          orderStatus = orderSnapshot.get('state') ?? "Unknown";
        });
      } else {
        setState(() => orderStatus = "Order not found");
      }
    } catch (e) {
      setState(() => orderStatus = "Error fetching status");
      print("Error fetching order status: $e");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Track Order",
          style: AppFonts.font20BlackWeight500.copyWith(fontSize: 20.sp),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            20.verticalSpace,
            Center(
              child: StepperIndicator(
                  currentStep: orderStatus == "Delivered" ? 4 : 3),
            ),
            40.verticalSpace,
            Image.asset(AppImages.car, fit: BoxFit.cover),
            20.verticalSpace,
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: OrderTrackingTimeline(
                steps: [
                  OrderStep(
                      title: "Received your order",
                      timestamp: "03 Sep 2024 - 2:10",
                      isCompleted: true),
                  OrderStep(
                      title: "Preparing your order",
                      timestamp: "03 Sep 2024 - 2:10",
                      isCompleted: true),
                  OrderStep(
                      title: "Out for delivery",
                      timestamp: "03 Sep 2024 - 2:10",
                      isCompleted: orderStatus == "Out for delivery" ||
                          orderStatus == "Delivered"),
                  OrderStep(
                      title: "Delivered",
                      timestamp: "03 Sep 2024 - 2:10",
                      isCompleted: orderStatus == "Delivered"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    PageRouteName.mapScreen,
                    arguments: widget.orderId,
                  );
                  print(widget.orderId);
                },
                text: "Show Map",
              ),
            )
          ],
        ),
      ),
    );
  }
}
