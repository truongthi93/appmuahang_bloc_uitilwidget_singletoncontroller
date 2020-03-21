import 'package:appmuahang/model/product.dart';
import 'package:appmuahang/service/services.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc implements Bloc {
  final _selectedProductsController = BehaviorSubject<List<Product>>.seeded([]);
  ValueStream<List<Product>> get selectedProducts => _selectedProductsController.stream;

  final _allProductsController = BehaviorSubject<List<Product>>.seeded([]); // lay tac ca cac lan ban trước do
  ValueStream<List<Product>> get allProducts => _allProductsController.stream;


  Future<void>  checkAddOrRemove(Product product) async {
    if (selectedProducts.value.contains(product)) {
              selectedProducts.value.remove(product);
        } else {

      selectedProducts.value.add(product);
    }
    _selectedProductsController.add(selectedProducts.value);
  }

  Future<void> getAllProduct() async {
    var list = await ServiceProduct().getAllProducts();
    allProducts.value.addAll(list);
    _allProductsController.add(list);
  }

  deleteCart() {
    selectedProducts.value.clear();
    _selectedProductsController.add(selectedProducts.value);
  }

  @override
  void dispose() async {
    await _selectedProductsController.close();
    await _allProductsController.close();
  }
}
