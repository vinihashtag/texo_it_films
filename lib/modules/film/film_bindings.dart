import 'package:get/get.dart';
import './film_controller.dart';

class FilmBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(FilmController());
    }
}