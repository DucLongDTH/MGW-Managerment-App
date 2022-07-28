import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/gen/assets.gen.dart';
import 'package:app_demo_flutter/l10n/gen/app_localizations.dart';
import 'package:app_demo_flutter/presentation/screen/bill_screen/bill_screen.dart';
import 'package:app_demo_flutter/presentation/screen/dashboard_screen/dashboard_widget.dart';
import 'package:app_demo_flutter/presentation/screen/extends_screen/extends_screen.dart';
import 'package:app_demo_flutter/presentation/screen/product_screen/product_widget.dart';
import 'package:app_demo_flutter/widget/base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:styled_widget/styled_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget buildLayout(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
          body: SafeArea(
              child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            children: listScreenWidget,
          )),
          bottomNavigationBar: _buildCustomBottomWidget(context)),
    );
  }

  Widget _buildCustomBottomWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      height: kBottomNavigationBarHeight + 2.h,
      child: Material(
        color: white,
        child: TabBar(
            splashFactory: NoSplash.splashFactory,
            overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
              return Colors.transparent;
            }),
            labelColor: darkBlue,
            labelStyle: ThemeProvider.instance.textStyleMed12,
            unselectedLabelColor: grey,
            unselectedLabelStyle: ThemeProvider.instance.textStyleMed12,
            controller: controller,
            padding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            tabs: _buildListTab(context)),
      ),
    );
  }

  List<Widget> _buildListTab(BuildContext context) {
    return [
      Tab(
        icon: _buildIcon(
            asset: Assets.icons.icHomeOutline,
            color: controller.index == 0 ? darkBlue : grey),
        text: AppLocalizations.of(context)!.lbl_item_menu_dashboard,
        iconMargin: const EdgeInsets.all(0),
      ),
      Tab(
        icon: _buildIcon(
            asset: Assets.icons.icInvoiceOutline,
            color: controller.index == 1 ? darkBlue : grey),
        text: AppLocalizations.of(context)!.lbl_item_menu_bill,
        iconMargin: const EdgeInsets.all(0),
      ),
      Tab(
        icon: _buildIcon(
            asset: Assets.icons.icProductOutline,
            color: controller.index == 2 ? darkBlue : grey),
        text: AppLocalizations.of(context)!.lbl_item_menu_product,
        iconMargin: const EdgeInsets.all(0),
      ),
      Tab(
        icon: _buildIcon(
            asset: Assets.icons.icMenuMore,
            color: controller.index == 3 ? darkBlue : grey),
        text: AppLocalizations.of(context)!.lbl_item_menu_more,
        iconMargin: const EdgeInsets.all(0),
      ),
    ];
  }

  final List<Widget> listScreenWidget = [
    const DashBoardWidget(),
    const BillScreen(),
    const ProductPageWidget(),
    const ExtendsScreen()
  ];

  _buildIcon({required asset, required color}) {
    return SvgPicture.asset(asset, color: color).padding(bottom: 4.h);
  }

  // BottomNavigationBar(
  //     currentIndex: _currentPage,
  //     selectedItemColor: darkBlue,
  //     onTap: (index) {
  //       setState(() {
  //         _currentPage = index;
  //       });
  //     },
  //     type: BottomNavigationBarType.fixed,
  //     backgroundColor: white,
  //     selectedLabelStyle:
  //         ThemeProvider.instance.textStyleBold12.copyWith(color: darkBlue),
  //     unselectedLabelStyle:
  //         ThemeProvider.instance.textStyleMed10.copyWith(color: grey),
  //     items: [
  //       BottomNavigationBarItem(
  //           icon:
  //               _buildIcon(asset: Assets.icons.icHomeOutline, color: grey),
  //           label: AppLocalizations.of(context)!.lbl_item_menu_dashboard,
  //           activeIcon:
  //               _buildIcon(asset: Assets.icons.icHome, color: darkBlue)),
  //       BottomNavigationBarItem(
  //           icon: _buildIcon(
  //               asset: Assets.icons.icInvoiceOutline, color: grey),
  //           label: AppLocalizations.of(context)!.lbl_item_menu_bill,
  //           activeIcon:
  //               _buildIcon(asset: Assets.icons.icInvoice, color: darkBlue)),
  //       BottomNavigationBarItem(
  //           icon: _buildIcon(
  //               asset: Assets.icons.icProductOutline, color: grey),
  //           label: AppLocalizations.of(context)!.lbl_item_menu_product,
  //           activeIcon:
  //               _buildIcon(asset: Assets.icons.icProduct, color: darkBlue)),
  //       BottomNavigationBarItem(
  //           icon: _buildIcon(asset: Assets.icons.icMenuMore, color: grey),
  //           label: AppLocalizations.of(context)!.lbl_item_menu_more,
  //           activeIcon: _buildIcon(
  //               asset: Assets.icons.icMenuMore, color: darkBlue)),
  //     ]),
}
