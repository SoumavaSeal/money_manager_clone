import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager_clone/models/date_controller.dart';

class Header extends StatefulWidget {
  final DateTime date;
  final dynamic updateParent;

  const Header({super.key, required this.date, required this.updateParent});

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
    return Container(
      color: Theme.of(context).primaryColor,
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _dateController.prevMonth();
                      date = _dateController.getDate();
                      widget.updateParent(date);
                    });
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.angleLeft,
                    size: 12,
                    color: Theme.of(context).secondaryHeaderColor,
                  )),
              Text(
                "${_dateController.months[date.month - 1]} ${date.year}",
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _dateController.nextMonth();
                      date = _dateController.getDate();
                      widget.updateParent(date);
                    });
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.angleRight,
                    size: 12,
                    color: Theme.of(context).secondaryHeaderColor,
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: 12,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
        ],
      ),
    );
  }
}
