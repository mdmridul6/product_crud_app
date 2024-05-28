import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:product_crud_app/model/product_model.dart';


class ApiService {
  static const String baseUrl = 'https://crud.teamrabbil.com/api/v1';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/ReadProduct'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> createProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/CreateProduct'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create product');
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/UpdateProduct/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update product');
    }
  }

  Future<void> deleteProduct(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/DeleteProduct/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }
}
