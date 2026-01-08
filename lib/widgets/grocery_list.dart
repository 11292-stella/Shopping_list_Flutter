import 'package:flutter/material.dart';

import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

/// Schermata principale che mostra la lista della spesa.
/// È uno StatefulWidget perché la lista cambia nel tempo
/// (aggiunta e rimozione di elementi).
class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  /// Lista interna che contiene tutti gli elementi della spesa.
  /// È privata (underscore) perché deve essere gestita solo da questa classe.
  final List<GroceryItem> _groceryItems = [];

  /// Funzione che apre la schermata per aggiungere un nuovo item.
  /// È async perché Navigator.push ritorna un Future.
  ///
  /// Navigator.push<T>:
  /// - apre una nuova pagina
  /// - quando quella pagina chiama Navigator.pop(T value)
  ///   il Future si completa e ritorna quel valore.
  void _addItem() async {
    final newItem = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => const NewItem()));

    /// Se l’utente torna indietro senza aggiungere nulla,
    /// newItem sarà null → non facciamo niente.
    if (newItem == null) {
      return;
    }

    /// Se invece abbiamo ricevuto un GroceryItem,
    /// lo aggiungiamo alla lista e aggiorniamo la UI.
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  /// Funzione per rimuovere un elemento dalla lista.
  /// Viene chiamata quando l’utente fa swipe o tap su un item.
  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          /// Pulsante "+" nella AppBar per aggiungere un nuovo item.
          IconButton(onPressed: _addItem, icon: const Icon(Icons.add)),
        ],
      ),

      /// Corpo della schermata: lista degli elementi.
      body: ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) {
          final item = _groceryItems[index];

          return Dismissible(
            /// Ogni elemento deve avere una key unica per permettere
            /// a Flutter di animare correttamente la rimozione.
            key: ValueKey(item.id),

            /// Direzione dello swipe per eliminare
            direction: DismissDirection.endToStart,

            /// Quando l’utente completa lo swipe → rimuoviamo l’item
            onDismissed: (direction) {
              _removeItem(item);
            },

            /// Sfondo rosso che appare durante lo swipe
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),

            /// Contenuto visibile dell’item
            child: ListTile(
              title: Text(item.name),
              leading: Container(
                width: 24,
                height: 24,
                color: item.category.color,
              ),
              trailing: Text(item.quantity.toString()),
            ),
          );
        },
      ),
    );
  }
}
