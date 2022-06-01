import 'package:flutter/material.dart';
import '../db/items_database.dart';
import '../model/item.dart';
import '../widget/item_form_widget.dart';

class AddEditNotePage extends StatefulWidget {
  final Item? item;

  const AddEditNotePage({
    Key? key,
    this.item,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;
  late String expaireDate;

  @override
  void initState() {
    super.initState();

    title = widget.item?.title ?? '';
    description = widget.item?.description ?? '';
    expaireDate = widget.item?.expaireDate ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF1321E0),
          actions: [buildButton()],
          title: widget.item == null
              ? const Text('عنصر جديد')
              : const Text('تعديل العنصر'),
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            title: title,
            description: description,
            expaireDate: expaireDate,
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
            onChangedExpireDate: (expaireDate) =>
                setState(() => this.expaireDate = expaireDate),
          ),
        ),
      );

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: IconButton(
        onPressed: addOrUpdateNote,
        icon: const Icon(Icons.check),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.item != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final item = widget.item!.copy(
      title: title,
      description: description,
      expaireDate: expaireDate,
    );

    await ItemsDatabase.instance.update(item);
  }

  Future addNote() async {
    final item = Item(
      title: title,
      description: description,
      expaireDate: expaireDate,
    );

    await ItemsDatabase.instance.create(item);
  }
}
