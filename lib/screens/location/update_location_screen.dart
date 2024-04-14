import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:stock_reminder/services/location_service.dart';
import 'package:stock_reminder/utils/constants.dart';

class UserLocationScreen extends StatefulWidget {
  const UserLocationScreen({super.key});
  static const routeName = '/location-screen';

  @override
  State<UserLocationScreen> createState() => _UserLocationScreenState();
}

class _UserLocationScreenState extends State<UserLocationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final location = Provider.of<LocationService>(context, listen: false);
      location.getCurrentUserLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<LocationService>(context);
    // log("Latitude:${_provider.lat} Longitude: ${_provider.long}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryButtonColor,
        centerTitle: false,
        title: Text(
          "set your location",
          style: GoogleFonts.quando(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SizedBox(
        child: Stack(
          children: [
            Consumer<LocationService>(
              builder: (context, value, child) {
                return Positioned.fill(
                  child: FlutterMap(
                    mapController: value.mapController,
                    options: MapOptions(
                        center: LatLng(value.lat, value.long),
                        zoom: 20,
                        onTap: ((tapPosition, point) {
                          _provider.setLatLong(point.latitude, point.longitude);
                        })),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName:
                            "https://openstreetmap.org/copyright",
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: LatLng(value.lat, value.long),
                            builder: (BuildContext ctx) => Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red.withOpacity(0.25),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 50),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 50.0,
                                  ),
                                ),
                              ),
                            ),
                            anchorPos: AnchorPos.align(AnchorAlign.top),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            Consumer<LocationService>(
              builder: (context, value, child) {
                return Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: primaryButtonColor,
                              size: 50,
                            ),
                            title: Text(
                              value.address.street!,
                              style: GoogleFonts.quando(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${value.address.locality ?? "..."}, ${value.address.postalCode ?? "..."}, ${value.address.country ?? "..."}",
                              style: GoogleFonts.quando(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: primaryButtonColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Confirm Address > ",
                                  style: GoogleFonts.quando(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
