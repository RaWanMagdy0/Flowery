import 'package:flowery/presentation/addresses/view/add_and_edit_user_address/widgets/custom_drop_down.dart';
import 'package:flowery/presentation/addresses/view_model/addresses_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/const/app_string.dart';
import '../../../../core/utils/functions/validators/validators.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';

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

  void signUp() async {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressesCubit, AddressesState>(
      bloc: context.read<AddressesCubit>(),
      // listener: (context, state) => _handelStateChange(state),
      listener: (context, state) {},
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
                  Image.asset(
                    'assets/images/map_placeholder_image.png',
                    height: 145.h,
                  ),
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
                    onChanged: (value) {
                      if (value.trim().isEmpty) {
                        final prefix = '+2';
                        _phoneNumberController.text = prefix;
                      }
                    },
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
                    onPressed: signUp,
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

  // void _handelStateChange(AddressesState state) {
  //   if (state is SignUpSuccess) {
  //     Navigator.pop(context);
  //     AppDialogs.showSuccessDialog(
  //       context: context,
  //       message: "Account Created Successfully.\n Please Login to proceed",
  //       whenAnimationFinished: () => Navigator.pop(context),
  //     );
  //   } else if (state is SignUpFail) {
  //     Navigator.pop(context);
  //     AppDialogs.showErrorDialog(
  //         context: context, errorMassage: state.errorMassage ?? "");
  //   } else if (state is SignUpLoading) {
  //     AppDialogs.showLoading(context: context);
  //   }
  // }
}
