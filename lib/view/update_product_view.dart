import 'package:flutter/material.dart';
import 'package:product_crud_app/model/product_model.dart';
import 'package:product_crud_app/service/api_service.dart';
import 'product_list_view.dart';

class UpdateProductView extends StatefulWidget {
  final Product product;

  const UpdateProductView({super.key, required this.product});

  @override
  _UpdateProductViewState createState() => _UpdateProductViewState();
}

class _UpdateProductViewState extends State<UpdateProductView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _productNameController;
  late TextEditingController _productCodeController;
  late TextEditingController _imgController;
  late TextEditingController _unitPriceController;
  late TextEditingController _qtyController;
  late TextEditingController _totalPriceController;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _productNameController =
        TextEditingController(text: widget.product.productName);
    _productCodeController =
        TextEditingController(text: widget.product.productCode);
    _imgController = TextEditingController(text: widget.product.img);
    _unitPriceController =
        TextEditingController(text: widget.product.unitPrice);
    _qtyController = TextEditingController(text: widget.product.qty);
    _totalPriceController =
        TextEditingController(text: widget.product.totalPrice);
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productCodeController.dispose();
    _imgController.dispose();
    _unitPriceController.dispose();
    _qtyController.dispose();
    _totalPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _productNameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _productCodeController,
                decoration: const InputDecoration(labelText: 'Product Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _imgController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _unitPriceController,
                keyboardType: TextInputType.number,

                decoration: const InputDecoration(labelText: 'Unit Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a unit price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _qtyController,
                keyboardType: TextInputType.number,

                decoration: const InputDecoration(labelText: 'Quantity'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _totalPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Total Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a total price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Product updatedProduct = Product(
                      id: widget.product.id,
                      productName: _productNameController.text,
                      productCode: _productCodeController.text,
                      img: _imgController.text,
                      unitPrice: _unitPriceController.text,
                      qty: _qtyController.text,
                      totalPrice: _totalPriceController.text,
                      createdDate: widget.product.createdDate,
                    );
                    await _apiService.updateProduct(
                        widget.product.id, updatedProduct);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Product updated')));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductListView()),
                    );
                  }
                },
                child: const Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
