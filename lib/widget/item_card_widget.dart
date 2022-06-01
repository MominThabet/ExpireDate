import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/item.dart';

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  final Item item;
  final int index;
  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
    final time = item.expaireDate;
    late DateTime expaireDate;
    try {
      expaireDate = DateTime.parse(item.expaireDate);
    } on FormatException {
      expaireDate = DateTime.now();
    }
    final dateColor;

    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (from.difference(to).inHours / 24).round();
    }

    if (daysBetween(expaireDate, DateTime.now()) < 0) {
      dateColor = Colors.black;
    } else if (daysBetween(expaireDate, DateTime.now()) >= 0 &&
        daysBetween(expaireDate, DateTime.now()) <= 2) {
      dateColor = Colors.red;
    } else if (daysBetween(expaireDate, DateTime.now()) > 2 &&
        daysBetween(expaireDate, DateTime.now()) < 5) {
      dateColor = Colors.yellow;
    } else {
      dateColor = Colors.green;
    }

    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
        elevation: 5,
        color: Colors.white,
        child: ClipPath(
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          child: Row(
            children: [
              Container(
                color: dateColor,
                height: 100,
                width: 10,
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.title,
                          style: TextStyle(
                            color: Color(0xFF1321E0),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                  Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        time,
                        style: TextStyle(color: dateColor, fontSize: 16),
                      )),
                  Flexible(
                      child: Text(
                    ' ${daysBetween(expaireDate, DateTime.now())} يوم متبقي حتى انتهاء الصلاحية',
                    maxLines: 2,
                    style: TextStyle(color: dateColor),
                  )),
                ],
              ),
            ],
          ),
        ));
  }
}
