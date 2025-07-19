import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="conversation"
export default class extends Controller {
  static targets = ["history"]

  close() {
    this.historyTarget.innerHTML = ""
  }
}
