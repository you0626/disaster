// app/javascript/application.js

// JavaScriptライブラリのインポート
import Rails from "@rails/ujs";
import * as ActiveStorage from "@rails/storage";
import "channels";
import "jquery"; // jQueryをインポート
import "bootstrap"; // Bootstrapをインポート

// Stimulusのインポート
import { Application } from "@hotwired/stimulus";
import DropdownController from "./controllers/dropdown_controller"; // 作成したDropdownControllerのインポート

// Rails UJSの初期化
Rails.start();
ActiveStorage.start();

// Stimulusの初期化
const application = Application.start();
application.register("dropdown", DropdownController); // DropdownControllerを登録