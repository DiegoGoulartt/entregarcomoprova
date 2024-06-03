import 'package:flutter/material.dart';
import 'product.dart';
import 'conexao/databasehelper.dart';

class OrderSummaryScreen extends StatelessWidget {
  final String driverName;
  final String vehiclePlate;
  final String shipmentId;
  final String clientName;
  final List<Product> selectedProducts;

  const OrderSummaryScreen({
    Key? key, // Adicionado
    required this.driverName,
    required this.vehiclePlate,
    required this.shipmentId,
    required this.clientName,
    required this.selectedProducts,
  }) : super(key: key); // Adicionado

  Future<void> _saveOrder() async {
    final db = DatabaseHelper();
    final selectedProductIds = selectedProducts.map((p) => p.id).join(',');

    await db.database.then((db) {
      db.insert('orders', {
        'driverName': driverName,
        'vehiclePlate': vehiclePlate,
        'shipmentId': shipmentId,
        'clientName': clientName,
        'selectedProductIds': selectedProductIds,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo do Pedido'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome do Motorista: $driverName'),
            Text('Placa do Veículo: $vehiclePlate'),
            Text('ID do Embarque: $shipmentId'),
            Text('Nome do Cliente: $clientName'),
            const SizedBox(height: 20),
            const Text(
              'Produtos Selecionados:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (selectedProducts.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: selectedProducts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(selectedProducts[index].name),
                    );
                  },
                ),
              ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _saveOrder();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Pedido Salvo'),
                      content: const Text('O pedido foi salvo com sucesso!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text('Salvar Pedido'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
