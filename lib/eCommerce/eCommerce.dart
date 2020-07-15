import 'package:foodapp/constants/strings.dart';
import 'package:woocommerce/woocommerce.dart';
import '../constants/strings.dart';

class Ecommerce {
  //woocommerce object
  WooCommerce wooCommerce = WooCommerce(
    baseUrl: 'https://thefoodly.com',
    consumerKey: consumerKey,
    consumerSecret: consumerSecret,
    apiPath: '/wp-json/wc/v3/',
    isDebug: false,
  );
  //get woocommerce products by page and perPage
  Future<List<WooProduct>> getWooProducts(int page, int perPage) async {
    try {
      List<WooProduct> x = await wooCommerce.getProducts(
        page: page,
        perPage: perPage,
      );
      x.forEach((_) {
        print(_.toString());
      });
      return x;
    } catch (e) {
      // print("Error While Getting Products");
      print(e);
      return [];
    }
  }

  Future<List<WooProduct>> getWooProductsByCategoryId(
      String category, int count) async {
    try {
      return await wooCommerce.getProducts(
        perPage: count,
        category: category,
      );
    } catch (e) {
      // print("Error While Getting Products by category");
      return [];
    }
  }

  //get a product category
  Future<List<WooProductCategory>> getWooProductCategory() async {
    try {
      return await wooCommerce.getProductCategories();
    } catch (e) {
      // print("Error While Getting Products Category");
      return [];
    }
  }

  //get Woo Product Variation
  Future<WooProductVariation> getWooProductVariation(
      int productId, variationId) async {
    try {
      return await wooCommerce.getProductVariationById(
          productId: productId, variationId: variationId);
    } catch (e) {
      return null;
    }
  }

  //get all product variations
  Future<List<WooProductVariation>> getWooProductVariations(
      int productId) async {
    try {
      return await wooCommerce.getProductVariations(productId: productId);
    } catch (e) {
      return null;
    }
  }

  //Add to cart and get object
  Future<bool> addToCart(int itemId, int quantity,
      {List<WooProductVariation> variations}) async {
    try {
      // await wooCommerce.addToCart(
      //     itemId: itemId, quantity: quantity, variations: variations);
      return true;
    } catch (e) {
      // print("Error While Adding to cart");
      return false;
    }
  }

  //get all cart items
  Future<List<WooCartItem>> getCartItems() async {
    try {
      return await wooCommerce.getMyCartItems();
    } catch (e) {
      return [];
    }
  }

  //to check whether the item is added to cart or not
  Future<bool> isInCart(WooCartItem wooCartItem) async {
    try {
      List<WooCartItem> items = await wooCommerce.getMyCartItems();
      return items.contains(wooCartItem);
    } catch (e) {
      return false;
    }
  }

  //sign in
  Future<bool> signIn(String username, String password) async {
    try {
      await wooCommerce
          .authenticateViaJWT(username: username, password: password)
          .then((value) {
        print("Sign In successfully");
      });
      return true;
    } catch (e) {
      print("Error while signing in");
      return false;
    }
  }

  //Login - Signs a user in and returns the logged in user's (WooUser object) details.
  Future<bool> loggedInUser(String username, String password) async {
    try {
      await wooCommerce
          .loginCustomer(username: username, password: password)
          .then((value) {
        print("Logged In User got");
      });
      return true;
    } catch (e) {
      print("Error while getting login user");
      return false;
    }
  }
}
