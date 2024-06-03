import 'package:flutter/material.dart';
import 'package:sistema_cargas/order_details_screen.dart' as order_details_screen;
import 'package:sistema_cargas/shipment_form_screen.dart';
import 'conexao/databasehelper.dart';
import 'package:sqflite/sqflite.dart';
import 'order.dart' as order_model;

class OrderListScreen extends StatefulWidget {
  final List<int> selectedProducts;

  const OrderListScreen({super.key, required this.selectedProducts});

  @override
  // ignore: library_private_types_in_public_api
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  late List<order_model.Order> orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> results = await db.query('orders');

    setState(() {
      orders = results.map((orderMap) => order_model.Order.fromMap(orderMap)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pedidos'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return ListTile(
            title: Text('Pedido #${order.id}'),
            subtitle: Text('Cliente: ${order.clientName}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => order_details_screen.OrderDetailsScreen(order: order),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ShipmentFormScreen(driverId: 0, driverName: '', vehiclePlate: '', shipmentId: '',), 
            ),
          ).then((value) => _fetchOrders()); 
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
