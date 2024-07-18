import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exemplo_getx/controllers/shopping_list_controller.dart';
import 'package:exemplo_getx/pages/add_item_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ShoppingListController controller = Get.put(ShoppingListController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: controller.shoppingList.length,
                itemBuilder: (context, index) {
                  final item = controller.shoppingList[index];
                  return Card(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      title: Text(
                        "${item.name} - Quantidade: ${item.quantity}",
                        style: TextStyle(
                          decoration: item.isBought
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: item.isBought,
                            onChanged: (value) {
                              controller.toggleBoughtStatus(index);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.teal),
                            onPressed: () {
                              Get.to(AddItemPage(isEditing: true, index: index));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.teal),
                            onPressed: () {
                              // Mostrar diálogo de confirmação antes de deletar
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Theme(
                                    data: ThemeData(
                                      dialogBackgroundColor: Colors.teal[100],
                                    ),
                                    child: AlertDialog(
                                      title: Text('Confirmar exclusão'),
                                      content: Text('Tem certeza que deseja excluir este item?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Cancelar',
                                            style: TextStyle(color: Colors.teal),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            controller.removeItem(index);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Confirmar',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Get.to(AddItemPage());
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 15),
                ),
              ),
              child: Text(
                'Adicionar Item',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
