import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:test_app_nic/utils/Utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text("Home"), centerTitle: true),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0,
        children: List.generate(choices.length, (index) {
          return Center(
            child: SelectCard(choice: choices[index]),
          );
        }
        )
    ),
    );
  }
}

class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'Calendar', icon: Icons.calendar_today_rounded),
  Choice(title: 'Task', icon: Icons.task),
  Choice(title: 'Role', icon: Icons.roller_shades_closed),
  Choice(title: 'Redemption', icon: Icons.redeem_outlined),
];

class SelectCard extends StatelessWidget {
  SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  final desc = TextEditingController();
  final title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        if(choice.title == "Calendar"){
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2100));
          if (pickedDate != null) {
            print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
            String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
            Utils.showToast("Selected Date: $formattedDate");
          }
         }
         else if(choice.title == "Task"){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
                  child: Container(
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: title,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Title'),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: desc,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Description'),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: 320.0,
                            child: MaterialButton(
                              onPressed: () {
                                if(title.text.isEmpty){
                                  Utils.showToast("Please enter title");
                                }
                                else if(desc.text.isEmpty){
                                  Utils.showToast("Please enter description");
                                }
                                else{
                                  Utils.showToast("Submitted Successfully!");
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: const Color(0xFF1BC0C5),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
         }
         else if(choice.title == "Role"){
           Utils.showToast("You clicked on Role");
        }
        else{
          Utils.showToast("You clicked on Redemption");
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            color: Colors.white,
            child: Center(child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(choice.icon, size:50.0, color: Colors.black),
                  SizedBox(height: 10),
                  Text(choice.title, style: const TextStyle(color: Colors.black)),
                ]
            ),
            )
        ),
      ),
    );
  }
}
