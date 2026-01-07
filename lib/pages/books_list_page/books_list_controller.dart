import 'package:biblioapp/components/geren_tag.dart';
import 'package:biblioapp/configs/generic_response.dart';
import 'package:biblioapp/models/book.dart';
import 'package:biblioapp/models/genre.dart';
import 'package:biblioapp/services/books_service.dart';
import 'package:biblioapp/services/geners_service.dart';
import 'package:get/get.dart';

class BooksListController extends GetxController {
  BooksService _booksService = BooksService();
  GerensService _gerensService = GerensService();

  RxList<Book> books = <Book>[].obs;
  RxList<Genre> gerens = <Genre>[].obs;
  RxList<Genre> selectedGerens = <Genre>[].obs;
  // Estado de carga
  RxBool isLoading = false.obs;
  // Mensaje de error
  RxString errorMessage = ''.obs;

  Future<void> listBooks() async {
    isLoading.value = true;
    errorMessage.value = '';
    GenericResponse<dynamic> response = await _booksService.fetchAll();
    //print(response);
    if (response.success) {
      books.value = response.data;
      isLoading.value = false;
    } else {
      errorMessage.value = response.message;
    }
  }

  void gerenSelected(Genre genre, bool isSelected) {
    if (isSelected) {
      // Agregar a selectedGerens si no existe
      if (!selectedGerens.any((g) => g.id == genre.id)) {
        selectedGerens.add(genre);
      }
    } else {
      // Retirar de selectedGerens si existe
      selectedGerens.removeWhere((g) => g.id == genre.id);
    }
  }

  bool isGenreSelected(Genre genre) {
    return selectedGerens.any((g) => g.id == genre.id);
  }

  Future<void> clearSelectedGerensAndReload() async {
    selectedGerens.value = <Genre>[];
    await listGerens(); // Solo si realmente necesitas recargar
  }

  Future<void> filterByGeners() async {
    GenericResponse<dynamic> response = await _booksService.filter(
      selectedGerens.value,
    );
    if (response.success) {
      books.value = response.data;
      isLoading.value = false;
    } else {
      errorMessage.value = response.message;
    }
  }

  Future<void> listGerens() async {
    isLoading.value = true;
    errorMessage.value = '';
    GenericResponse<dynamic> response = await _gerensService.fetchAll();
    if (response.success) {
      gerens.value = response.data;
      isLoading.value = false;
    } else {
      errorMessage.value = response.message;
    }
  }
}
