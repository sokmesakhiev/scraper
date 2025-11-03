import { Controller } from "@hotwired/stimulus"

// Controls the open/close state of the upload modal
export default class extends Controller {
  static targets = []

  open() {
    this.element.classList.remove("hidden")
  }

  close(event) {
    event?.preventDefault()
    this.element.classList.add("hidden")
  }
}
