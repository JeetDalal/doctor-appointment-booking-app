import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stock_reminder/screens/home/home_screen.dart';
import 'package:stock_reminder/services/provider_services.dart';
import 'package:stock_reminder/utils/constants.dart';

import 'doctor_details_screen.dart';

class DoctorScreen extends StatefulWidget {
  // final String category;
  DoctorScreen({super.key});

  static const routeName = '/doctors-screen';

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  int selectedIndex = 0;
  String category = "General";
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
    final provider = Provider.of<DoctorServices>(context);
    selectedIndex = categoryList
        .indexWhere((element) => element.title == provider.currentFilter);
    if (ModalRoute.of(context)!.settings.arguments != null) {
      category = ModalRoute.of(context)!.settings.arguments as String;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'All Doctors',
          style: GoogleFonts.inter(
            color: primaryButtonColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 24,
            ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xffF3F4F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Icon(
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
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
              itemCount: categoryList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    onTap: () {
                      provider.setCurrentFilter(categoryList[index].title);
                      provider.filterDoctor();
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: index != selectedIndex
                            ? Colors.white
                            : primaryButtonColor,
                        border: index == selectedIndex
                            ? null
                            : Border.all(
                                color: primaryButtonColor,
                              ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            categoryList[index].title,
                            style: GoogleFonts.inter(
                                color: index == selectedIndex
                                    ? Colors.white
                                    : primaryButtonColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "${provider.filteredDoctorList.length} found",
                  style: GoogleFonts.inter(
                    color: primaryButtonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Consumer<DoctorServices>(builder: (context, value, child) {
            if (value.status == Status.success) {
              return Flexible(
                child: ListView.builder(
                  itemCount: value.filteredDoctorList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 8,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              DoctorDetailsScreen.routeName,
                              arguments: value.filteredDoctorList[index]);
                        },
                        child: DoctorCard(
                          id: value.filteredDoctorList[index].id,
                          address: value.filteredDoctorList[index].address,
                          imageUrl: value.filteredDoctorList[index].imageUrl,
                          name: value.filteredDoctorList[index].name,
                          rating: value.filteredDoctorList[index].rating,
                          reviews: value.filteredDoctorList[index].reviews,
                          speciality:
                              value.filteredDoctorList[index].speciality,
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (value.status == Status.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryButtonColor,
                ),
              );
            } else {
              return Center(
                child: Text("Error Loading data"),
              );
            }
          }),
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String id;
  final String address;
  final String imageUrl;
  final String rating;
  final String reviews;
  final String speciality;
  const DoctorCard(
      {super.key,
      required this.id,
      required this.name,
      required this.address,
      required this.imageUrl,
      required this.rating,
      required this.reviews,
      required this.speciality});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 4),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 109,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUrl),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryButtonColor,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  child: SizedBox(
                    width: 220,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Text(
                  speciality,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff4B5563),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Color(0xff4B5563),
                    ),
                    Text(
                      address,
                      style: GoogleFonts.inter(color: Color(0xff4B5563)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Icon(
                            Icons.star,
                            color: ratingColor,
                          ),
                        ),
                        Text(
                          '$rating |   $reviews reviews',
                          style: GoogleFonts.inter(
                            color: Color(0xff6B7280),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
