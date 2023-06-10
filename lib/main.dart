import 'package:database_server/view_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(MaterialApp(home: get_data(),));
}
class get_data extends StatefulWidget {
String ?id;
String ?name;
String ?contact;
get_data([this.id,this.name,this.contact]);
  @override
  State<get_data> createState() => _get_dataState();
}

class _get_dataState extends State<get_data> {
  TextEditingController name=TextEditingController();
  TextEditingController contact=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.id!=null){
      name.text=widget.name!;
      contact.text=widget.contact!;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: (widget.id !=null)?(Text("Updated")):Text("Get Data"),),
      body: Column(
        children: [
          Card(child: TextFormField(controller: name,)),
          Card(child: TextFormField(controller: contact,)),
          ElevatedButton(onPressed: () async {
          String _name,_contact;
          _name=name.text;
          _contact=contact.text;
          if(widget.id!=null){
            var url = Uri.parse('https://demo2811.000webhostapp.com/updated.php');
            var response = await http.post(url, body: {'id' :'${widget.id}','name': '$_name', 'contact': '$_contact'});
            print('Response status: ${response.statusCode}'); //statuscode=200
            print('Response body: ${response.body}');
          }else{
            var url = Uri.parse('https://demo2811.000webhostapp.com/connecation.php');
            var response = await http.post(url, body: {'name': '$_name', 'contact': '$_contact'});

            print('Response status: ${response.statusCode}'); //statuscode=200
            print('Response body: ${response.body}');
            print("name:$_name");

          }
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Submit Sucessfully...")));

          }, child: (widget.id!=null)?(Text("Update")):Text("Submit")),
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return View();
            },));

          }, child: Text("View Data"))
        ],
      )

    );
  }
}
