import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/const/add_address_string.dart';
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
  static const String routeName = '/add-edit-user-address';

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
  LatLng? userSelectedLocation;
  List<Governorate> governorates = [];
  List<String> cities = [];
  String? selectedArea;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    _recipientNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    loadGovernorates();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _recipientNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressesCubit, AddressesState>(
        bloc: context.read<AddressesCubit>(),
        listener: (context, state) => _handelStateChange(state),
        child: Scaffold(
            appBar: AppBar(
              title: const Text(AddAddressString.address),
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
                        MapWidget(
                          onLocationSelected: (LatLng location) {
                            userSelectedLocation = location;
                          },
                        ),
                        24.verticalSpace,
                        CustomTextFormField(
                          controller: _addressController,
                          hintText: AddAddressString.enterAddress,
                          labelText: AddAddressString.address,
                          keyBordType: TextInputType.text,
                          validator: (value) => Validators.validateNotEmpty(
                            title: AddAddressString.address,
                            value: value,
                          ),
                        ),
                        24.verticalSpace,
                        CustomTextFormField(
                          hintText: AppStrings.phoneHintText,
                          labelText: AppStrings.phoneLabelText,
                          validator: (value) =>
                              Validators.validatePhoneNumber(value),
                          keyBordType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          controller: _phoneNumberController,
                        ),
                        24.verticalSpace,
                        CustomTextFormField(
                          controller: _recipientNameController,
                          hintText: AddAddressString.enterRecipientName,
                          labelText: AddAddressString.recipientName,
                          keyBordType: TextInputType.text,
                        ),
                        24.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: CustomDropDown(
                                hintText: AddAddressString.city,
                                labelText: AddAddressString.city,
                                validator: (value) =>
                                    Validators.validateNotEmpty(
                                  title: AddAddressString.city,
                                  value: value,
                                ),
                                data: governorates
                                    .map((gov) => gov.name)
                                    .toList(),
                                onChanged: updateCities,
                              ),
                            ),
                            13.horizontalSpace,
                            Expanded(
                              child: CustomDropDown(
                                hintText: AddAddressString.area,
                                labelText: AddAddressString.area,
                                data: cities,
                                onChanged: (value) {
                                  setState(() {
                                    selectedArea = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        35.verticalSpace,
                        CustomButton(
                          onPressed: addAddress,
                          text: AddAddressString.saveAddress,
                        ),
                        16.verticalSpace,
                      ],
                    ),
                  ),
                ))));
  }

  void _handelStateChange(AddressesState state) {
    if (state is AddAddressesSuccess) {
      Navigator.pop(context);
      AppDialogs.showSuccessDialog(
        context: context,
        message: AddAddressString.addressAddedSuccess,
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

  Future<void> loadGovernorates() async {
    try {
      final String response =
          await rootBundle.loadString('assets/city/egypt-governorates-en.json');
      final data = await json.decode(response);

      setState(() {
        governorates = (data['egyptian_governorates'] as List)
            .map((json) => Governorate.fromJson(json))
            .toList();
      });
    } catch (e) {
      print('Error loading governorates: $e');
    }
  }

  void updateCities(String? selectedGovernorate) {
    setState(() {
      city = selectedGovernorate;
      selectedArea = null;
      if (selectedGovernorate != null) {
        final governorate = governorates.firstWhere(
          (g) => g.name == selectedGovernorate,
          orElse: () => Governorate(name: '', cities: []),
        );
        cities = governorate.cities;
      } else {
        cities = [];
      }
    });
  }

  void addAddress() {
    if (_formKey.currentState!.validate()) {
      if (userSelectedLocation == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a location on the map.")),
        );
        return;
      }
      final AddAddressRequestBody request = AddAddressRequestBody(
          street: _addressController.text,
          phone: _phoneNumberController.text,
          city: city ?? "",
          lat: userSelectedLocation!.latitude.toString(),
          lang: userSelectedLocation!.longitude.toString(),
          username: _recipientNameController.text);

      context.read<AddressesCubit>().AddAddress(request);
      saveAddressLocally(
        userSelectedLocation!.latitude.toString(),
        city.toString(),
        userSelectedLocation!.longitude.toString(),
      );
    }
  }

  void saveAddressLocally(String lang, String city, String lat) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('city', city);
    await prefs.setString('lang', lang);
    await prefs.setString('lat', lat);
  }
}

class Governorate {
  final String name;
  final List<String> cities;

  Governorate({required this.name, required this.cities});

  factory Governorate.fromJson(Map<String, dynamic> json) {
    return Governorate(
      name: json['name'],
      cities: List<String>.from(json['cities']),
    );
  }
}
