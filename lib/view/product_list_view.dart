import 'package:flutter/material.dart';
import 'package:product_crud_app/model/product_model.dart';
import 'package:product_crud_app/service/api_service.dart';
import 'add_product_view.dart';
import 'update_product_view.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    List<Product> products = await _apiService.fetchProducts();
    setState(() {
      _products = products;
    });
  }

  Future<void> _deleteProduct(String productId, context) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmDelete) {
      await _apiService.deleteProduct(productId);
      await _fetchProducts(); // Refresh products after deletion
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Product deleted')));
    }
  }

  Future<void> _refreshProducts() async {
    await _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: ListView.builder(
          itemCount: _products.length,
          itemBuilder: (context, index) {
            Product product = _products[index];
            return ListTile(
              leading: product.img.isNotEmpty
                  ? SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        product.img,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox(
                      width: 100,
                      height: 100,
                      child: Placeholder(),
                    ),
              title: Text(product.productName),
              subtitle: Text(
                  'Price: ${product.unitPrice}, Qty: ${product.qty}, Total: ${product.totalPrice}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UpdateProductView(product: product),
                        ),
                      ).then((value) {
                        if (value == true) {
                          _fetchProducts();
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await _deleteProduct(product.id, context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Product deleted')));
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProductView(),
            ),
          ).then((value) {
            if (value == true) {
              _fetchProducts();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
