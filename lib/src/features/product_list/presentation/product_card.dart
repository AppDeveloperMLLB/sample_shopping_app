import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_shopping_app/src/common_widgets/image_from_resource.dart';
import 'package:sample_shopping_app/src/constants/app_sizes.dart';
import 'package:sample_shopping_app/src/features/product_list/presentation/favorite_icon.dart';
import '../domain/model/product.dart';

class ProductCard extends StatelessWidget {
  final void Function(Product product) onTapped;
  final Product product;
  const ProductCard({
    Key? key,
    required this.product,
    required this.onTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () => onTapped(product),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                offset: const Offset(4, 4),
                blurRadius: 16,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 2,
                      child: Image.asset(
                        product.imageResource,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      // TODO: Implements background
                      // color: HotelAppTheme.buildLightTheme()
                      //     .backgroundColor,
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, top: 8, bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    product.name,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "hotelData!.subTxt",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Colors.grey.withOpacity(0.8)),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      children: <Widget>[
                                        // RatingBar(
                                        //   initialRating:
                                        //   hotelData!.rating,
                                        //   direction: Axis.horizontal,
                                        //   allowHalfRating: true,
                                        //   itemCount: 5,
                                        //   itemSize: 24,
                                        //   ratingWidget: RatingWidget(
                                        //     full: Icon(
                                        //       Icons.star_rate_rounded,
                                        //       color: HotelAppTheme
                                        //           .buildLightTheme()
                                        //           .primaryColor,
                                        //     ),
                                        //     half: Icon(
                                        //       Icons.star_half_rounded,
                                        //       color: HotelAppTheme
                                        //           .buildLightTheme()
                                        //           .primaryColor,
                                        //     ),
                                        //     empty: Icon(
                                        //       Icons
                                        //           .star_border_rounded,
                                        //       color: HotelAppTheme
                                        //           .buildLightTheme()
                                        //           .primaryColor,
                                        //     ),
                                        //   ),
                                        //   itemPadding:
                                        //   EdgeInsets.zero,
                                        //   onRatingUpdate: (rating) {
                                        //     print(rating);
                                        //   },
                                        // ),
                                        // Text(
                                        //   ' ${hotelData!.reviews} Reviews',
                                        //   style: TextStyle(
                                        //       fontSize: 14,
                                        //       color: Colors.grey
                                        //           .withOpacity(0.8)),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16, top: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  '${product.price}円',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Positioned(
                  top: 8,
                  right: 8,
                  child: FavoriteIcon(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
