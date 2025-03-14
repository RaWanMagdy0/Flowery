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
  Timer? _timer;
  final Map<String, String> statusTimestamps = {};

  @override
  void initState() {
    super.initState();
    print("📌 Received orderId: ${widget.orderId}");
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Stream<DocumentSnapshot> getOrderStream() {
    return FirebaseFirestore.instance.collection('orders').doc(widget.orderId).snapshots();
  }

  int getCurrentStep(String state, String status) {
    if (state == "inProgress") {
      return 1;
    }
    switch (status) {
      case "picked":
        return 2;
      case "outForDelivery":
      case "arrived":
        return 3;
      case "delivered":
        return 4;
      default:
        return 0;
    }
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
            StreamBuilder<DocumentSnapshot>(
              stream: getOrderStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(child: Text("Order not found"));
                }

                var orderData = snapshot.data!;
                Map<String, dynamic>? orderMap = orderData.data() as Map<String, dynamic>?;

                String state = orderMap != null && orderMap.containsKey('state') ? orderMap['state'] : "unknown";
                String orderStatus = orderMap != null && orderMap.containsKey('status') ? orderMap['status'] : "unknown";

                var updatedAtTimestamp = orderMap != null && orderMap.containsKey('updatedAt')
                    ? orderMap['updatedAt']
                    : null;

                if (updatedAtTimestamp != null && updatedAtTimestamp is Timestamp) {
                  DateTime dateTime = updatedAtTimestamp.toDate();
                  String formattedDate =
                      "${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}:${dateTime.minute}";

                  if (!statusTimestamps.containsKey(orderStatus)) {
                    statusTimestamps[orderStatus] = formattedDate;
                  }
                }

                return Column(
                  children: [
                    Center(child: StepperIndicator(currentStep: 3)),
                    40.verticalSpace,
                    Image.asset(AppImages.car, fit: BoxFit.cover),
                    20.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: OrderTrackingTimeline(
                        steps: [
                          OrderStep(
                            title: "Received your order",
                            timestamp: statusTimestamps["inProgress"] ?? "Loading...",
                            isCompleted: state == "inProgress" || ["picked", "outForDelivery", "arrived", "delivered"].contains(orderStatus),
                          ),
                          OrderStep(
                            title: "Preparing your order",
                            timestamp: statusTimestamps["picked"] ??
                                (orderStatus == "inProgress" ? "Coming Soon..." : "Loading..."),
                            isCompleted: ["picked", "outForDelivery", "arrived", "delivered"].contains(orderStatus),
                          ),
                          OrderStep(
                            title: "Out for delivery",
                            timestamp: statusTimestamps["outForDelivery"] ??
                                (["inProgress", "picked"].contains(orderStatus) ? "Coming Soon..." : "Loading..."),
                            isCompleted: ["outForDelivery", "arrived", "delivered"].contains(orderStatus),
                          ),
                          OrderStep(
                            title: "Delivered",
                            timestamp: statusTimestamps["delivered"] ??
                                (["inProgress", "picked", "outForDelivery", "arrived"].contains(orderStatus) ? "Coming Soon..." : "Loading..."),
                            isCompleted: orderStatus == "delivered",
                          ),
                        ],
                      ),
                    ),
                    if (orderStatus == "outForDelivery" || orderStatus == "arrived")
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
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
