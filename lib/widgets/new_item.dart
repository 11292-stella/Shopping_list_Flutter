import 'package:flutter/material.dart';

import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';

/// Schermata che permette all’utente di aggiungere un nuovo elemento alla lista.
/// Usa un Form per gestire input, validazione e salvataggio dei dati.
class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  /// GlobalKey serve per ottenere un riferimento allo stato del Form.
  /// Con questa chiave possiamo:
  /// - validare tutti i campi insieme → formKey.currentState!.validate()
  /// - salvare tutti i campi insieme → formKey.currentState!.save()
  final _formKey = GlobalKey<FormState>();

  /// Variabili che conterranno i valori inseriti dall’utente.
  /// Verranno riempite dentro `onSaved` dei TextFormField.
  var _enteredName = '';
  var _enteredQuantity = 1;

  /// Categoria selezionata di default.
  var _selectedCategory = categories[Categories.vegetables]!;

  /// Funzione chiamata quando l’utente preme "Add Item".
  /// 1. Valida il form
  /// 2. Se valido, salva i valori
  /// 3. Ritorna un GroceryItem alla schermata precedente tramite Navigator.pop
  void _saveItem() {
    // validate() esegue tutti i validator dei campi del Form.
    // Se uno restituisce una stringa → errore → validate() ritorna false.
    if (_formKey.currentState!.validate()) {
      // save() richiama tutti gli onSaved dei campi.
      _formKey.currentState!.save();

      // Navigator.pop ritorna un valore alla schermata precedente.
      // Qui ritorniamo un GroceryItem costruito con i dati del form.
      Navigator.of(context).pop(
        GroceryItem(
          id: DateTime.now().toString(),
          name: _enteredName,
          quantity: _enteredQuantity,
          category: _selectedCategory,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a new item')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          /// Colleghiamo il Form alla GlobalKey per poterlo validare e salvare.
          key: _formKey,
          child: Column(
            children: [
              /// Campo testo per il nome dell’item.
              /// TextFormField è preferibile a TextField quando si usa un Form
              /// perché supporta validator e onSaved.
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Name')),

                /// VALIDAZIONE DEL CAMPO
                /// Se ritorni una stringa → errore
                /// Se ritorni null → valido
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 1 and 50 characters.';
                  }
                  return null; // valido
                },

                /// SALVATAGGIO DEL VALORE
                /// Viene chiamato solo se validate() è andato a buon fine.
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// Campo quantità
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: _enteredQuantity.toString(),

                      /// VALIDAZIONE NUMERICA
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Must be a valid, positive number.';
                        }
                        return null;
                      },

                      /// SALVATAGGIO DEL VALORE
                      onSaved: (value) {
                        _enteredQuantity = int.parse(value!);
                      },
                    ),
                  ),

                  const SizedBox(width: 8),

                  /// Dropdown per selezionare la categoria
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategory,

                      /// Lista delle categorie generate dinamicamente
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                /// Quadrato colorato che rappresenta la categoria
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                const SizedBox(width: 6),
                                Text(category.value.title),
                              ],
                            ),
                          ),
                      ],

                      /// Quando l’utente cambia categoria, aggiorniamo lo stato.
                      /// Serve setState perché la UI deve aggiornarsi.
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// Pulsanti finali: Reset e Add Item
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /// RESET DEL FORM
                  /// reset() richiama tutti gli onSaved? No.
                  /// reset() ripristina solo i valori iniziali dei campi.
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: const Text('Reset'),
                  ),

                  /// SALVATAGGIO DELL’ITEM
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: const Text('Add Item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
