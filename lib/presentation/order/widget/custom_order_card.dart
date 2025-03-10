import 'package:flowery/core/utils/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../core/routes/page_route_name.dart';
import '../../../core/utils/widget/custom_cached_network_image.dart';
import '../../../domain/entities/order/create_order/Product.dart';
import '../../../domain/entities/order/create_order/order_entity.dart';
import '../../../domain/entities/order/create_order/order_item.dart';
import '../../../generated/l10n.dart';

class CustomOrderCard extends StatefulWidget {
  final OrderEntity? order;
  final OrderItem? orderItem;
  final Product? product;

  const CustomOrderCard({
    super.key,
    required this.orderItem,
    required this.product,
    required this.order,
  });

  @override
  State<CustomOrderCard> createState() => _CustomOrderCardState();
}

class _CustomOrderCardState extends State<CustomOrderCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return InkWell(
        onTap: () {
      if (widget.product?.id != null) {
        Navigator.pushNamed(
          context,
          PageRouteName.productDetails,
          arguments: widget.product!.id,
        );
      }
    },
    child:  Padding(
      padding: EdgeInsets.all(12.0.sp),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColors.kGray,
          ),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomCachedNetworkImage(
                    imageUrl: widget.product?.imgCover ?? "",
                    height: 140.h,
                    width: 120.h,
                    shimmerRadiusValue: 8.r,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.product?.title ?? 'No Title',
                          style: AppFonts.font12BlackWeight400,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  4.verticalSpace,
                  Text(
                    "${local.egp} ${widget.product?.price}",
                    style: AppFonts.font12BlackWeight400
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  6.verticalSpace,
                  Row(
                    children: [
                      Text(
                        "${local.orderNumber} \n#${widget.order?.id ?? ""}",
                        style: AppFonts.font12BlackWeight400
                            .copyWith(color: AppColors.kGray),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      width: double.infinity,
                      height: 35.h,
                      color: AppColors.kPink,
                      child: Text(
                        widget.order?.isDelivered ?? false
                            ? "reorder"
                            : local.trackOrder,
                        style: AppFonts.font16WhiteWeight500
                            .copyWith(fontSize: 13.sp),
                      ),
                      onPressed: () {
                        if (widget.order?.isDelivered ?? false) {
                        } else {
                          Navigator.pushNamed(
                            context,
                            PageRouteName.trackOrderScreen,
                            arguments: widget.order?.id,
                          );
                       print(widget.order?.id);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),)
    );
  }
}
