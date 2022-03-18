import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scaner/providers/scans_provier.dart';
import 'package:qr_scaner/providers/ui_provider.dart';
import 'package:qr_scaner/theme/app_theme.dart';
import 'package:qr_scaner/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final UIProvider uiProvider = Provider.of<UIProvider>(context);
    final ScansProvider scansProvider = Provider.of<ScansProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scaner'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              scansProvider.deleteAllScans();
            },
            icon: const Icon(Icons.delete_forever),
          )
        ],
      ),
      body: _HomeBody(screenIndex: uiProvider.screenIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        fixedColor: AppTheme.primaryColor,
        currentIndex: uiProvider.screenIndex,
        onTap: (value) => uiProvider.setScreenIndex(value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.computer),
            label: 'Web'
          ),
        ],
      ),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeBody extends StatelessWidget {

  final int screenIndex;

  const _HomeBody({
    Key? key,
    required this.screenIndex
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ScansProvider scansProvider = Provider.of<ScansProvider>(context);

    switch (screenIndex) {
      case 0:
        scansProvider.getScansByType('geo');
        break;
      case 1:
        scansProvider.getScansByType('http');
        break;
      default:
        scansProvider.getScansByType('geo');
    }

    return const History();
  }
}