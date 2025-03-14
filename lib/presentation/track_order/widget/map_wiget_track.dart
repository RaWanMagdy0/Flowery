import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../view_model/map_states.dart';
import '../view_model/map_view_model.dart';

class MapWidgetTrack extends StatefulWidget {
  final String orderId;

  const MapWidgetTrack({super.key, required this.orderId});

  @override
  State<MapWidgetTrack> createState() => _MapWidgetTrackState();
}

class _MapWidgetTrackState extends State<MapWidgetTrack> {
  final CustomInfoWindowController _customInfoWindowController =
  CustomInfoWindowController();

  GoogleMapController? _mapController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOrderData();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _customInfoWindowController.dispose();
    super.dispose();
  }

  Future<void> _loadOrderData() async {
    setState(() => _isLoading = true);

    try {
      final cubit = context.read<MapCubit>();
      await cubit.loadOrder(widget.orderId);
      setState(() => _isLoading = false);
    } catch (e) {
      print("Error loading order: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, PendingOrderState>(
      listener: (context, state) {
        if (state is OrderLoaded && _mapController != null) {
          if (state.driverLocation != null) {
            _mapController?.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: state.driverLocation!,
                zoom: 15,
                bearing: state.bearing ?? 0,
              ),
            ));
          }
        }
      },
      builder: (context, state) {
        if (_isLoading) {
          return Center(child: CircularProgressIndicator(color: AppColors.kPink));
        }
        if (state is OrderError) {
          return Center(child: Text(state.message ?? ""));
        }
        if (state is! OrderLoaded) {
          return Center(child: Text("loading data..."));
        }
        final storeLocation = state.order.storeLocation;
        final driverLocation = state.driverLocation;

        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: driverLocation ?? storeLocation,
                zoom: 14,
              ),
              mapType: MapType.normal,
             markers: state.markers,
              polylines: state.polylines,
              myLocationEnabled: false,
              compassEnabled: true,
              zoomControlsEnabled: false,
              onTap: (_) => _customInfoWindowController.hideInfoWindow?.call(),
              onMapCreated: (controller) {
                _mapController = controller;
                _customInfoWindowController.googleMapController = controller;
              },
            ),
            CustomInfoWindow(
              controller: _customInfoWindowController,
              height: 80,
              width: 150,
              offset: 50,
            ),
          ],
        );
      },
    );
  }
}