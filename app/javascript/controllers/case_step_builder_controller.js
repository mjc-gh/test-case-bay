import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  connect() {
    console.log(this);
  }

  update(ev) {
    const { target: { value } } = ev;

    console.log(this, value);
  }
}
