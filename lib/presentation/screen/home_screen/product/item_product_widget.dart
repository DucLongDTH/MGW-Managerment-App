import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemProductWidget extends StatelessWidget {
  final int index;
  const ItemProductWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w,vertical: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: HexColor.fromHex('#7090B0').withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          flex: 4,
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Image.asset(
              Assets.images.demoPic.path,
              width: 80.w,
              height: 80.h,
              // color: white,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Text(
                'NAME PRODUCT $index',
                maxLines: 2,
                style: ThemeProvider.instance.textStyleBold20
                    .copyWith(color: darkBlue, overflow: TextOverflow.ellipsis),
              ),
              SizedBox(height: 5.h),
              Text(
                '600 \$',
                style: ThemeProvider.instance.textStyleMed14,
              ),
              SizedBox(height: 5.h),
              Text('Number In Stock'),
              SizedBox(height: 5.h),
              Text('Rating'),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
