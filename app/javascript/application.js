// app/javascript/application.js

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import Rails from "@rails/ujs";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "packs/application";
import "shelter_data";
import "serviceworker-controller";
import "serviceworker";
import { shelterLoader } from "shelter_loader"; // 拡張子は不要


// Stimulusのインポート
import { Application } from "@hotwired/stimulus";
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers";
import DropdownController from "controllers/dropdown_controller"; 
import HelloController from "controllers/hello_controller"; 
import ApplicationController from "controllers/application"; 
import IndexController from "controllers/index"; 


// Rails UJSとActiveStorageの初期化
Rails.start();
ActiveStorage.start();

// Stimulusの初期化
const application = Application.start();
application.register("dropdown", DropdownController);
application.register("hello", HelloController);
application.register("index", IndexController);
application.register("application", ApplicationController);
const context = require.context("controllers", true, /\.js$/);
application.load(definitionsFromContext(context));