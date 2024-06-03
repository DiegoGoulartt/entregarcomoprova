// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'product.dart';
import 'conexao/databasehelper.dart';

class SuccessScreen extends StatefulWidget {
  final String driverName;
  final String vehiclePlate;
  final String shipmentId;
  final String clientName;
  final List<int> selectedProductIds;

  const SuccessScreen({
    Key? key, 
    required this.driverName,
    required this.vehiclePlate,
    required this.shipmentId,
    required this.clientName,
    required this.selectedProductIds,
  }) : super(key: key);

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  late List<Product> _selectedProducts = [];

  @override
  void initState() {
    super.initState();
    _loadSelectedProducts();
  }

  Future<void> _loadSelectedProducts() async {
    List<Product> products = [];
    for (int productId in widget.selectedProductIds) {
      try {
        Product product = await DatabaseHelper().getProduct(productId);
        products.add(product);
      } catch (e) {
      }
    }
    setState(() {
      _selectedProducts = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finalizar Pedido'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome do Motorista: ${widget.driverName}'),
            Text('Placa do Veículo: ${widget.vehiclePlate}'),
            Text('ID do Romaneio: ${widget.shipmentId}'),
            Text('Nome do Cliente: ${widget.clientName}'),
            const SizedBox(height: 20),
            const Text('Produtos Selecionados:'),
            Expanded(
              child: ListView.builder(
                itemCount: _selectedProducts.length,
                itemBuilder: (context, index) {
                  final Product product = _selectedProducts[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text(product.description ?? 'Sem descrição'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteProduct(product.id!),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListScreen(selectedProductIds: widget.selectedProductIds),
                    ),
                  );
                },
                child: const Text('Ver Lista de Produtos'),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 30),
                SizedBox(width: 10),
                Text(
                  'Finalizado com sucesso!',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _deleteProduct(int productId) {
    setState(() {
      _selectedProducts.removeWhere((product) => product.id == productId);
    });
  }
  
  ProductListScreen({required List<int> selectedProductIds}) {}
}
