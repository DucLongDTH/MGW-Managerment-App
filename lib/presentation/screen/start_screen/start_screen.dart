import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/l10n/gen/app_localizations.dart';
import 'package:app_demo_flutter/presentation/cubit/demo_cubit/demo_cubit.dart';
import 'package:app_demo_flutter/presentation/cubit/demo_cubit/demo_state.dart';
import 'package:app_demo_flutter/widget/mgw_appbar.dart';
import 'package:app_demo_flutter/widget/mgw_button.dart';
import 'package:app_demo_flutter/widget/mgw_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_widget/styled_widget.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late DemoCubit _cubit;
  late String title;
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  @override
  void initState() {
    _cubit = BlocProvider.of<DemoCubit>(context);
    title = 'GET DATA FROM API DEMO';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MgwOSAppBar(
          title: AppLocalizations.of(context)!.appName,
          textColor: cyan,
          backgroundColor: white,
          elevation: 0.2),
      body: ValueListenableBuilder<bool>(
        valueListenable: _isLoading,
        builder: (context, value, child){
          return Center(
            child: MgwOSLoading(
              mainWidget: child!,
              isShowLoading: value,
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150.h,
            ),
            Text(title),
            SizedBox(
              height: 150.h,
            ),
            BlocListener<DemoCubit, DemoState>(
              listener: (context, state) {
                _isLoading.value = false;
                state.maybeWhen(
                    orElse: () {},
                    loading: () {
                      _isLoading.value = true;
                    },
                    error: (err) {
                      setState(() {
                        title = err.toString();
                      });
                    },
                    success: () {
                      setState(() {
                        title = 'GET DATA SUCCESS';
                      });
                    });
              },
              child: MgwOSButton(
                width: double.infinity,
                colorBackground: darkBlue,
                onPressed: () {
                  _cubit.getData();
                },
                text: 'DEMO GET DATA',
                titleStyle: ThemeProvider.instance.textStyleMed18
                    .copyWith(color: white),
              ).padding(horizontal: 16.w),
            ),
            SizedBox(height: 50.h)
          ],
        ),
      ),
    );
  }
}
