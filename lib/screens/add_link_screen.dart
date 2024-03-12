import 'package:flutter/material.dart';
import 'package:manage_my_link/functions/functions.dart';
import 'package:manage_my_link/widgets/error.dart';

class AddLinkScreen extends StatefulWidget {
  static const String routeName = "/add-new-link";
  const AddLinkScreen({super.key});

  @override
  State<AddLinkScreen> createState() => _AddLinkScreenState();
}

class _AddLinkScreenState extends State<AddLinkScreen> {
  late final TextEditingController nameController;
  late final TextEditingController linkController;
  late final TextEditingController imageController;

  bool isLoading = false;

  @override
  void initState() {
    nameController = TextEditingController();
    linkController = TextEditingController();
    imageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    linkController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Add New Link",
                      textScaler: TextScaler.noScaling,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Name",
                        textScaler: TextScaler.noScaling,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 32,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        return value!.isEmpty ? "Please Enter a name" : null;
                      },
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Link",
                        textScaler: TextScaler.noScaling,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 32,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        return value!.isEmpty ? "Please Enter a link" : null;
                      },
                      controller: linkController,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Image Url",
                        textScaler: TextScaler.noScaling,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 32,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: imageController,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (isLoading)
                      Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    if (!isLoading)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.onSecondary,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 20,
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await Functions.addLink(
                            name: nameController.text.trim(),
                            link: linkController.text.trim(),
                            imageUrl: imageController.text.trim(),
                          ).then(
                            (value) {
                              setState(() {
                                isLoading = false;
                              });
                              if (value) {
                                Navigator.of(context).pop();
                              } else {
                                ErrorSnackbar()
                                    .showError(context, "Something went wrong");
                              }
                            },
                          );
                        },
                        child: const Text(
                          "Add Link",
                          textScaler: TextScaler.noScaling,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
