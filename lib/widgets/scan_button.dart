import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scaner/helpers/navigate_scan.dart';
import 'package:qr_scaner/model/scan_model.dart';
import 'package:qr_scaner/providers/scans_provier.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_scaner/theme/app_theme.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ScansProvider scansProvider = Provider.of<ScansProvider>(context, listen: false);


    return FloatingActionButton(
      backgroundColor: AppTheme.primaryColor,
      onPressed: () async {
        
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ffc107', 'Cancel', true, ScanMode.QR);

        if(barcodeScanRes == '-1') return;

        final ScanModel scan = await scansProvider.addScan(barcodeScanRes);

        navigateScan(context, scan);

        

      },
      child: const Icon(Icons.camera)
    );
  }
}