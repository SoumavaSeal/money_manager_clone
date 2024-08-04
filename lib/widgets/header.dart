import 'package:flutter/material.dart';
import 'package:money_manager_clone/models/date_controller.dart';

class Header extends StatefulWidget {
    final DateTime date;
    final dynamic updateParent;

    const Header({
        super.key,
        required this.date,
        required this.updateParent
    });

    @override
    State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

    DateTime date = DateTime.now();
    final DateController _dateController = DateController();

    @override
    void initState() {
        _dateController.setDate(widget.date);
        date = _dateController.getDate();
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return DefaultTabController(
            length: 4,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            IconButton( 
                                onPressed:() {
                                    setState(() {
                                        _dateController.prevMonth();
                                        date = _dateController.getDate();
                                        widget.updateParent(date);
                                    });
                                },
                                icon: const Icon(Icons.arrow_left)
                            ),
                            Text("${_dateController.months[date.month - 1]} ${date.year}"),
                            IconButton( 
                                onPressed:() {
                                    setState(() {
                                        _dateController.nextMonth();
                                        date = _dateController.getDate();
                                        widget.updateParent(date);
                                    });
                                },
                                icon: const Icon(Icons.arrow_right)
                            ),
                        ],
                    ),
                    const Text("right")
                ],
            ),
        );
    }
}
