import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/constant/key_utils.dart';
import 'package:app_demo_flutter/gen/assets.gen.dart';
import 'package:app_demo_flutter/l10n/gen/app_localizations.dart';
import 'package:app_demo_flutter/widget/base/base_state.dart';
import 'package:app_demo_flutter/widget/mgw_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends BaseState<SearchScreen> {
  @override
  Widget buildLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36.r), topRight: Radius.circular(36.r)),
          child: Container(
              color: white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  children: [
                    SizedBox(height: 8.h),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: darkBlue, width: 2))),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Hero(
                              tag: searchButtonTag,
                              child: SvgPicture.asset(
                                Assets.icons.icSearch,
                                width: 21.w,
                                height: 21.h,
                                color: grey,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(child: _buildTextFieldSearch())
                          ]),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget _buildTextFieldSearch() {
    return TextFormField(
      style: ThemeProvider.instance.textStyleBold14.copyWith(color: darkBlue),
      decoration: InputDecoration(
          hintText: 'Tìm kiếm sản phẩm',
          border: InputBorder.none,
          hintStyle: ThemeProvider.instance.textStyleMed14),
    );
  }
}
