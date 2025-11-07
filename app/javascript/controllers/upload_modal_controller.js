import { Controller } from "@hotwired/stimulus"

// Controls the open/close state of the upload modal
export default class extends Controller {
  static targets = ['modal']

  open() {
    this.modalTarget.classList.remove("hidden")
  }

  close(event) {
    this.modalTarget.classList.add("hidden")
  }

  closeOnSuccess(event) {
    const { success } = event.detail; // Turbo provides success flag
    if (success) {
      this.close();
    }
  }
}
