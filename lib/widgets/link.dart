import 'package:flutter/material.dart';
import 'package:manage_my_link/functions/functions.dart';
import 'package:manage_my_link/widgets/error.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkWidget extends StatelessWidget {
  final String id;
  final String link;
  final String name;
  final String? imageUrl;
  const LinkWidget({
    super.key,
    required this.id,
    required this.link,
    required this.name,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await launchUrl(
          Uri.parse(link),
          mode: LaunchMode.externalApplication,
          webOnlyWindowName: "Link",
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (imageUrl != null)
                    Expanded(
                      child: Image.network(
                        imageUrl!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  Expanded(
                    child: Text(
                      name,
                      textScaler: TextScaler.noScaling,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () async {
                  await Functions.deleteLink(id: id).then(
                    (value) {
                      if (!value) {
                        ErrorSnackbar().showError(
                          context,
                          "Something went wrong",
                        );
                      }
                    },
                  );
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
