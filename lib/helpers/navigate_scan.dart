import 'package:flutter/material.dart';
import 'package:qr_scaner/model/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

navigateScan (BuildContext context, ScanModel scan) async {

  if(scan.type == 'http'){
    if (!await launch(scan.value)) throw 'Could not launch ${scan.value}';
  } else if(scan.type == 'geo') {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }

}