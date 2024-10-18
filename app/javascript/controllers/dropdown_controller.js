import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];

  toggleMenu(event) {
    // クリック時にデフォルトのリンク動作（#へ移動）を無効化
    event.preventDefault();
    console.log('Toggle Menu Clicked'); // デバッグ用
    this.menuTarget.classList.toggle("show");
  }
}