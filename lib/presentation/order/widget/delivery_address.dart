import 'package:flowery/presentation/addresses/saved_addresses/view_model/saved_addresses_view_model.dart';
import 'package:flutter/cupertino.dart';
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
          return const Center(child: CircularProgressIndicator());
        } else if (state is SavedAddressesFailure) {
          return const Center(child: Text("Failed to load addresses."));
        } else if (state is SavedAddressesSuccess) {
          final addresses = state.addresses;
          if (addresses.isEmpty) {
            return const Center(child: Text("No saved addresses."));
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
                    final addressId = "${address.city}-${address.street}";
                    return DeliveryAddressCard(
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
              const SizedBox(height: 15),
            ],
          );
        }
        return const Center(child: Text("No data available."));
      },
    );
  }
}