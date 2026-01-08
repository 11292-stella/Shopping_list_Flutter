### 02 – Form e validazione (Shopping List)

### 1. Schermata di input: NewItem
File: widgets/new_item.dart

È uno StatefulWidget perché:

gestisce variabili locali (_enteredName, _enteredQuantity, _selectedCategory)

deve aggiornare la UI quando cambia la categoria selezionata

Stato interno

_formKey → GlobalKey<FormState> per controllare il form

_enteredName → stringa inserita nel campo nome

_enteredQuantity → numero inserito nel campo quantità

_selectedCategory → categoria scelta nel dropdown

### 2. Struttura del Form

Il Form avvolge tutti i campi di input:

Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(...),
      TextFormField(...),
      DropdownButtonFormField(...),
      Row(...),
    ],
  ),
)

### Perché usare Form?
Permette di validare tutti i campi insieme (validate())

Permette di salvare tutti i campi insieme (save())

Permette di resettare tutti i campi (reset())

### 3. GlobalKey<FormState>

final _formKey = GlobalKey<FormState>();
Serve per accedere allo stato del Form da fuori

Permette di chiamare:

validate() → controlla tutti i campi

save() → salva tutti i valori

reset() → ripristina i valori iniziali

### 4. Campi di input

### Campo nome (TextFormField)

TextFormField(
  maxLength: 50,
  decoration: InputDecoration(label: Text('Name')),
  validator: (value) { ... },
  onSaved: (value) { _enteredName = value!; },
)

validator → controlla che il testo sia tra 1 e 50 caratteri

onSaved → salva il valore nella variabile _enteredName

### Campo quantità (TextFormField)

TextFormField(
  decoration: InputDecoration(label: Text('Quantity')),
  keyboardType: TextInputType.number,
  initialValue: _enteredQuantity.toString(),
  validator: (value) { ... },
  onSaved: (value) { _enteredQuantity = int.parse(value!); },
)
validator → controlla che sia un numero positivo

onSaved → converte il valore in intero e lo salva

### Dropdown categoria (DropdownButtonFormField)

DropdownButtonFormField(
  value: _selectedCategory,
  items: [...],
  onChanged: (value) {
    setState(() {
      _selectedCategory = value!;
    });
  },
)

Mostra tutte le categorie disponibili

Aggiorna _selectedCategory quando l’utente seleziona una nuova voce

### 5. Pulsanti finali

TextButton(
  onPressed: () {
    _formKey.currentState!.reset();
  },
  child: Text('Reset'),
)

ElevatedButton(
  onPressed: _saveItem,
  child: Text('Add Item'),
)
Reset → ripristina i valori iniziali

Add Item → chiama _saveItem() per validare e salvare

### 6. Metodo _saveItem()

void _saveItem() {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
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

### Flusso completo:

validate() → controlla tutti i campi

save() → salva i valori nelle variabili

Crea un oggetto GroceryItem

Ritorna l’oggetto alla schermata precedente con Navigator.pop

### 7. Pattern riutilizzabile per altri form

Crea una GlobalKey<FormState>

Avvolgi i campi in un Form(key: ...)

Usa validator e onSaved nei campi

Nel pulsante, chiama:

if (_formKey.currentState!.validate()) {
  _formKey.currentState!.save();
  // usa i dati salvati
}

### 8. In parole povere

Il Form è il contenitore intelligente che coordina tutti i campi.
La GlobalKey è il telecomando per validare, salvare e resettare.
I TextFormField e DropdownButtonFormField sono i campi che parlano con il Form.
Alla fine, i dati vengono raccolti e trasformati in un oggetto GroceryItem.


