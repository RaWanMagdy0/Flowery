import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/const/app_string.dart';
import '../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../../core/utils/functions/validators/validators.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../data/models/order/request/address_requests/add_address_request_body_model.dart';
import '../../view_model/addresses_view_model.dart';
import 'widgets/custom_drop_down.dart';
import 'widgets/map_widget.dart';

class AddAndEditUserAddressScreen extends StatefulWidget {
  static const String routeName = '/sign-up';
  const AddAndEditUserAddressScreen({super.key});

  @override
  State<AddAndEditUserAddressScreen> createState() =>
      _AddAndEditUserAddressScreenState();
}

class _AddAndEditUserAddressScreenState
    extends State<AddAndEditUserAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _addressController;
  late final TextEditingController _recipientNameController;
  late final TextEditingController _phoneNumberController;
  String? city;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    _recipientNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _recipientNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void addAddress() async {
    if (_formKey.currentState!.validate()) {
      final AddAddressRequestBody body = AddAddressRequestBody(
        street: _addressController.text,
        phone: _phoneNumberController.text,
        city: city ?? "",
      );

      context.read<AddressesCubit>().AddAddress(body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressesCubit, AddressesState>(
      bloc: context.read<AddressesCubit>(),
      listener: (context, state) => _handelStateChange(state),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Address"),
          forceMaterialTransparency: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  24.verticalSpace,
                  MapWidget(),
                  24.verticalSpace,
                  CustomTextFormField(
                    controller: _addressController,
                    hintText: "Enter the address",
                    labelText: "Address",
                    keyBordType: TextInputType.text,
                    validator: (value) => Validators.validateNotEmpty(
                      title: "Address",
                      value: value,
                    ),
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    hintText: AppStrings.phoneHintText,
                    labelText: AppStrings.phoneLabelText,
                    validator: (value) => Validators.validatePhoneNumber(value),
                    keyBordType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    controller: _phoneNumberController,
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    controller: _recipientNameController,
                    hintText: "Enter the recipient name",
                    labelText: "Recipient Name",
                    keyBordType: TextInputType.text,
                    // validator: (value) => Validators.validateNotEmpty(
                    //   title: "Recipient Name",
                    //   value: value,
                    // ),
                  ),
                  24.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: CustomDropDown(
                          hintText: "City",
                          labelText: "City",
                          validator: (value) => Validators.validateNotEmpty(
                            title: "City",
                            value: value,
                          ),
                          data: ["Cairo", "Alexandria", "Giza"],
                          onChanged: (value) {
                            city = value;
                          },
                        ),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        child: CustomDropDown(
                          hintText: "Area",
                          labelText: "Area",
                          data: ["Nasr City", "Maadi", "Heliopolis"],
                        ),
                      ),
                    ],
                  ),
                  35.verticalSpace,
                  CustomButton(
                    onPressed: addAddress,
                    text: "Save address",
                  ),
                  16.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handelStateChange(AddressesState state) {
    if (state is AddAddressesSuccess) {
      Navigator.pop(context);

      AppDialogs.showSuccessDialog(
        context: context,
        message: "Address Added Successfully.",
        whenAnimationFinished: () {
          Navigator.pop(context);
        },
      );
    } else if (state is AddAddAddressFail) {
      Navigator.pop(context);
      AppDialogs.showErrorDialog(context: context, errorMassage: state.message);
    } else if (state is AddAddressesLoading) {
      AppDialogs.showLoading(context: context);
    }
  }
}
