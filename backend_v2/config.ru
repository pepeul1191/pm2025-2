require_relative 'controllers/application_controller'
require_relative 'controllers/book_controller'
require_relative 'controllers/genre_controller'
require_relative 'controllers/demo_controller'
require_relative 'controllers/session_controller'
require_relative 'controllers/file_controller'

use BookController
use GenreController
use DemoController
use SessionController
use FileController
run ApplicationController