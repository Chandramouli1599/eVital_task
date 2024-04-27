import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

class Record {
  final String name;
  final String phoneNumber;
  final String city;
  final String imageUrl;
  int rupee;

  Record({
    required this.name,
    required this.phoneNumber,
    required this.city,
    required this.imageUrl,
    required this.rupee,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Record> allTotalRecords = [];
  List<Record> filteredRecords = [];
  final TextEditingController _searchController = TextEditingController();
  int currentPage = 0;
  int recordsPerPage = 20;
  List<String> firstNames = [
    'John',
    'Emma',
    'Michael',
    'Sophia',
    'William',
    'Olivia',
    'James',
    'Ava',
    'Alexander',
    'Isabella',
    'Ethan',
    'Mia',
    'Daniel',
    'Charlotte',
    'Benjamin',
    'Amelia',
    'Mason',
    'Harper',
    'Jacob',
    'Evelyn',
    'Liam',
    'Abigail',
    'Matthew',
    'Emily',
    'David',
    'Elizabeth',
    'Joseph',
    'Avery',
    'Logan',
    'Sofia',
    'Jackson',
    'Ella',
    'Samuel',
    'Madison',
    'Sebastian',
    'Scarlett',
    'Gabriel',
    'Victoria',
    'Lucas',
    'Grace',
    'Henry',
    'Chloe',
    'Andrew',
    'Lily',
    'Carter',
    'Aria',
    'Mateo',
    'Zoe',
    "zoe"
  ];
  List<String> indianCities = [
    'Mumbai',
    'Delhi',
    'Bangalore',
    'Hyderabad',
    'Ahmedabad',
    'Chennai',
    'Kolkata',
    'Surat',
    'Pune',
    'Jaipur',
    'Lucknow',
    'Kanpur',
    'Nagpur',
    'Visakhapatnam',
    'Indore',
    'Thane',
    'Bhopal',
    'Patna',
    'Vadodara',
    'Ghaziabad',
    'Ludhiana',
    'Coimbatore',
    'Agra',
    'Madurai',
    'Nashik',
    'Vijayawada',
    'Faridabad',
    'Meerut',
    'Rajkot',
    'Varanasi',
    'Srinagar',
    'Aurangabad',
    'Dhanbad',
    'Amritsar',
    'Navi Mumbai',
    'Allahabad',
    'Howrah',
    'Ranchi',
    'Gwalior',
    'Jabalpur',
    'Jamshedpur',
    'Jodhpur',
    'Raipur',
    'Kota',
    'Guwahati',
    'Chandigarh'
  ];

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  void _loadRecords() {
    for (var i = currentPage * recordsPerPage;
        i < (currentPage + 1) * recordsPerPage && i < 44;
        i++) {
      allTotalRecords.add(
        Record(
          name: "${firstNames[i]}",
          phoneNumber: "9898996969",
          city: "${indianCities[i]}",
          imageUrl: "",
          rupee: 0,
        ),
      );
    }
    filteredRecords = allTotalRecords;
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = (44 / recordsPerPage).ceil();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        }),
        title: const Text('Records'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterRecords,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search by name/phone/city',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredRecords.length,
              itemBuilder: (context, index) {
                int actualIndex = (currentPage * recordsPerPage) + index;
                Record record = filteredRecords[index];
                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(record.imageUrl),
                      child: Text("${actualIndex + 1}"),
                    ),
                    title: Text(record.name),
                    subtitle: Text('${record.phoneNumber}, ${record.city}'),
                    trailing: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            TextEditingController rupeesController =
                                TextEditingController();
                            return Container(
                              child: AlertDialog(
                                title: const Text('Update Rupees'),
                                content: TextField(
                                  controller: rupeesController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Enter new Rupees',
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      debugPrint("updated");
                                      record.rupee =
                                          int.parse(rupeesController.text);
                                      setState(
                                        () {},
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Update'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        '${record.rupee}',
                        style: TextStyle(
                          color: record.rupee >= 50 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    currentPage = max(0, currentPage - 1);
                    allTotalRecords.clear();
                    _loadRecords();
                  });
                },
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              const SizedBox(width: 20),
              Text(
                'Page ${currentPage + 1} of $totalPages',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: currentPage == 2
                    ? null
                    : () {
                        setState(() {
                          currentPage++;
                          allTotalRecords.clear();
                          _loadRecords();
                        });
                      },
                icon: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _filterRecords(String value) {
    setState(() {
      filteredRecords = allTotalRecords.where((record) {
        return record.name.toLowerCase().contains(value.toLowerCase()) ||
            record.phoneNumber.contains(value) ||
            record.city.toLowerCase().contains(value.toLowerCase());
      }).toList();
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
