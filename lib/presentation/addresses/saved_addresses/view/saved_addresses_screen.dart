import 'package:flowery/core/routes/page_route_name.dart';
import 'package:flowery/domain/entities/address/saved_addresses_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/fonts/app_fonts.dart';
import 'widgets/saved_addresses_button.dart';
import 'widgets/saved_addresses_card.dart';
import '../view_model/saved_addresses_view_model.dart';
import '../view_model/saved_addresses_states.dart';

class SavedAddressScreen extends StatefulWidget {
   SavedAddressScreen({super.key});
  @override
  State<SavedAddressScreen> createState() => _SavedAddressScreenState();
}

class _SavedAddressScreenState extends State<SavedAddressScreen> {
  late SavedAddressesViewModel viewModel;

  @override
  void initState() {
    super.initState();
   viewModel=  context.read<SavedAddressesViewModel>();
   viewModel.getAllAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Saved Addresses",
          style: AppFonts.font20BlackWeight500.copyWith(fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child:
                  BlocConsumer<SavedAddressesViewModel, SavedAddressesStates>(
                bloc: viewModel,
                listener: (context, state) {
                  if (state is SavedAddressesFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to load addresses.")),
                    );
                  } else if (state is DeleteAddressFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to delete address.")),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is SavedAddressesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SavedAddressesSuccess) {
                    final addresses = state.addresses;
                    if (addresses.isEmpty) {
                      return const Center(child: Text("No saved addresses."));
                    }
                    return ListView.builder(
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        final address = addresses[index];
                        return SavedAddressesCard(
                          city: address.city,
                          street: address.street,
                        );
                      },
                    );
                  }
                  return const Center(child: Text("No data available."));
                },
              ),
            ),
            SavedAddressesButton(
              onPressed: () async {
                await Navigator.pushNamed(
                    context, PageRouteName.addAndEditUserAddress);
              },
            ),
          ],
        ),
      ),
    );
  }
}
