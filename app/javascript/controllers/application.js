import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"
import UploadModalController from "controllers/upload_modal_controller"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

application.register("upload-modal", UploadModalController);
export { application }
