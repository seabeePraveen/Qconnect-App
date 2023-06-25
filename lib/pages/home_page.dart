import 'package:chatt_app_frontend/utils/routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      flex: 20,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, MyRoutes.ProfilePage);
                        },
                        child: CircleAvatar(
                          radius: 32,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/profile_image.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 60,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 20,
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.search,
                          size: 28,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 20,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          child: const Icon(
                            Icons.add,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: SizedBox(
                  height: 55,
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      prefixIcon:
                          Icon(Icons.search), // Icon leading to the input field
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(60),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              EachUserWidget(),
              EachUserWidget(),
              EachUserWidget(),
              EachUserWidget(),
              EachUserWidget(),
              EachUserWidget(),
              EachUserWidget(),
              EachUserWidget(),
              EachUserWidget(),
              EachUserWidget(),
              EachUserWidget(),
              EachUserWidget(),
              EachUserWidget(),
              EachUserWidget(),
              EachUserWidget(),
              EachUserWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class EachUserWidget extends StatelessWidget {
  const EachUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8),
      child: Container(
        width: double.maxFinite,
        height: 64,
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/profile_image.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const Text(
              "UserName",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
