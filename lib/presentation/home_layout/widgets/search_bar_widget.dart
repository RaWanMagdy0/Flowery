import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routes/page_route_name.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';
import '../../../generated/l10n.dart';

class SearchBarWidget extends StatefulWidget {
  final double? maxHeight;
  final bool showSearchButton;
  final VoidCallback? onTap;

  const SearchBarWidget({
    super.key,
    this.maxHeight,
    this.showSearchButton = true,
    this.onTap,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _showClearButton = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _handleSearch() {
    if (_searchController.text.trim().isNotEmpty) {
      // Navigate to search screen with query
      Navigator.pushNamed(
        context,
        PageRouteName.search,
        arguments: _searchController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return Flexible(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: widget.maxHeight ?? 36.h,
          maxWidth: 300.w,
        ),
        child: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          onTap: widget.onTap,
          decoration: InputDecoration(
            hintText: local.searchArabic,
            hintStyle: AppFonts.font14LightGreyWeight500,
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.kGray,
              size: 20.sp,
            ),
            suffixIcon: _showClearButton && widget.showSearchButton
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: AppColors.kGray,
                          size: 20.sp,
                        ),
                        onPressed: () {
                          _searchController.clear();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: AppColors.kPink,
                          size: 20.sp,
                        ),
                        onPressed: _handleSearch,
                      ),
                    ],
                  )
                : null,
            constraints: BoxConstraints(
              maxHeight: widget.maxHeight ?? 36.h,
              maxWidth: 300.w,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 6.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: AppColors.kLightGrey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: AppColors.kLightGrey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: AppColors.kPink,
              ),
            ),
          ),
          onSubmitted: (_) => _handleSearch(),
        ),
      ),
    );
  }
}
