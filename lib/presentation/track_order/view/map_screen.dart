import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flowery/core/styles/images/app_images.dart';
import 'package:flowery/core/utils/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/map_wiget_track.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  final String orderId;
  const MapScreen({super.key, required this.orderId});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Map<String, dynamic>? orderData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrderDetails();
  }

  Future<void> fetchOrderDetails() async {
    setState(() => isLoading = true);

    try {
      print("Fetching order details for ID: ${widget.orderId}");

      DocumentSnapshot orderSnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .doc(widget.orderId)
          .get();

      if (orderSnapshot.exists) {
        print("Order Data: ${orderSnapshot.data()}");

        setState(() {
          orderData = orderSnapshot.data() as Map<String, dynamic>?;
        });
      } else {
        print("Order document doesn't exist for ID: ${widget.orderId}");
      }
    } catch (e) {
      print("Error fetching order: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = orderData?['user'] ?? {};
    final userName = "${user['firstName']} ${user['lastName']}";
    final userPhone = user['phone'] ?? "";
    final userImage = AppImages.personIcon;
   // final userImage = user['photo'] ??AppImages.personIcon;
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(child: MapWidgetTrack(orderId: widget.orderId)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Estimated arrival", style: AppFonts.font14GreyWeight500),
                Text(orderData?['estimatedTime'] ?? "15-20 minutes",
                    style: AppFonts.font16BlackWeight500),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                SizedBox(
                  height: 55,
                  width: 55,
                  child: ClipOval(
                    child:
                        // Image.network(userImage, fit: BoxFit.cover)
                         Image.asset(AppImages.personIcon, fit: BoxFit.cover),
                  ),
                ),
                10.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName, overflow: TextOverflow.ellipsis),
                    Text("is yor delivery here", overflow: TextOverflow.ellipsis),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.phone, color: AppColors.kPink),
                  onPressed: () => userPhone.isNotEmpty ? _makePhoneCall(userPhone) : null,
                ),
                IconButton(
                  icon: Icon(Icons.message, color: AppColors.kPink),
                  onPressed: () => userPhone.isNotEmpty ? openWhatsApp(userPhone) : null,
                ),
              ],
            ),
          ),
          CustomButton(
            text: "Order Details",
            onPressed: () {},
            color: AppColors.kPink,
          )
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> openWhatsApp(String phoneNumber) async {
    final Uri whatsappUri = Uri.parse("https://wa.me/$phoneNumber");
    if (!await launchUrl(whatsappUri, mode: LaunchMode.externalApplication)) {
      print("Could not launch WhatsApp for $phoneNumber");
    }
  }
  }
