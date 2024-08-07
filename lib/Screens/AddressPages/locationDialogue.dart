import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resturantapp/controller/location_repo_controller.dart';
import 'package:resturantapp/models/address_model.dart';
import 'package:resturantapp/utils/dimmensions.dart';

class LocationDialogue extends StatelessWidget {
  final GoogleMapController mapController;
  late final TextEditingController _controller = TextEditingController();
  LocationDialogue({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimension.Width30),
          ),
          child: SizedBox(
            width: Dimension.MobileWidth,
            child: Container(
              margin: EdgeInsets.all(Dimension.Height10),
              child: TypeAheadField<AddressModel>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _controller,
                  textInputAction: TextInputAction.search,
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.streetAddress,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontSize: Dimension.Height30 / 2.3),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(style: BorderStyle.none, width: 0),
                    ),
                    hintText: 'Search Address',
                  ),
                ),
                suggestionsCallback: (String pattern) async {
                  return await Get.find<LocationRepoController>()
                      .getSearchLocation(context, pattern);
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                itemBuilder: (BuildContext context, AddressModel suggestion) {
                  return ListTile(
                    leading: const Icon(Icons.location_on),
                    title: Text(
                      suggestion.displayName ?? 'No Name',
                      maxLines: 1,
                    ),
                  );
                },
                onSuggestionSelected: (AddressModel suggestion) {
                  _controller.text = suggestion.displayName!;
                  Get.find<LocationRepoController>().updatePosition(
                      double.parse(suggestion.lat!),
                      double.parse(suggestion.lon!),
                      false);
                  mapController.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(
                              Get.find<LocationRepoController>()
                                  .pickPostion
                                  .latitude,
                              Get.find<LocationRepoController>()
                                  .pickPostion
                                  .longitude),
                          zoom: 17),
                    ),
                  );
                  Get.back();

                  // Get.find<LocationRepoController>().updatePosition(
                  //     double.parse(suggestion.lat!),
                  //     double.parse(suggestion.lon!),
                  //     false);
                },
              ),
            ),
          )),
    );
  }
}
