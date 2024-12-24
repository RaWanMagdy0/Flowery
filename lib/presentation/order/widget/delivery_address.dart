import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/di/di.dart';
import '../../../core/routes/page_route_name.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';
import '../../../core/utils/const/checkout_page_string.dart';
import '../../../core/utils/widget/custom_button.dart';
import '../../addresses/saved_addresses/view_model/saved_addresses_states.dart';
import '../../addresses/saved_addresses/view_model/saved_addresses_view_model.dart';
import 'delivery_address_card.dart';

class DeliveryAddress extends StatefulWidget {
  final ValueChanged<String?> onChanged;

  const DeliveryAddress({super.key, required this.onChanged});

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  String? selectedAddress;
  late SavedAddressesViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<SavedAddressesViewModel>();
    viewModel.getAllAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedAddressesViewModel, SavedAddressesStates>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is SavedAddressesLoading) {
          return Center(
              child: CircularProgressIndicator(
            color: AppColors.kPink,
          ));
        } else if (state is SavedAddressesFailure) {
          return Center(
              child: Text(
            "Failed to load addresses.",
            style: AppFonts.font13GreyWeight500,
          ));
        } else if (state is SavedAddressesSuccess) {
          final addresses = state.addresses;
          if (addresses.isEmpty) {
            return Center(
                child: Text(
              "No saved addresses.",
              style: AppFonts.font15PinkWeight500UnderlinedPink,
            ));
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  CheckoutStrings.deliveryAddress,
                  style: AppFonts.font18BlackWeight500,
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    final address = addresses[index];
                    final addressId =
                        "${address.city}-${address.street}-${address.phone}";
                    return DeliveryAddressCard(
                      phone: address.phone,
                      city: address.city,
                      street: address.street,
                      onChanged: (String? value) {
                        setState(() {
                          selectedAddress = value;
                        });
                        widget.onChanged(selectedAddress);
                      },
                      selectedAddress: selectedAddress,
                      addressId: addressId,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  color: AppColors.kWhite,
                  borderColor: AppColors.kLightGrey,
                  onPressed: () async {
                    await Navigator.pushNamed(
                        context, PageRouteName.addAndEditUserAddress);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: AppColors.kPink,
                        size: 25.sp,
                      ),
                      Text(
                        CheckoutStrings.addNew,
                        style: AppFonts.font14PinkWeight500,
                      )
                    ],
                  ),
                ),
              ),
              15.verticalSpace,
            ],
          );
        }
        return Center(
            child: Text(
          "No data available.",
          style: AppFonts.font15PinkWeight500UnderlinedPink,
        ));
      },
    );
  }
}
