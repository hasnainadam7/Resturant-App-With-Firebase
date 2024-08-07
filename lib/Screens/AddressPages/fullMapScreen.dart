// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resturantapp/controller/location_repo_controller.dart';
import 'package:resturantapp/utils/colors.dart';
import 'package:resturantapp/utils/dimmensions.dart';
import 'package:resturantapp/widgets/BigText.dart';
import 'package:resturantapp/widgets/CustomLoadingBar.dart';

import 'CutomButton.dart';
import 'locationDialogue.dart';

class FullMap extends StatefulWidget {
  const FullMap(
      {super.key,
      required this.fromProfile,
      required this.fromAddress,
      required this.googleMapController});
  final bool fromProfile, fromAddress;
  final GoogleMapController googleMapController;

  @override
  State<FullMap> createState() => _FullMapState();
}

class _FullMapState extends State<FullMap> {
  late LatLng _latlng;
  late CameraPosition _cameraPosition;
  late GoogleMapController _googleMapController;
  late TextEditingController addressController = TextEditingController();
  bool loading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // googleMapController.dispose();
    addressController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<LocationRepoController>().getUserAddress();
    addressController.text =
        (Get.find<LocationRepoController>().pickPlacemark.name ??
                Get.find<LocationRepoController>().currentPlacemark.name) ??
            "no adress";

    if (Get.find<LocationRepoController>().userAddressModel == null) {
      _latlng = const LatLng(11, 52);
      _cameraPosition = CameraPosition(target: _latlng, zoom: 17);
    } else {
      double? long =
          Get.find<LocationRepoController>().userAddressModel?.longitude;

      double? lat =
          Get.find<LocationRepoController>().userAddressModel?.latitude;
      if (Get.find<LocationRepoController>().userAddressModel != null &&
          lat != null &&
          long != null) {
        _cameraPosition = CameraPosition(target: LatLng(lat, long));
        _latlng = LatLng(lat, long);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: GetBuilder<LocationRepoController>(
                builder: (locRepoController) {
              return Stack(
                children: [
                  GoogleMap(
                    onMapCreated: (GoogleMapController mapController) {
                      _googleMapController = mapController;
                    },
                    initialCameraPosition:
                        CameraPosition(target: _latlng, zoom: 17),
                    zoomControlsEnabled: false,
                    onCameraMove: (cameraPosition) {
                      loading = true;
                      _cameraPosition = cameraPosition;
                      loading = false;
                    },
                    onCameraIdle: () async {
                      if (!loading) {
                        try {
                          loading =
                              true; // Set loading to true to prevent multiple calls
                          await locRepoController.updatePosition(
                              _cameraPosition.target.latitude,
                              _cameraPosition.target.longitude,
                              false);
                          addressController.text =
                              locRepoController.pickPlacemark.name ??
                                  locRepoController.currentPlacemark.name ??
                                  "";
                        } finally {
                          loading =
                              false; // Reset loading status after operation
                        }
                      }
                    },
                  ),
                  locRepoController.loading
                      ? Container(
                          // width: double.maxFinite,
                          color: Colors.transparent,
                          child: const Customloadingbar(),
                        )
                      : Center(
                          child: SizedBox(
                            height: Dimension.Height10 * 4,
                            width: Dimension.Height10 * 4,
                            child: Image.asset("assets/image/pick_marker.png"),
                          ),
                        ),
                  Positioned(
                      top: Dimension.Height15 * 0.5,
                      left: Dimension.Width15,
                      right: Dimension.Width15,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimension.Height15),
                        height: Dimension.Height15 * 5,
                        // width: 200,
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimension.Height15 * 2))),
                        child: InkWell(
                          onTap: () {
                            // Get.dialog(Container(
                            //   decoration: BoxDecoration(
                            //       color: AppColors.mainColor,
                            //       borderRadius: BorderRadius.all(
                            //           Radius.circular(
                            //               Dimmensions.Height15 * 2))),
                            //   height: Dimmensions.Height15 * 100,
                            // ));
                            Get.dialog(LocationDialogue(
                              mapController: _googleMapController,
                            ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.yellowAccent,
                              ),
                              Expanded(
                                  child: BigText(
                                text: addressController.text,
                                color: Colors.white,
                              )),
                              const Icon(
                                Icons.location_on,
                                color: Colors.yellowAccent,
                              ),
                            ],
                          ),
                        ),
                      )),
                  Positioned(
                      top: Dimension.MobileHeight -
                          Dimension.MobileHeight / 5,
                      left: Dimension.Width30 * 2,
                      right: Dimension.Width30 * 2,
                      child: locRepoController.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Cutombutton(
                              btnText: locRepoController.isZone
                                  ? widget.fromAddress
                                      ? "Pick Address"
                                      : "Pick Location"
                                  : "Service not available",
                              fontSize: Dimension.Height30 / 1.5,
                              icon: CupertinoIcons.location_fill,
                              onPressed: (locRepoController.loading ||
                                      locRepoController.isBtnDisabled)
                                  ? () {}
                                  : () {
                                      if (locRepoController
                                                  .pickPlacemark.name !=
                                              null &&
                                          locRepoController
                                                  .pickPostion.longitude !=
                                              0) {
                                        if (widget.fromAddress) {
                                          widget.googleMapController.moveCamera(
                                            CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                  target: LatLng(
                                                      locRepoController
                                                          .pickPostion.latitude,
                                                      locRepoController
                                                          .pickPostion
                                                          .longitude),
                                                  zoom: 17),
                                            ),
                                          );
                                          Get.back();
                                          // Get.toNamed(Routeshelper.getAddressPageRoute());
                                        }
                                      }
                                    },
                            ))
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
