import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];

  toggleMenu() {
    console.log("Dropdown toggled");
    this.menuTarget.classList.toggle("show");
  }
}