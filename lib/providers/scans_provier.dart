import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_scaner/model/scan_model.dart';

class ScansProvider extends ChangeNotifier {
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<ScanModel> scans = [];
  final String selectedType = 'geo';

  Future<ScanModel> addScan(String value) async {

    final ScanModel scan = ScanModel(value: value);
    final res = await firestore.collection('scans').add(scan.toJson());
    scan.id = res.id;

    return scan;

  }

  getScansByType(String type) async {

    final List<ScanModel> scansRes = [];

    final querySnapshot = await firestore.collection('scans').where('type', isEqualTo: type).get();

    for (final doc in querySnapshot.docs) {
        final newScan = ScanModel(value: doc['value']);
        newScan.id = doc.id;
        scansRes.add(newScan);
    }

    scans = scansRes;
    notifyListeners();
    
  }

  deleteAllScans() async {

    if(scans.isNotEmpty) {

      for (final scan in scans) {
        
        firestore.collection('scans').doc(scan.id).delete();
        
      }

    }


  }

  deleteById(String id) {

    firestore.collection('scans').doc(id).delete();

  }

}