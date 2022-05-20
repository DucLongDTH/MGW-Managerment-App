import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/gen/assets.gen.dart';
import 'package:app_demo_flutter/presentation/cubit/product_cubit/get_product_cubit.dart';
import 'package:app_demo_flutter/presentation/cubit/product_cubit/get_product_state.dart';
import 'package:app_demo_flutter/widget/mgw_appbar.dart';
import 'package:app_demo_flutter/widget/mgw_loading.dart';
import 'package:app_demo_flutter/widget/mgw_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_demo_flutter/di/app_di.dart' as di;

class ProductPageWidget extends StatefulWidget {
  const ProductPageWidget({Key? key}) : super(key: key);

  @override
  State<ProductPageWidget> createState() => _ProductPageWidgetState();
}

class _ProductPageWidgetState extends State<ProductPageWidget> {
  late TextEditingController _searchController;
  late GetProductCubit _getProductCubit;
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _getProductCubit = BlocProvider.of<GetProductCubit>(context);
    _getProductCubit.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: white,
        appBar: const MgwOSAppBar(
            title: 'Product',
            textColor: white,
            backgroundColor: darkBlue,
            elevation: 0),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildSearch(), _buildListProduct()],
          ),
        ));
  }

  Widget _buildSearch() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      width: double.infinity,
      height: 80.h,
      color: darkBlue,
      child: Column(
        children: [
          MgwOSTextField(
            heightTextField: 50.h,
            inputFieldKey: const Key('txtSearchProduct'),
            title: 'Search Product',
            keyboardType: TextInputType.emailAddress,
            controller: _searchController,
            widgetLeft: SvgPicture.asset(
              Assets.icons.icSearch,
              width: 21.w,
              height: 21.h,
              color: greyIcon,
            ),
            onChange: (value) {},
            onSaved: (value) {},
          ),
          SizedBox(
            height: 30.h,
          )
        ],
      ),
    );
  }

  Widget _buildListProduct() {
    return BlocConsumer<GetProductCubit, GetProductState>(
        listener: (context, state) {
          debugPrint('state: $state');
        },
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return const SizedBox();
          }, loading: () {
            return Center(
              child: MgwOSLoading(
                mainWidget: const SizedBox(),
                isShowLoading: state == const GetProductState.loading(),
              ),
            );
          }, success: (value) {
            debugPrint('success');
            return Container(
              height: 200.h,
              color: red,
            );
          });
        }
        );
  }
}
