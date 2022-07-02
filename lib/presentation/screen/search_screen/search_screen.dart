import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/constant/key_utils.dart';
import 'package:app_demo_flutter/gen/assets.gen.dart';
import 'package:app_demo_flutter/l10n/gen/app_localizations.dart';
import 'package:app_demo_flutter/widget/base/base_state.dart';
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
      body: SafeArea(
        child: Hero(
          tag: searchButtonTag,
          child: Card(
              color: white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.icons.icSearch,
                        width: 21.w,
                        height: 21.h,
                        color: grey,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        AppLocalizations.of(context)!.lbl_search_hint,
                        style: ThemeProvider.instance.textStyleMed14
                            .copyWith(color: grey),
                      )
                    ]),
              )),
        ),
      ),
    );
  }
}
