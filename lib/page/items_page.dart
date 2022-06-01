import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../db/items_database.dart';
import '../model/item.dart';
import 'add_edit_item.dart';
import 'item_detail_page.dart';
import '../widget/item_card_widget.dart';
import 'emptyhome.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  late List<Item> items;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    ItemsDatabase.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    items = await ItemsDatabase.instance.readAllItems(); //this
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'صلاحية',
            style: TextStyle(fontSize: 24),
          ),
        ),
        // drawer: Drawer(
        //   child: ListView(
        //     children: [
        //       DrawerHeader(
        //           decoration: BoxDecoration(color: Colors.blue),
        //           child: Text('صلاحية')),
        //       ListTile(
        //         title: Text('الرئيسية'),
        //         onTap: () async {
        //           await Navigator.of(context).push(
        //             MaterialPageRoute(builder: (context) => ItemsPage()),
        //           );
        //           refreshNotes();
        //         },
        //       ),
        //       ListTile(
        //         // title: Text('المطور'),
        //       )
        //     ],
        //   ),
        // ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : items.isEmpty
                  ? const EmptyHome()
                  : notesListView(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF1321E0),
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditNotePage()),
            );

            refreshNotes();
          },
        ),
      );

  Widget notesListView() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          child: NoteCardWidget(
            item: item,
            index: index,
          ),
          actions: [
            IconSlideAction(
              caption: 'حذف العنصر',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () async {
                await ItemsDatabase.instance.delete(item.id!);

                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ItemsPage()));

                refreshNotes();
              },
            ),
            IconSlideAction(
              caption: 'تعديل',
              color: Colors.yellow,
              icon: Icons.edit,
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddEditNotePage(item: item),
                ));

                refreshNotes();
              },
            ),
            IconSlideAction(
              caption: 'تفاصيل',
              color: Colors.blue,
              icon: Icons.details,
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NoteDetailPage(itemId: item.id!),
                ));

                refreshNotes();
              },
            ),
          ],
        );
      },
    );
  }
  // Widget notesListView() {
  //   return ListView.builder(
  //     itemCount: items.length,
  //     itemBuilder: (context, index) {
  //       final item = items[index];

  //       return GestureDetector(
  //         onTap: () async {
  //           await Navigator.of(context).push(MaterialPageRoute(
  //             builder: (context) => NoteDetailPage(itemId: item.id!),
  //           ));

  //           refreshNotes();
  //         },

  //         child: NoteCardWidget(
  //           item: item,
  //           index: index,
  //         ),
  //       );
  //     },
  //   );
  // }
}
