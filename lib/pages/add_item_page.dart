import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exemplo_getx/controllers/shopping_list_controller.dart';

class AddItemPage extends StatelessWidget {
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final bool isEditing;
  final int? index;

  AddItemPage({this.isEditing = false, this.index});

  @override
  Widget build(BuildContext context) {
    final ShoppingListController controller = Get.find();

    if (isEditing && index != null) {
      _itemController.text = controller.shoppingList[index!].name;
      _quantityController.text = controller.shoppingList[index!].quantity.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Item' : 'Adicionar Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _itemController,
              decoration: InputDecoration(
                labelText: 'Nome do Item',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantidade',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_itemController.text.isNotEmpty && _quantityController.text.isNotEmpty) {
                  int quantity = int.parse(_quantityController.text);
                  if (isEditing && index != null) {
                    controller.editItem(index!, _itemController.text, quantity);
                  } else {
                    controller.addItem(_itemController.text, quantity);
                  }
                  Get.back();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                isEditing ? 'Salvar' : 'Adicionar',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}