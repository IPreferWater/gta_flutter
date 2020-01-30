import 'dart:async';
import 'package:bloc/bloc.dart';
import 'category_event.dart';
import 'category_state.dart';
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  @override
  // TODO: implement initialState
  CategoryState get initialState => null;

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) {
    // TODO: implement mapEventToState
    return null;
  }/*
  QrCodeDao _qrCodeDao = QrCodeDao();
  CreationDao _creationDao = CreationDao();

  // Display a loading indicator right from the start of the app
  @override
  QrCodeState get initialState => QrCodeLoading();

  // This is where we place the logic.
  @override
  Stream<QrCodeState> mapEventToState(
      QrCodeEvent event,
      ) async* {
    if (event is LoadQrCodes) {
      yield QrCodeLoading();
      yield* _reloadQrCode();
    }

    else if (event is LoadFreeQrCodes){
      yield QrCodeLoading();
      yield* _reloadFreeQrCode();
    }

    else if (event is CreateQrCode){
      await _qrCodeDao.insert(event.qrCode);
      yield* _reloadQrCode();
    }

    else if (event is UpdateQrCode){
      await _qrCodeDao.update(event.updatedQrCode);
      yield* _reloadQrCode();
    }

    else if (event is DeleteQrCode){
      await _qrCodeDao.delete(event.qrCode);
      yield* _reloadQrCode();
    }
  }

  Stream<QrCodeState> _reloadQrCode() async* {
    final qrCodes = await _qrCodeDao.getAllSortedById();
    print(qrCodes);
    yield QrCodeLoaded(qrCodes);
  }

  Stream<QrCodeState> _reloadFreeQrCode() async* {
    var qrCodes = await _qrCodeDao.getAllSortedById();
    final creations = await _creationDao.getAll();

    final alreadyUsedQrCode = creations.map((creation) => creation.qrCodeId).toList();

    qrCodes.removeWhere((qrCode) =>
      alreadyUsedQrCode.contains(qrCode.id)
    );


    yield QrCodeLoaded(qrCodes);
  }*/
}