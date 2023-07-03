import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

Map dummy = {
  'Facebook': 'Social',
  'nama@gmail.com': 'Email',
  'Instagram': 'Social',
  'Instagram1': 'Social',
  'Instagram2': 'Social',
  'Instagram3': 'Social',
  'Instagram4': 'Social',
  'Instagram5': 'Social',
  'Instagram6': 'Social',
  'Instagram7': 'Social',
  'Instagram8': 'Social',
  'Instagram8': 'Social',
  'Instagram10': 'Social',
  'Instagram11': 'Social',
  'Instagram12': 'Social',
  'Instagram13': 'Social',
  'Instagram14': 'Social',
  'Instagram15': 'Social',
};

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Cybit"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: dummy.length,
            itemBuilder: (context, index) {
              final title = dummy.keys.elementAt(index);
              final type = dummy.values.elementAt(index);
              return Container(
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    title,
                    style: const TextStyle(fontSize: 19),
                  ),
                  subtitle: Text(type,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary)),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aksi yang ingin dilakukan ketika tombol ditekan
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context)
            .colorScheme
            .secondary, // Warna latar belakang tombol
        foregroundColor: Colors.white, // Warna ikona dan teks di dalam tombol
      ),
    );
  }
}
