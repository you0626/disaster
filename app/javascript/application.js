// app/javascript/application.js

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import Rails from "@rails/ujs";
import * as ActiveStorage from "@rails/storage";
import "channels";
import "jquery"; // jQueryをインポート
import "bootstrap"; // Bootstrapをインポート

// Stimulusのインポート
import { Application } from "@hotwired/stimulus";
import DropdownController from "./controllers/dropdown_controller"; 
import HelloController from "./controllers/hello_controller"; // 他のコントローラのインポート
import SomeController from "./controllers/some_controller"; // 新しいコントローラのインポート

// Rails UJSの初期化
Rails.start();
ActiveStorage.start();

// Stimulusの初期化
const application = Application.start();
application.register("dropdown", DropdownController);
application.register("hello", HelloController); // 他のコントローラの登録
application.register("some", SomeController); // 新しいコントローラの登録

// Controller registration can be done in a loop if there are many controllers
// const controllers = { dropdown: DropdownController, hello: HelloController, some: SomeController };
// Object.entries(controllers).forEach(([name, controller]) => application.register(name, controller));