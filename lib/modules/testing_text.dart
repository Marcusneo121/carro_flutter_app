import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:flutter/material.dart';


class TestingTextSize extends StatelessWidget {
  const TestingTextSize({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    var password = 'DarkestarzZ2@';
    String hashedPassword =
        "\$argon2id\$v=19\$t=3,m=4096,p=1\$yvkDZSZKjcLtpWTMzv0wHg\$8YnWwqOkaKeC595DbPo4VqdjhYlx3rwXcHHNt4C1XYk";

    decrypt() {
      print('Decrypting.....');
      
    }

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Display Large",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(
                "Display Medium",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                "Display Small",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                "Headline Large",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                "Headline Medium",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "Headline Small",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                "Title Large",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Title Medium",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                "Title Small",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                "Body Large",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                "Body Medium",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "Body Small",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                "Label Large",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                "Label Medium",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                "Label Small",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              TextField(
                controller: controller,
              ),
              TextButton(
                onPressed: () async {
                  decrypt();
                },
                child: const Text('Decrypt'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
