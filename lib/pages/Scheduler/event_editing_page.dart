import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_firstapp/utils/dimensions.dart';

import '../../utils/colors.dart';
import '../../helper/model/event.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({//constructor
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate; //enforce this variable's constraints at runtime instead of at compile time
  late DateTime toDate; //enforce this variable's constraints at runtime instead of at compile time

  @override
  void initState(){
    super.initState();
    
    if(widget.event == null){
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: CloseButton(),
      actions: buildEditingActions(),
      backgroundColor: AppColors.maincolor,
    ),
    body: SingleChildScrollView(
      //padding: EdgeInsets.all(12),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            buildTitle(),
          ],
        ),
      ),
    ),
  );
  List<Widget> buildEditingActions() => [
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: (){},
        icon: Icon(Icons.done),
        label: Text('Save'),
    ),
  ];
  Widget buildTitle() => TextFormField(
      style: TextStyle(fontSize: Dimensions.font20),
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        hintText: 'Add Title Schedule'
      ),
      onFieldSubmitted: (_) {},
      validator: (title) =>
        title != null && title.isEmpty ? 'Title cannot be empty' : null,
      controller: titleController,
  );
}
