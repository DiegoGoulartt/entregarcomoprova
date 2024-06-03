import 'package:flutter/material.dart';
import 'package:sistema_cargas/product.dart';
import 'package:sistema_cargas/selected_products.dart';

class ProductSelectionScreen extends StatefulWidget {
  final String driverName;
  final String vehiclePlate;
  final String shipmentId;
  final String clientName;

  // ignore: use_key_in_widget_constructors
  const ProductSelectionScreen({
    Key? key,
    required this.driverName,
    required this.vehiclePlate,
    required this.shipmentId,
    required this.clientName,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProductSelectionScreenState createState() => _ProductSelectionScreenState();
}

class _ProductSelectionScreenState extends State<ProductSelectionScreen> {
  final List<Product> products = [
    // Lista completa de produtos
  ];

  @override
  void initState() {
    super.initState();
    products.addAll([
      Product(id: 1, name: 'UNIFRIOS LEITE FERM. BAUNILHA GARRAFA 60X80G', description: ''),
      Product(id: 2, name: 'UNIFRIOS LEITE FERM. BAUNILHA GARRAFA 24X170G', description: ''),
      Product(id: 3, name: 'UNIFRIOS LEITE FERM. C/SUCO UVA GARRAFA 24X170G', description: ''),
      Product(id: 4, name: 'UNIFRIOS IOG. MORANGO GARRAFA 24X160G', description: ''),
      Product(id: 5, name: 'UNIFRIOS IOG. COCO GARRAFA 24X160G', description: ''),
      Product(id: 6, name: 'UNIFRIOS IOG. FRUTAS VERMELHAS GARRAFA 24X160G', description: ''),
      Product(id: 7, name: 'UNIFRIOS IOG. SALADA DE FRUTAS GARRAFA 24X160G', description: ''),
      Product(id: 8, name: 'UNIFRIOS IOG. MORANGO GARRAFA 12X850G', description: ''),
      Product(id: 9, name: 'UNIFRIOS IOG. COCO GARRAFA 12X850G', description: ''),
      Product(id: 10, name: 'UNIFRIOS IOG. FRUTAS VERMELHAS GARRAFA 12X850G', description: ''),
      Product(id: 11, name: 'UNIFRIOS IOG. SALADA DE FRUTAS GARRAFA 12X850G', description: ''),
      Product(id: 12, name: 'UNIFRIOS LEITE FERM. BAUNILHA GARRAFA 12X850G', description: ''),
      Product(id: 13, name: 'UNIFRIOS IOG. C/CONFEITOS CHOCOLATE COPO 24X115G', description: ''),
      Product(id: 14, name: 'UNIFRIOS IOG. BI-CAM. C/GEL.MORAN COPO 24X120G', description: ''),
      Product(id: 15, name: 'UNIFRIOS B. LACTEA MOR/FR. TROPICAIS BANDEJA 12X480G', description: ''),
      Product(id: 16, name: 'UNIFRIOS B. LACTEA MORANGO BANDEJA 12X480G', description: ''),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleção de Produtos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: products.map((product) {
                    return CheckboxListTile(
                      title: Text(product.name),
                      value: product.selected,
                      onChanged: (value) {
                        setState(() {
                          product.selected = value ?? false;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final selectedProducts = products.where((product) => product.selected).toList();
                final driverName = widget.driverName;
                final vehiclePlate = widget.vehiclePlate;
                final shipmentId = widget.shipmentId;
                final clientName = widget.clientName;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectedProductsScreen(
                      selectedProducts: selectedProducts,
                      driverName: driverName,
                      vehiclePlate: vehiclePlate,
                      shipmentId: shipmentId,
                      clientName: clientName,
                    ),
                  ),
                );
              },
              child: const Text('Confirmar Seleção'),
            ),
          ],
        ),
      ),
    );
  }
}
