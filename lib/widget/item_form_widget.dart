import 'package:date_time_picker/date_time_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:intl/intl.dart';

class NoteFormWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final String? expaireDate;
  // late String? day;
  // late String? month;
  // late String? year;
  late DateTime selectedDate;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  late ValueChanged<String> onChangedExpireDate;
  DateTime date = DateTime.now();
  DateTime today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  // late ValueChanged<DateTime> onChangedExpireDate;

  NoteFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    this.expaireDate,
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedExpireDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              // const SizedBox(height: 8),
              buildExpaireDateBicker(),
              buildDescription(),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'اسم العنصر',
          hintStyle: TextStyle(color: Colors.black),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'يجب اضافة اسم للعنصر' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 2,
        initialValue: description,
        style: const TextStyle(color: Colors.black, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'تفاصيل',
          hintStyle: TextStyle(color: Colors.black),
        ),
        onChanged: onChangedDescription,
      );

  // Widget buildExpaireDateBicker() {
  //   return Container(

  //     child: DateTimePicker(
  //       initialValue: expaireDate,
  //       // format: DateFormat('dd/MM/yyyy'),
  //       initialEntryMode: DatePickerEntryMode.input,
  //       //  DatePickerMode.day

  //       timePickerEntryModeInput: true,
  //       firstDate: DateTime(2000),
  //       lastDate: DateTime(2100),
  //       dateLabelText: 'تاريخ انتهاء الصلاحية',
  //       onChanged: onChangedExpireDate,
  //       validator: (title) =>
  //           title != null && title.isEmpty ? 'يجب اضافة تاريخ الانتهاء' : null,
  //     ),
  //   );
  // }

  Widget buildExpaireDateBicker() {
    return DatePickerWidget(
      looping: false, // default is not looping
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(2050, 1, 1),
      initialDate: today,
      dateFormat: "dd-MM-yyyy",
      locale: DatePicker.localeFromString('en'),
      onChange: (DateTime newDate, _) {
        selectedDate = newDate;
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        onChangedExpireDate((formatter.format(selectedDate)).toString());
      },

      pickerTheme: DateTimePickerTheme(
        itemTextStyle: TextStyle(color: Colors.black, fontSize: 19),
        dividerColor: Colors.blue,
      ),
    );
  }
}
