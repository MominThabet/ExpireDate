import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/items_database.dart';
import '../model/item.dart';
import 'add_edit_item.dart';
import 'items_page.dart';

class NoteDetailPage extends StatefulWidget {
  final int itemId;

  const NoteDetailPage({
    Key? key,
    required this.itemId,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Item item;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);
    item = await ItemsDatabase.instance.readItem(widget.itemId);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ItemsPage())),
          ),
          // backgroundColor: Color(note.color),
          title: const Text('تفاصيل العنصر'),
          actions: [
            editButton(),
            deleteButton(),
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.expaireDate.toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.description,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    )
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(item: item),
        ));

        refreshNote();
      });
  Widget deleteButton() => IconButton(
      onPressed: () async {
        await ItemsDatabase.instance.delete(item.id!);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ItemsPage()));
      },
      icon: Icon(Icons.delete));
}
