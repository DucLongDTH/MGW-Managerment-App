import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/gen/assets.gen.dart';
import 'package:app_demo_flutter/l10n/gen/app_localizations.dart';
import 'package:app_demo_flutter/presentation/screen/dashboard_screen/dashboard_widget.dart';
import 'package:app_demo_flutter/presentation/screen/product_screen/product_widget.dart';
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
          type: BottomNavigationBarType.fixed,
          backgroundColor: white,
          selectedLabelStyle:
              ThemeProvider.instance.textStyleBold12.copyWith(color: darkBlue),
          unselectedLabelStyle:
              ThemeProvider.instance.textStyleMed10.copyWith(color: grey),
          items: [
            BottomNavigationBarItem(
                icon:
                    _buildIcon(asset: Assets.icons.icHomeOutline, color: grey),
                label: AppLocalizations.of(context)!.lbl_item_menu_dashboard,
                activeIcon:
                    _buildIcon(asset: Assets.icons.icHome, color: darkBlue)),
            BottomNavigationBarItem(
                icon: _buildIcon(
                    asset: Assets.icons.icInvoiceOutline, color: grey),
                label: AppLocalizations.of(context)!.lbl_item_menu_bill,
                activeIcon:
                    _buildIcon(asset: Assets.icons.icInvoice, color: darkBlue)),
            BottomNavigationBarItem(
                icon: _buildIcon(
                    asset: Assets.icons.icProductOutline, color: grey),
                label: AppLocalizations.of(context)!.lbl_item_menu_product,
                activeIcon:
                    _buildIcon(asset: Assets.icons.icProduct, color: darkBlue)),
            BottomNavigationBarItem(
                icon: _buildIcon(asset: Assets.icons.icMenuMore, color: grey),
                label: AppLocalizations.of(context)!.lbl_item_menu_more,
                activeIcon: _buildIcon(
                    asset: Assets.icons.icMenuMore, color: darkBlue)),
          ]),
    );
  }

  final List<Widget> listScreenWidget = [
    const DashBoardWidget(),
    Text(
      'Index 2: Bill',
      style: ThemeProvider.instance.textStyleBold24,
    ),
    const ProductPageWidget(),
    Text(
      'Index 2: Bill',
      style: ThemeProvider.instance.textStyleBold24,
    ),
  ];

  _buildIcon({required asset, required color}) {
    return SvgPicture.asset(asset, color: color).padding(bottom: 4.h);
  }
}
