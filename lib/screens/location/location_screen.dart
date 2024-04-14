import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stock_reminder/services/location_service.dart';
import 'package:latlong2/latlong.dart';

import '../../utils/constants.dart';
import '../home/home_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("init state invoked");
    setState(() {});
  }

  List<Marker> greenMarkers = [
    Marker(
      width: 100.0,
      height: 100.0,
      point: LatLng(19.055342, 72.891464), // Within 5 km of center point
      builder: (BuildContext ctx) => Container(
        width: 120,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Colors.green,
              size: 50.0,
            ),
            Flexible(
              child: Text(
                'Welness Hospital',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      anchorPos: AnchorPos.align(AnchorAlign.top),
    ),
    Marker(
      width: 100.0,
      height: 100.0,
      point: LatLng(19.056785, 72.902047), // Within 5 km of center point
      builder: (BuildContext ctx) => Container(
        width: 120,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Colors.green,
              size: 50.0,
            ),
            Flexible(
              child: Text(
                'Lilavati Hospital and Research Center',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      anchorPos: AnchorPos.align(AnchorAlign.top),
    ),
    Marker(
      width: 100.0,
      height: 100.0,
      point: LatLng(19.059837, 72.903295), // Within 5 km of center point
      builder: (BuildContext ctx) => Container(
        width: 120,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Colors.green,
              size: 50.0,
            ),
            Flexible(
              child: Text(
                'Mercy General Hospital',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      anchorPos: AnchorPos.align(AnchorAlign.top),
    ),
    Marker(
      width: 100.0,
      height: 100.0,
      point: LatLng(19.053819, 72.897325), // Within 5 km of center point
      builder: (BuildContext ctx) => Container(
        width: 120,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Colors.green,
              size: 50.0,
            ),
            Flexible(
              child: Text(
                'Chembur City Hospital',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      anchorPos: AnchorPos.align(AnchorAlign.top),
    ),
    Marker(
      width: 100.0,
      height: 100.0,
      point: LatLng(19.051028, 72.922218), // Within 5 km of center point
      builder: (BuildContext ctx) => Container(
        width: 120,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Colors.green,
              size: 50.0,
            ),
            Flexible(
              child: Text(
                'LifeCare Hospital',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      anchorPos: AnchorPos.align(AnchorAlign.top),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<LocationService>(context);
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Consumer<LocationService>(
            builder: (context, value, child) {
              return FlutterMap(
                mapController: value.mapController,
                options: MapOptions(
                    center: LatLng(value.lat, value.long),
                    zoom: 40,
                    onTap: ((tapPosition, point) {
                      _provider.setLatLong(point.latitude, point.longitude);
                    })),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: "https://openstreetmap.org/copyright",
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
                        ] +
                        greenMarkers,
                  ),
                ],
              );
            },
          ),
        ),
        Positioned(
          top: 60,
          left: 10,
          right: 10,
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 4,
                        blurRadius: 4),
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Search for hospitals...",
                        style: GoogleFonts.inter(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 460,
              ),
              SizedBox(
                height: 250,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('hospitals')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final hospitalData = snapshot.data!.docs;
                        return SizedBox(
                          height: 250,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: hospitalData.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: HomeHospitalCard(
                                    address: hospitalData[index]['address'],
                                    imageUrl: hospitalData[index]['imageUrl'],
                                    name: hospitalData[index]['name'],
                                    rating: hospitalData[index]['rating']
                                        .toString(),
                                    reviews: hospitalData[index]['reviews']),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: primaryButtonColor,
                          ),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
