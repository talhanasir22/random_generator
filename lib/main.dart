import 'package:flutter/material.dart';
import 'package:random_generator/AllCardsList.dart';
import 'package:random_generator/InfiniteDragableSlider.dart';
import 'package:random_generator/PolicyScreen.dart';
import 'package:random_generator/SplashScreen.dart';
import 'package:random_generator/ThemeContainer.dart';
import 'PageCards.dart';
import 'PageCardsCoverImage.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ThemeContainer(
        child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(backgroundImage: AssetImage('assets/Images/Logo.png')),
                      Center(
                        child: const Text(
                          'Random Hub',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      PopupMenuButton<String>(
                        onSelected: (String value) {
                          if (value == 'Privacy Policy') {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PolicyScreen()));
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<String>(
                              value: 'Privacy Policy',
                              child: Text('Privacy Policy'),
                            ),
                          ];
                        },
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )

                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'EXPLORE FEATURES',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: InfiniteDragableSlider(
                  itemCount: PageCards.fakePageCardsValues.length,
                  itemBuilder: (context, index) => PageCardsCoverImage(
                    pageCards: PageCards.fakePageCardsValues[index],
                  ),
                ),
              ),
              const SizedBox(height: 200),
              SizedBox(
                height: 140,
                child: AllCardsListView(pageCards: PageCards.fakePageCardsValues), // Added Expanded to ensure proper layout
              ),
              const SizedBox(height: 40,),
            ],
          ),
      ),
      );
  }
}
