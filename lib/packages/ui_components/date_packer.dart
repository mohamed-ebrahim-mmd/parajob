// import 'package:flutter/material.dart';

// //todo remove this class when finished no  need for it
// class DatePickerField extends StatefulWidget {
//   final String hintText;
//     final String? text;

//    DatePickerField({super.key, required this.hintText,this.text});

//   @override
//   State<DatePickerField> createState() => _DatePickerFieldState();
// }

// class _DatePickerFieldState extends State<DatePickerField> {
//   final TextEditingController controller = TextEditingController();
//   controller.text = widget.text ?? '';

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime(2000, 1, 1),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );

//     if (pickedDate != null) {
//       setState(() {
//        controller.text =
//             "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller:controller,
//       readOnly: true, // ✅ prevents keyboard from opening
//       decoration: InputDecoration(
//         hintText: widget.hintText,
//         // suffixIcon: Icon(Icons.calendar_today),
//       ),
//       onTap: () => _selectDate(context),
//     );
//   }
// }



import 'package:flutter/material.dart';

// TODO: Remove this class when no longer needed
class DatePickerField extends StatefulWidget {
  final String? hintText;
  final String? text;

  const DatePickerField({
    super.key,
     this.hintText,
    this.text,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text ?? '');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      onTap: () => _selectDate(context),
    );
  }
}





class YearPickerField extends StatefulWidget {
  final String? hintText;
  final int? selectedYear;

  const YearPickerField({
    super.key,
    this.hintText,
    this.selectedYear,
  });

  @override
  State<YearPickerField> createState() => _YearPickerFieldState();
}

class _YearPickerFieldState extends State<YearPickerField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.selectedYear.toString());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _selectYear(BuildContext context) async {
    final currentYear = DateTime.now().year;
    // selectedYear = int.tryParse(controller.text);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Year"),
          content: SizedBox(
            // Show 1900 → current year
            height: 250,
            width: 300,
            child: YearPicker(
              firstDate: DateTime(1900),
              lastDate: DateTime(currentYear),
              selectedDate: DateTime(widget.selectedYear ?? currentYear),
              onChanged: (DateTime dateTime) {
                setState(() {
                  controller.text = dateTime.year.toString();
                });
                Navigator.pop(context); // close dialog
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        hintText: widget.hintText ?? "Select Year",
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      onTap: () => _selectYear(context),
    );
  }
}
////////////////////////////

// ignore: must_be_immutable/