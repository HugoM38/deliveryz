import 'package:deliveryz_front/database/kitchen/kitchen_queries.dart';
import 'package:deliveryz_front/models/user.dart';
import 'package:deliveryz_front/utils/shared_prefs_manager.dart';
import 'package:flutter/material.dart';

class HomeClientPage extends StatefulWidget {
  const HomeClientPage({super.key});

  @override
  State<HomeClientPage> createState() => _HomeClientPageState();
}

class _HomeClientPageState extends State<HomeClientPage> {
  List<Cooker> cookers = [];

  @override
  void initState() {
    super.initState();
    fetchCookers().then((fetchedCookers) {
      setState(() {
        cookers = fetchedCookers;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeliveryZ'),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.error),
            ),
            onPressed: () async {
              await SharedPrefsManager.logoutUser();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              }
            },
            child: const Text('Déconnexion'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: ListView.builder(
              itemCount: cookers.length,
              itemBuilder: (context, index) {
                final cooker = cookers[index];
                return ListTile(
                  title: Text(cooker.cookerName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground)),
                  trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/kitchen-menu',
                            arguments: cooker);
                      },
                      child: Text('Voir le menu',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary))),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Cooker>> fetchCookers() async {
    List<Cooker> cookersList = [];
    try {
      cookersList = (await getCookers())!;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
    return cookersList;
  }
}
