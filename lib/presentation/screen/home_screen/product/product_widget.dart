import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/gen/assets.gen.dart';
import 'package:app_demo_flutter/presentation/cubit/product_cubit/get_product_cubit.dart';
import 'package:app_demo_flutter/presentation/cubit/product_cubit/get_product_state.dart';
import 'package:app_demo_flutter/presentation/screen/home_screen/product/item_product_widget.dart';
import 'package:app_demo_flutter/widget/mgw_appbar.dart';
import 'package:app_demo_flutter/widget/mgw_loading.dart';
import 'package:app_demo_flutter/widget/mgw_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:styled_widget/styled_widget.dart';

class ProductPageWidget extends StatefulWidget {
  const ProductPageWidget({Key? key}) : super(key: key);

  @override
  State<ProductPageWidget> createState() => _ProductPageWidgetState();
}

class _ProductPageWidgetState extends State<ProductPageWidget> {
  late TextEditingController _searchController;
  late GetProductCubit _getProductCubit;
  final scrollController = ScrollController();
  int listCount = 0;
  int currentPage = 1;
  int maxPage = 5;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _getProductCubit = BlocProvider.of<GetProductCubit>(context);
    _getProductCubit.getData(currentPage);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (currentPage < maxPage) {
          currentPage++;
          _getProductCubit.getData(currentPage);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: white,
        appBar: MgwOSAppBar(
            widgetRight: GestureDetector(
                child: Icon(
              Icons.add,
              size: 30.w,
              color: white,
            )).padding(right: 8.w),
            title: 'Product',
            textColor: white,
            backgroundColor: darkBlue,
            elevation: 0),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearch(),
            Expanded(child: _buildListProduct()),
          ],
        ));
  }

  Widget _buildSearch() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      width: double.infinity,
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
            contentPadding: 10.r,
          ),
          SizedBox(
            height: 15.h,
          )
        ],
      ),
    );
  }

  Widget _buildListProduct() {
    return BlocConsumer<GetProductCubit, GetProductState>(
        buildWhen: (previous, current) {
      if (currentPage != 1) {
        return false;
      }
      return true;
    }, listener: (context, state) {
      state.maybeWhen(
          orElse: () {},
          success: (value) {
            setState(() {
              listCount = value as int;
            });
          });
    }, builder: (context, state) {
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
        return _buildListItem();
      });
    });
  }

  Widget _buildListItem() {
    return RefreshIndicator(
      color: Colors.transparent,
      backgroundColor: Colors.transparent,
      onRefresh: () async {
        currentPage = 1;
        listCount = 0;
        _getProductCubit.getData(currentPage);
      },
      child: ListView.separated(
          controller: scrollController,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == listCount) {
              if (currentPage == maxPage) {
                return const SizedBox.shrink();
              }
              return const CupertinoActivityIndicator();
            }
            return ItemProductWidget(index: index);
          },
          separatorBuilder: (context, index) {
            return const SizedBox.shrink();
          },
          itemCount: listCount + 1),
    );
  }
}
