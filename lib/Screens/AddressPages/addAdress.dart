// ignore_for_file: unnecessary_null_comparison, unused_field, empty_catches

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resturantapp/Routes/routesHelper.dart';
import 'package:resturantapp/controller/auth_controller.dart';
import 'package:resturantapp/models/address_model.dart';

import 'package:resturantapp/models/response_model.dart';

import 'package:resturantapp/utils/colors.dart';
import 'package:resturantapp/utils/dimmensions.dart';
import 'package:resturantapp/widgets/BigText.dart';
import 'package:resturantapp/widgets/snackbar.dart';

import '../../controller/location_repo_controller.dart';
import '../../widgets/CustomLoadingBar.dart';
import '../../widgets/InputField.dart';
import 'fullMapScreen.dart';

class AddAdress extends StatefulWidget {
  const AddAdress({super.key});

  @override
  State<AddAdress> createState() => _AddAdressState();
}

class _AddAdressState extends State<AddAdress> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  bool loading = false;
  double long = 67.0011;
  double lat = 24.8607;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(24.8607, 67.0011), zoom: 17);

  LatLng _intialPosition = const LatLng(24.8607, 67.0011);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (Get.find<AuthRepoController>().userModel == null) {
      Get.find<AuthRepoController>().getUserData();
    }

    if (Get.find<LocationRepoController>().addressList.isNotEmpty) {
      long = Get.find<LocationRepoController>().addressList.last.longitude;

      lat = Get.find<LocationRepoController>().addressList.last.latitude;
      _cameraPosition =
          CameraPosition(target: LatLng(lat, long ));
      _intialPosition = LatLng(lat , long );
      _addressController.text =
          Get.find<LocationRepoController>().addressList.last.addressDescription;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _addressController.dispose();
    _contactPersonNumber.dispose();
    _contactPersonName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthRepoController>(builder: (authRepoController) {
      return GetBuilder<LocationRepoController>(builder: (locRepoController) {
        if (authRepoController.userModel != null &&
            _contactPersonName.text.isEmpty) {
          _contactPersonName.text = authRepoController.userModel!.displayName!;
          _contactPersonNumber.text =
              authRepoController.userModel!.phoneNumber!;
          if (locRepoController.addressList.isEmpty ) {
            _addressController.text =
                // locRepoController.addressList.last.addressDescription ??
                    "Press to add address";
          }
        }
        return Scaffold(
          bottomNavigationBar: GestureDetector(
            onTap: () async {

              AddressModel userAddressModel = AddressModel(
                  latitude: _cameraPosition.target.latitude,
                  longitude: _cameraPosition.target.longitude,

                  contactPersonNumber: _contactPersonNumber.text,
                  contactPersonName: _contactPersonName.text,
                  addressType: locRepoController
                      .addressTypeList[locRepoController.addressTypeIndex],
                   addressDescription: _addressController.text);

              ResponseModel res =
                  await locRepoController.addUserAddress(userAddressModel);


              await locRepoController.getUserAddressList();

              CustomSnackbar.showSnackbar(
                  description: res.message,
                  isError: !res.isSuccuess,
                  title: "Address");
            },
            child: Container(
                height: Dimension.Height30 * 1.5,
                width: Dimension.Width30 * 10,
                margin: EdgeInsets.only(
                    left: Dimension.Height10 * 11,
                    right: Dimension.Height10 * 11,
                    bottom: Dimension.Height10),
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimension.Width5 * 7)),
                child: Center(
                    child: BigText(
                  text: "Save Address ",
                  color: Colors.white,
                  size: Dimension.Width15 * 2.3,
                ))),
          ),
          appBar: AppBar(
              title: const BigText(
                text: "Add Addresss",
                color: Colors.white,
              ),
              centerTitle: true,
              backgroundColor: AppColors.mainColor),
          body: SafeArea(
            child: Container(
                padding: EdgeInsets.only(
                    left: Dimension.Height10,
                    right: Dimension.Height10,
                    top: Dimension.Height10),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.mainColor, width: 2)),
                      child: GoogleMap(
                        onTap: (latLng) {
                          Get.toNamed(Routeshelper.geFullMapRoute(),
                              arguments: FullMap(
                                fromProfile: false,
                                fromAddress: true,
                                googleMapController:
                                    locRepoController.mapController,
                              ));
                        },
                        initialCameraPosition: CameraPosition(
                            target: LatLng(lat, long), zoom: 17),
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        myLocationEnabled: true, // Enable current location
                        myLocationButtonEnabled: true,
                        markers: {
                          Marker(
                            markerId: const MarkerId('Location'),
                            position: LatLng(
                                _cameraPosition.target.latitude,
                                _cameraPosition.target.longitude),
                          )
                        },
                        onCameraIdle: () async {
                          loading =
                          true;

                          try {
                            // Set loading to true to prevent multiple calls
                            await locRepoController.updatePosition(
                                _cameraPosition.target.latitude,
                                _cameraPosition.target.longitude,
                                false);
                            _addressController.text =
                                locRepoController.currentPlacemark.name ??
                                    (Get.find<LocationRepoController>()
                                        .pickPlacemark
                                        .name)!;
                          } catch (e) {}
                            loading =
                                false; // Reset loading status after operation

                        },

                        onCameraMove: ((position) {
                          loading = true;
                          _cameraPosition = position;
                          loading = false;
                        }),
                        onMapCreated: (GoogleMapController mapController) {
                          locRepoController.setMapController(mapController);
                        },
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Dimension.Height10 * 8,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  locRepoController.addressTypeList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    locRepoController.setAddressType(index);
                                  },
                                  child: Container(
                                    height: Dimension.Height10,
                                    width: Dimension.Height30 * 1.3,
                                    margin: EdgeInsets.only(
                                        left: Dimension.Height30,
                                        top: Dimension.Width30,
                                        bottom: Dimension.Width30),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimension.Height10),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: AppColors.grayColor,
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                        )
                                      ],
                                    ),
                                    child: Icon(
                                      index == 0
                                          ? Icons.home
                                          : index == 1
                                              ? Icons.work
                                              : Icons.location_on,
                                      color: index ==
                                              locRepoController.addressTypeIndex
                                          ? AppColors.mainColor
                                          : Theme.of(context).disabledColor,
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimension.Height10 * 0.7),
                          child: const BigText(text: "Delivery Address"),
                        ),
                        Stack(
                          children: [



                            CustomInputField(
                              controller: _addressController,
                              icon: CupertinoIcons.map,
                              labelText: 'Delivery Address',
                              maxLines: 2,
                            ),
                            Get.find<LocationRepoController>().loading?  Positioned(
                                top: Dimension.Height30/1.6,
                                left:Dimension.MobileWidth/2.5,

                                child: Customloadingbar()):Container(),
                          ]
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimension.Height10 * 0.7),
                          child: const BigText(text: "Contact name"),
                        ),
                        CustomInputField(
                          controller: _contactPersonName,
                          icon: Icons.person,
                          labelText: 'Delivery Address',
                          maxLines: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimension.Height10 * 0.7),
                          child: const BigText(text: "Contact number"),
                        ),
                        CustomInputField(
                          controller: _contactPersonNumber,
                          icon: CupertinoIcons.phone,
                          labelText: 'Delivery Address',
                          maxLines: 1,
                        ),
                      ],
                    )
                  ],
                )),
          ),
        );
      });
    });
  }
}

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String labelText;
  final int maxLines;

  const CustomInputField({
    super.key,
    required this.icon,
    required this.labelText,
    required this.controller,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimension.Height10),
      child: InputField(
        maxLines: maxLines,
        readOnly: true,
        labelText: labelText,
        hintText: labelText,
        icon: icon,
        textEditingController: controller,
      ),
    );
  }
}
