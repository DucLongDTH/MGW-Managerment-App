import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/gen/assets.gen.dart';
import 'package:app_demo_flutter/presentation/screen/home_screen/product/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:styled_widget/styled_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: listScreenWidget.elementAt(_currentPage),
      )),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPage,
          selectedItemColor: darkBlue,
          onTap: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          backgroundColor: white,
          selectedLabelStyle:
              ThemeProvider.instance.textStyleBold14.copyWith(color: darkBlue),
          unselectedLabelStyle:
              ThemeProvider.instance.textStyleMed14.copyWith(color: grey),
          items: [
            BottomNavigationBarItem(
                icon:
                    _buildIcon(asset: Assets.icons.icHomeOutline, color: grey),
                label: 'Home',
                activeIcon:
                    _buildIcon(asset: Assets.icons.icHome, color: darkBlue)),
            BottomNavigationBarItem(
                icon: _buildIcon(
                    asset: Assets.icons.icInvoiceOutline, color: grey),
                label: 'Bill',
                activeIcon:
                    _buildIcon(asset: Assets.icons.icInvoice, color: darkBlue)),
            BottomNavigationBarItem(
                icon: _buildIcon(
                    asset: Assets.icons.icProductOutline, color: grey),
                label: 'Product',
                activeIcon:
                    _buildIcon(asset: Assets.icons.icProduct, color: darkBlue)),
          ]),
    );
  }

  final List<Widget> listScreenWidget = [
    Text(
      'Index 1: Home',
      style: ThemeProvider.instance.textStyleBold24,
    ),
    Text(
      'Index 2: Bill',
      style: ThemeProvider.instance.textStyleBold24,
    ),
    const ProductPageWidget()
  ];

  _buildIcon({required asset, required color}) {
    return SvgPicture.asset(asset, color: color).padding(bottom: 4.h);
  }
}
