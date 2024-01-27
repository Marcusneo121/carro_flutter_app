import 'package:carro_flutter_app/core/provider/view_state.dart';
import 'package:flutter/material.dart';

class ViewStateModel with ChangeNotifier {
  bool _disposed = false;

  ViewState _viewState = ViewState.idle;

  ViewState get viewState => _viewState;

  ViewStateModel({ViewState? viewState})
      : _viewState = viewState ?? ViewState.idle {}

  set viewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  bool get isBusy => viewState == ViewState.busy;

  void setBusy() => viewState = ViewState.busy;

  bool get isIdle => viewState == ViewState.idle;

  void setIdle() => viewState = ViewState.idle;

  bool get isEmpty => viewState == ViewState.empty;

  void setEmpty() => viewState = ViewState.empty;

  bool get isError => viewState == ViewState.error;

  void setError() => viewState = ViewState.empty;

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
