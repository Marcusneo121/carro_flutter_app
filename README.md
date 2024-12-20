![Logo](https://i.ibb.co/wN4LCJb/carros.png)

# Carro Flutter App

Carro is a P2P Car Sharing Platform. If you go through my repos, you had probably seen similar Flutter app from few years ago. YES! Its a similar app.

The reason I am re-develop the same app is because I am trying to create my own Backend APIs to replace the old Carro app which used Firebase + brush up my flutter with project from scratch.

Therefore, this project is mainly a showcase of how the APIs work. The main focus is the Backend.

## Technologies

<img src="https://storage.googleapis.com/cms-storage-bucket/847ae81f5430402216fd.svg" width="150"/><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Stripe_Logo%2C_revised_2016.svg/2560px-Stripe_Logo%2C_revised_2016.svg.png" width="120"/> 

## Features

Some pretty basic feature, mainly focus on backend. This is just a showcase.

- Login, Sign Up & Logout with JWT Authentication
- Host Car
- Guest Book Car
- Payment with Stripe (custom backend api integrated with Stripe)
- Car, Booking(for Guest) and Rent Request(for Host) Listing
- Bargain car renting price (between Host & Guest)

Additional Features

- Light/dark mode
- Dynamic App Icon based on theme.

## Screenshots

| Home                                           | My Booking                                           |
| ---------------------------------------------- | ---------------------------------------------------- |
| <img src="https://i.ibb.co/NnqxzF7/IMG-1277.png" width="250"/> | <img src="https://i.ibb.co/gr9pkV7/IMG-1278.png" width="250"/>  |

| Booking Detail                                                   | Stripe Payment Sheet                                           |
| ---------------------------------------------------------------- | -------------------------------------------------------------- |
| <img src="https://i.postimg.cc/tRxRX96z/IMG-1279.png" width="250"/> | <img src="https://i.postimg.cc/NfTLsnbK/IMG-1281.png" width="250"/>  |

## State Management & Architecture

**Provider + ChangeNotifier (with Custom ViewState)**

- ViewStateModel with ChangeNotifier

```
//Example of a state
//Detail code in "lib/core/provider/view_state_model.dart"

class ViewStateModel with ChangeNotifier {
    ViewState _viewState = ViewState.idle;

    set viewState(ViewState viewState) {
        _viewState = viewState;
        notifyListeners();
    }

    bool get isBusy => viewState == ViewState.busy;

    void setBusy() => viewState = ViewState.busy;
}
```

- Use, Implementation & Extending

```
class DemoProvider extends ViewStateModel {
  DemoProvider() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await callAPI();
    });
  }

  callAPI() async {
    setBusy();
    try {
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }
}
```

- UI Layer Implementation

```
class DemoPage extends StatefulWidget {
    Widget build(BuildContext context) {
        return ChangeNotifierProvider(
            create: (context) => DemoProvider(),
            child: Scaffold(
                builder: (context, model, child) {
                    if (viewCarModel.isBusy) {
                        return CircularProgressIndicator();
                    } else if (viewCarModel.isError){
                        return Error();w
                    } else if (viewCarModel.isIdle){
                        //Idle is when API calling done
                        return Listing();
                    }
                }
            ),
        );
    }
}
```

**You might ask why not use BLOC?**

The reason I use Provider is that I want to keep the project simple to manage, and I don't like how BLOC need to manage 3 files (bloc, event, state). However with BLOC it did the same thing as my ViewState approach. One thing I like with BLOC that it is complicated to setup at first but the implementation in UI layer and features are much more easier, based on my past project experience.

## Build & Run

To build & run this Flutter project :

```bash
  flutter pub get
  flutter run
```

## Related

[Carro Web-App Repo - Next JS](https://github.com/Marcusneo121/carro-web-app)

[Carro Backend Repo - Node JS](https://github.com/Marcusneo121/carro-backend)

## Contributor

- [@Marcusneo121](https://github.com/Marcusneo121)
