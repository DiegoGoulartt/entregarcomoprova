import 'package:flutter/material.dart';
import 'package:sistema_cargas/product.dart';

class SelectedProductsScreen extends StatelessWidget {
  final List<Product> selectedProducts;
  final String driverName;
  final String vehiclePlate;
  final String shipmentId;
  final String clientName;

  const SelectedProductsScreen({
    super.key,
    required this.selectedProducts,
    required this.driverName,
    required this.vehiclePlate,
    required this.shipmentId,
    required this.clientName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos Selecionados'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome do Motorista: $driverName',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Placa do Veículo: $vehiclePlate',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'ID do Romaneio: $shipmentId',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Nome do Cliente: $clientName',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Produtos Selecionados:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: selectedProducts.length,
                itemBuilder: (context, index) {
                  final product = selectedProducts[index];
                  return ListTile(
                    title: Text(product.name),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}