// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:sistema_cargas/OrderSummaryScreen.dart';
import 'package:sistema_cargas/product.dart';
import 'conexao/databasehelper.dart';

class ShipmentFormScreen extends StatefulWidget {
  final String driverName;
  final String vehiclePlate;
  final int driverId;
  final String shipmentId;

  const ShipmentFormScreen({
    Key? key,
    required this.driverName,
    required this.vehiclePlate,
    required this.driverId,
    required this.shipmentId,
  }) : super(key: key); 

  @override
  _ShipmentFormScreenState createState() => _ShipmentFormScreenState();
}

class _ShipmentFormScreenState extends State<ShipmentFormScreen> {
  final TextEditingController shipmentIdController = TextEditingController();
  final TextEditingController clientNameController = TextEditingController();
  List<Product> selectedProducts = [];
  List<Product> allProducts = [];

  @override
  void initState() {
    super.initState();
    _fetchAllProducts();
  }

  Future<void> _fetchAllProducts() async {
    try {
      List<Product> products = await DatabaseHelper().getAllProducts();
      setState(() {
        allProducts = products;
      });
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Romaneio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: shipmentIdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ID do Romaneio',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: clientNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome do Cliente',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Selecione os Produtos:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              if (allProducts.isNotEmpty)
                Column(
                  children: allProducts.map((product) {
                    return CheckboxListTile(
                      title: Text(product.name),
                      value: selectedProducts.contains(product),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedProducts.add(product);
                          } else {
                            selectedProducts.remove(product);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderSummaryScreen(
                        driverName: widget.driverName,
                        vehiclePlate: widget.vehiclePlate,
                        shipmentId: shipmentIdController.text,
                        clientName: clientNameController.text,
                        selectedProducts: selectedProducts,
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text('Próximo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
