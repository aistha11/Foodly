import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/components/shimmering/myshimmer.dart';
import 'package:foodapp/components/wooProductsByCategory.dart';
import 'package:foodapp/constants/colors.dart';
import 'package:foodapp/constants/icons.dart';
import 'package:foodapp/utilities/utils.dart';
import 'package:woocommerce/woocommerce.dart';

class ProductCategoryDetail extends StatelessWidget {
  final WooProductCategory category;
  ProductCategoryDetail({
    @required this.category,
  });
  @override
  Widget build(BuildContext context) {
    final double radius = 0;
    final double contHeight = 250;
    final CachedNetworkImage _cachedImage = CachedNetworkImage(
      imageUrl: category.image.src,
      placeholder: (_, url) {
        return MyShimmer.shimCont(72, width: 72);
      },
      alignment: Alignment.center,
      fit: BoxFit.scaleDown,
      errorWidget: (_, url, error) {
        return MyShimmer.shimCont(72, width: 72);
      },
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: mainCol,
            pinned: true,
            floating: true,
            leading: IconButton(
                icon: backIcon,
                onPressed: () {
                  Navigator.pop(context);
                }),
            expandedHeight: contHeight,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("${category.name}(${category.count})"),
              background: Container(
                width: Utils.getWidthByPercentage(context, 100),
                height: contHeight,
                decoration: BoxDecoration(
                  color: mainCol,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius),
                  ),
                  child: _cachedImage,
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: WooProductsByCategory(categoryId: category.id.toString(), count: category.count,),
          ),
        ],
      ),
    );
  }
}
