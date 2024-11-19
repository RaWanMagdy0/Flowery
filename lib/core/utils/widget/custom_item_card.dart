import 'package:flutter/material.dart';

class FlowerCard extends StatelessWidget {
  final String? title;
  final String? price;
  final String? originalPrice;
  final String? discount;
  final String? imageUrl;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? priceColor;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? titleSize;
  final double? priceSize;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final IconData? buttonIcon;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final Color? iconColor;
  final String? descount;
  final Color? descountColor;

  const FlowerCard({
    super.key,
    this.title,
    this.price,
    this.originalPrice,
    this.discount,
    this.imageUrl,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black54,
    this.priceColor = Colors.black87,
    this.onTap,
    this.width = 150,
    this.height = 200,
    this.padding = const EdgeInsets.all(8.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.titleSize = 16.0,
    this.priceSize = 14.0,
    this.buttonColor = Colors.pink,
    this.buttonTextColor = Colors.white,
    this.buttonIcon = Icons.shopping_cart,
    this.iconColor = Colors.white,
    this.buttonText = "Add to Cart",
    this.descount,
    this.descountColor,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.5,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: imageUrl != null
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              imageUrl!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          )
                              : const Icon(Icons.local_florist, size: 40),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      title ?? 'Flower',
                      style: TextStyle(
                        color: textColor,
                        fontSize: titleSize,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      price ?? 'EGP 0',
                      style: TextStyle(
                        color: priceColor,
                        fontSize: priceSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (originalPrice != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        originalPrice!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '$descount%',
                        style: TextStyle(color: descountColor),
                      ),
                    ],
                  ],
                ),
                const Spacer(), // This will push the button to the bottom
                SizedBox(
                  width: double.infinity, // Make button full width
                  child: ElevatedButton.icon(
                    onPressed: onButtonPressed ?? () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: buttonTextColor,
                      iconColor: iconColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    icon: Icon(buttonIcon, size: 18),
                    label: Text(
                      buttonText ?? "",
                      style: TextStyle(
                        color: buttonTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}