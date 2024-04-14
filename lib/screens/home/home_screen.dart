import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_reminder/screens/doctors/doctors_screen.dart';
import 'package:stock_reminder/screens/home/widgets/add_investment.dart';
import 'package:stock_reminder/screens/home/widgets/plan_card.dart';
import 'package:stock_reminder/screens/location/update_location_screen.dart';
import 'package:stock_reminder/services/auth_service.dart';
// import 'package:stock_reminder/services/hospital_services.dart';
import 'package:stock_reminder/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryItem> categoryList = const [
    CategoryItem(
      imageUrl: 'images/tooth.png',
      color: Color(0xffDC9497),
      title: "Dentist",
    ),
    CategoryItem(
      imageUrl: 'images/heart.png',
      color: Color(0xff93C19E),
      title: "Cardiologist",
    ),
    CategoryItem(
      imageUrl: 'images/lung.png',
      color: Color(0xffF5AD7E),
      title: "Pulmonologist",
    ),
    CategoryItem(
      imageUrl: 'images/steth.png',
      color: Color(0xffACA1CD),
      title: "General",
    ),
    CategoryItem(
      imageUrl: 'images/brain.png',
      color: Color(0xff4D9B91),
      title: "Nuerologist",
    ),
    CategoryItem(
      imageUrl: 'images/tooth.png',
      color: Color(0xffDC9497),
      title: "Nuerologist",
    ),
    CategoryItem(
      imageUrl: 'images/tooth.png',
      color: Color(0xff352261),
      title: "Gastrologist",
    ),
    CategoryItem(
      imageUrl: 'images/pot.png',
      color: Color(0xffDEB6B5),
      title: "Laboratory",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // final data = (userData.data() as Map<String, dynamic>)['name'];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            // vertical: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HomeHeaderWidget(),
                SizedBox(
                  height: 30,
                ),
                HomeSearchBarWidget(),
                SizedBox(
                  height: 14,
                ),
                DoctorAdCard(),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: primaryButtonColor,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(DoctorScreen.routeName);
                        // await DbService().addDoctorsToFirestore();
                      },
                      child: Text(
                        "See All",
                        style: GoogleFonts.inter(
                          // fontWeight: FontWeight.bold,
                          color: Color(0xff6B7280),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 13,
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 8,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 32,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              DoctorScreen.routeName,
                              arguments: categoryList[index].title);
                        },
                        child: categoryList[index].animate().moveY().fadeIn(
                              duration: Duration(milliseconds: 500),
                              delay: Duration(milliseconds: index * 200),
                            ));
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nearby Medical Centers",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: primaryButtonColor,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "See All",
                      style: GoogleFonts.inter(
                        // fontWeight: FontWeight.bold,
                        color: Color(0xff6B7280),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 13,
                ),
                StreamBuilder<QuerySnapshot>(
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
                              ).animate().moveY().fadeIn(
                                    duration: const Duration(milliseconds: 500),
                                    delay: Duration(milliseconds: index * 200),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeHospitalCard extends StatelessWidget {
  final String name;
  final int reviews;
  final String imageUrl;
  final String rating;
  final String address;

  const HomeHospitalCard({
    super.key,
    required this.reviews,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 232,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 121,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: Color(0xff4B5563),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                      size: 18,
                    ),
                    Flexible(
                      child: Text(
                        address,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                            fontSize: 12, color: Color(0xff6B7280)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "  $rating",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Color(0xff6B7280),
                      ),
                    ),
                    Row(
                      children: List.generate(
                          int.parse(rating),
                          (index) => const Icon(
                                Icons.star,
                                color: Color(0xffFEB052),
                                size: 16,
                              )),
                    ),
                    Text(
                      "($reviews reviews)",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Color(0xff6B7280),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "2.4km/40mins",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Color(0xff6B7280),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.maps_home_work_outlined,
                      color: Color(0xff6B7280),
                    ),
                    Text(
                      "Hospital",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Color(0xff6B7280),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Color color;
  const CategoryItem(
      {required this.imageUrl,
      required this.color,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Stack(
            children: [
              Container(
                height: 72,
                width: 62,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: -20,
                left: -20,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xffD9D9D9).withOpacity(0.2),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
            color: const Color(0xff4B5563),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class DoctorAdCard extends StatelessWidget {
  const DoctorAdCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('images/doc4.png')),
            borderRadius: BorderRadius.circular(10),
          ),
        ).animate().fadeIn(
              begin: -0.5,
            ),
        Positioned(
          top: -50,
          left: -50,
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xffD9D9D9).withOpacity(0.2),
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Looking for\nSpecialist Doctors?",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ).animate().moveY().fadeIn(),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Schedule an appointment with\nour top doctors.",
                style: GoogleFonts.inter(
                  // fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ).animate().moveX().fadeIn(),
            ],
          ),
        ),
      ],
    );
  }
}

class HomeSearchBarWidget extends StatelessWidget {
  const HomeSearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Image.asset(
              'images/search-normal.png',
            ),
            Text(
              "   Search doctor...",
              style: GoogleFonts.inter(
                color: const Color(
                  0xff9CA3AF,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '  Location',
            ),
            const SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(UserLocationScreen.routeName);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: primaryButtonColor,
                  ),
                  Text('Chembur, Mumbai'),
                  Icon(
                    Icons.keyboard_arrow_down,
                  )
                ],
              ),
            ),
          ],
        ),
        Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('images/notification-bing.png'),
            )),
      ],
    );
  }
}
