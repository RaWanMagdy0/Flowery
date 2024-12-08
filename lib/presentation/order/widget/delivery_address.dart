import 'package:flowery/presentation/addresses/saved_addresses/view_model/saved_addresses_view_model.dart';
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

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                20.verticalSpace,
                Row(
                  children: [
                    Text(
                      CheckoutStrings.deliveryAddress,
                      style: AppFonts.font18BlackWeight500,
                    ),
                  ],
                ),
                10.verticalSpace,
                ...addresses.map((address) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedAddress = address.id;
                      });
                      widget.onChanged(selectedAddress);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(
                          color: selectedAddress == address.id
                              ? AppColors.kPink
                              : AppColors.kLighterGrey,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                      activeColor: Colors.pink,
                                      value: address.id,
                                      groupValue: selectedAddress,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedAddress = value;
                                        });
                                        widget.onChanged(value);
                                      },
                                    ),
                                    Text(
                                      address.street,
                                      style: AppFonts.font16BlackWeight500,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${address.city}",
                                      style: AppFonts.font13BlackWeight400
                                          .copyWith(color: AppColors.kGray),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.edit_outlined,
                                      color: AppColors.kGray,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),

                10.verticalSpace,
                CustomButton(
                  color: AppColors.kWhite,
                  borderColor: AppColors.kLightGrey,
                  onPressed: () async {
                    await Navigator.pushNamed(
                        context, PageRouteName.addAndEditUserAddress);
                    viewModel.getAllAddresses();
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
                15.verticalSpace,
              ],
            ),
          );
        }
        return const Center(child: Text("No data available."));
      },
    );
  }
}