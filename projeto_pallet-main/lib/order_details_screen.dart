import 'package:flutter/material.dart';
import 'package:sistema_cargas/order.dart' as order_model; 

class OrderDetailsScreen extends StatelessWidget {
  final order_model.Order order; 

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Pedido #${order.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome do Cliente: ${order.clientName}'),
            Text('Nome do Motorista: ${order.driverName}'),
            Text('Placa do Veículo: ${order.vehiclePlate}'),
            Text('ID do Romaneio: ${order.shipmentId}'),
            const SizedBox(height: 20),
            const Text('Produtos Selecionados:'),
            Expanded(
              child: ListView.builder(
                itemCount: order.selectedProductIds.length,
                itemBuilder: (context, index) {
        
                  final productId = order.selectedProductIds[index];
                  return FutureBuilder<order_model.Product>(
                    future: DatabaseHelper().getProduct(productId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text('Erro ao carregar produto');
                      } else if (!snapshot.hasData) {
                        return const Text('Produto não encontrado');
                      } else {
                        final product = snapshot.data!;
                        return ListTile(
                          title: Text(product.name),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // ignore: non_constant_identifier_names
  DatabaseHelper() {}
}
