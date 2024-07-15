import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fields", "template"]

    connect() {
    this.addField(null);
    }

  addField(event) {
    event?.preventDefault()
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.fieldsTarget.insertAdjacentHTML("beforeend", content)
  }

  removeField(event) {
    event.preventDefault();
    const field = event.target.closest(".oba-option-component");
    field.remove();
  }
}