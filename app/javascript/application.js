// app/javascript/application.js

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import Rails from "@rails/ujs";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "packs/application";

// Stimulusのインポート
import { Application } from "@hotwired/stimulus";
import DropdownController from "./controllers/dropdown_controller"; 
import HelloController from "./controllers/hello_controller";
import SomeController from "./controllers/some_controller";

// Rails UJSとActiveStorageの初期化
Rails.start();
ActiveStorage.start();

// Stimulusの初期化
const application = Application.start();
application.register("dropdown", DropdownController);
application.register("hello", HelloController);
application.register("some", SomeController);