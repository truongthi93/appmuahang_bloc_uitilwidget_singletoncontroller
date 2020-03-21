import 'dart:async';
import 'package:appmuahang/model/product.dart';

class ServiceProduct {
  Future<List<Product>> getAllProducts() async {
  return Future.delayed(const Duration(seconds: 2), () {
      return [
        Product("iPhone 11 Pro Max", 1099.0, "images/ip11pm.png"),
        Product("iPhone 11", 999.0, "images/ip11.png"),
        Product("iPhone XS Max", 899.0, "images/ipxsm.png"),
        Product("iPhone XR", 799.0, "images/ipxr.png"),
        Product("iPad Air ", 699.0, "images/ipadair.png"),
        Product("iPad 11 2019", 599.0, "images/ipad11.png"),
        Product("iPhone 8 Plus", 99.0, "images/ip8p.png"),
        Product("iPhone 6 Plus", 89.0, "images/ip6p.png"),
        Product("iPhone 5S", 79.0, "images/ip5s.png"),
        Product("iPhone 4S", 69.0, "images/ip4s.png"),
        Product("iPhone 3GS", 59.0, "images/ip3gs.png"),
        Product("iPhone 2G", 49.0, "images/ip2g.png"),
        Product("Apple Watch", 39.0, "images/iwatch.png"),
        Product("Apple Pencil", 29.0, "images/pencil.png"),
        Product("AirPod", 129.0, "images/airpod.png"),
        Product("Mac Mini", 139.0, "images/macmini.png"),
        Product("Apple Music", 149.0, "images/music.png"),
        Product("iMac 4K", 1299.0, "images/imac.png"),
        Product("Macbook Pro 2019", 1399.0, "images/macpro.png"),
        Product("Apple TV", 1499.0, "images/tivi.png")
      ];
    });
  }
}
