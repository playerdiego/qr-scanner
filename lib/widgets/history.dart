import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scaner/helpers/navigate_scan.dart';
import 'package:qr_scaner/model/scan_model.dart';
import 'package:qr_scaner/providers/scans_provier.dart';

class History extends StatelessWidget {
  const History({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ScansProvider scansProvider = Provider.of<ScansProvider>(context);

    if(scansProvider.scans.isNotEmpty) {
      return ListView.builder( 
        itemCount: scansProvider.scans.length,
        itemBuilder: (BuildContext context, int index) {

          final ScanModel scan = scansProvider.scans[index];
          final IconData icon = scan.type == 'geo' ? Icons.map : Icons.web;

          return Dismissible(
            key: Key(scan.id!),
            onDismissed: (direction) {
              scansProvider.deleteById(scan.id!);
            },
            background: Container(
              color: Colors.red[400],
            ),
            child: ListTile(
              title: Text(scan.value),
              subtitle: Text(scan.id.toString()),
              leading: Icon(icon),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => navigateScan(context, scan),
            ),
          );
        },
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.camera),
            Text('Scan something')
          ],
        ),
      );
    }
  }
}