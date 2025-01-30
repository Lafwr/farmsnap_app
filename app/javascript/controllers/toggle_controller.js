import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  connect() {
    console.log("Toggle controller connected!")
  }

  toggle() {
    this.formTarget.classList.toggle("hidden")
  }
}
