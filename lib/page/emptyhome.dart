import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'add_edit_item.dart';

class EmptyHome extends StatelessWidget {
  const EmptyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Text(
            'لا منتجات نتنهي صلاحيتها خلال',
            style: TextStyle(
              color: Color(0xFF1321E0),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'الاسبوع القادم حدث الصفحة',
            style: TextStyle(
              color: Color(0xFF1321E0),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'أضف شيء',
                  style: const TextStyle(color: Color(0xFF1321E0)),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddEditNotePage())),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
