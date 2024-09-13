import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:it_sharks_first_app/cubit/database_cubit.dart';
import 'package:it_sharks_first_app/model/note_model.dart';

class NoteCard extends StatefulWidget {
  final NoteModel note;
  const NoteCard({super.key , required this.note});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = (widget.note.status == 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.blueGrey[200],
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Transform.scale(
                  scale: 2,
                  child: Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                        widget.note.status = _isChecked ? 1 : 0;
                        DatabaseCubit.get(context).updateSpecificNote(widget.note);
                      });
                    },
                    activeColor: Colors.green,
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      widget.note.title,
                      style:  TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        decoration: _isChecked ? TextDecoration.lineThrough : null,
                        decorationThickness: 5
                      ),
                    ),
                     Text(
                      widget.note.desc,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                          decoration: _isChecked ? TextDecoration.lineThrough : null,
                          decorationThickness: 5
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.note.date,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.blueGrey.shade500,
                          decoration: _isChecked ? TextDecoration.lineThrough : null,
                          decorationThickness: 5
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
