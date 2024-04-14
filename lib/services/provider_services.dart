import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_reminder/screens/doctors/doctors_screen.dart';

enum Status { loading, success, error }

class DoctorServices with ChangeNotifier {
  DoctorServices() {
    getAllDoctors();
  }
  List<DoctorCard> _doctorCardList = [];
  List<DoctorCard> _filteredDoctorList = [];

  String _currentFilter = "All";

  Status _status = Status.loading;

  Status get status {
    return _status;
  }

  List<DoctorCard> get doctorsList {
    return [..._doctorCardList];
  }

  List<DoctorCard> get filteredDoctorList {
    return [..._filteredDoctorList];
  }

  String get currentFilter {
    return _currentFilter;
  }

  setStatus(Status status) {
    _status = status;
    notifyListeners();
  }

  setCurrentFilter(String val) {
    _currentFilter = val;
    notifyListeners();
  }

  filterDoctor() {
    log(_currentFilter);
    if (_currentFilter == 'All') {
      // _filteredDoctorList.clear();
      _filteredDoctorList = _doctorCardList;
      notifyListeners();
    } else {
      // _filteredDoctorList.clear();
      log(_filteredDoctorList.length.toString());
      _filteredDoctorList = _doctorCardList.where((element) {
        // log(element.speciality);
        return element.speciality == _currentFilter;
      }).toList();
      // log(_filteredDoctorList[0].speciality);
      notifyListeners();
    }
  }

  getAllDoctors() async {
    List<DocumentSnapshot> docs = [];
    try {
      final doctorList =
          await FirebaseFirestore.instance.collection('doctors').get();

      docs = doctorList.docs;
      docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        log(data.toString());
        _doctorCardList.add(
          DoctorCard(
            id: element.id,
            name: data['Name'] ?? ' ',
            address: data['Clinic'] ?? ' ',
            imageUrl: data['imageUrl'] ?? ' ',
            rating: data['Rating'].toStringAsFixed(1) ?? " ",
            reviews: data['Total Reviews'] != null
                ? data['Total Reviews'].toString()
                : " ",
            speciality: data['Specialty'] ?? " ",
          ),
        );
      });
      _filteredDoctorList = _doctorCardList;
      setStatus(Status.success);
    } catch (e) {
      setStatus(Status.error);
      log(e.toString());
    }
  }
}
