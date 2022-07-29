import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/constant/key_utils.dart';
import 'package:app_demo_flutter/gen/assets.gen.dart';
import 'package:app_demo_flutter/presentation/cubit/product_cubit/get_product_cubit.dart';
import 'package:app_demo_flutter/presentation/cubit/product_cubit/get_product_state.dart';
import 'package:app_demo_flutter/presentation/screen/product_screen/item_product_widget.dart';
import 'package:app_demo_flutter/widget/base/base_state.dart';
import 'package:app_demo_flutter/widget/mgw_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                            Expanded(child: _buildTextFieldSearch()),
                          ]),
                    ),
                    SizedBox(width: 16.w),
                    // Visibility(
                    //     visible: listCount == 0, child: _buildEmptyItem()),
                    Expanded(child: _buildListSearch())
                  ],
                ),
              )),
        ),
      ),
    );
  }

  late GetProductCubit _getProductCubit;
  final scrollController = ScrollController();
  int listCount = 0;
  int currentPage = 1;
  int maxPage = 5;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getProductCubit = BlocProvider.of<GetProductCubit>(context);
    // _getProductCubit.getData(currentPage);
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
  void dispose() {
    scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildTextFieldSearch() {
    return TextFormField(
      controller: _searchController,
      onEditingComplete: (() {
        FocusScope.of(context).unfocus();
        _getProductCubit.getData(currentPage);
      }),
      style: ThemeProvider.instance.textStyleBold14.copyWith(color: darkBlue),
      decoration: InputDecoration(
          hintText: 'Tìm kiếm sản phẩm',
          border: InputBorder.none,
          hintStyle: ThemeProvider.instance.textStyleMed14),
    );
  }

  _buildListSearch() {
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
        return listCount != 0 ? _buildListItem() : _buildEmptyItem();
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

  Widget _buildEmptyItem() {
    return const Center(
      child: Text('Không tìm thấy dữ liệu nào !'),
    );
  }
}
