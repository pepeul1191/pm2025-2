import 'package:biblioapp/configs/generic_response.dart';
import 'package:biblioapp/models/book.dart';
import 'package:biblioapp/services/books_service.dart';
import 'package:get/get.dart';

class BooksListController extends GetxController {
  BooksService _booksService = BooksService();
  RxList<Book> books = <Book>[].obs;
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
}
