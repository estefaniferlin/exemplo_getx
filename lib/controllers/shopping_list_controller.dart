import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ShoppingItem {
  String name;
  int quantity;
  bool isBought;

  ShoppingItem(this.name, {this.quantity = 1, this.isBought = false});
}

class ShoppingListController extends GetxController { // Lista de compras gerenc de forma reativa
  final _box = GetStorage(); // Persistência dos dados localmente
  var shoppingList = <ShoppingItem>[].obs; // Observável

  @override
  void onInit() {
    super.onInit();
    // Carrega os dados salvos ao inicializar o controlador
    List<dynamic>? storedList = _box.read('shoppingList');
    if (storedList != null) {
      shoppingList.assignAll(
        storedList.map((item) => ShoppingItem(item['name'], quantity: item['quantity'], isBought: item['isBought'] ?? false)).toList(),
      );
    }
  }

  void addItem(String name, int quantity) {
    shoppingList.add(ShoppingItem(name, quantity: quantity));
    _saveList(); // Salva a lista após adicionar um item
  }

  void removeItem(int index) {
    shoppingList.removeAt(index);
    _saveList(); // Salva a lista após remover um item
  }

  void toggleBoughtStatus(int index) {
    shoppingList[index].isBought = !shoppingList[index].isBought;
    shoppingList.refresh(); // notifica getx da alteração
    _saveList(); // Salva a lista após alterar o estado do item
  }

  void editItem(int index, String newName, int newQuantity) {
    shoppingList[index].name = newName;
    shoppingList[index].quantity = newQuantity;
    _saveList(); // Salva a lista após editar um item
  }

  void _saveList() {
    _box.write('shoppingList', shoppingList.toList());
  }
}