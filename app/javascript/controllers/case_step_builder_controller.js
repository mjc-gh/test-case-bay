import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [
    'search', 'newButton', 'newTitle'
  ];

  get searchValue() {
    return this.searchTarget.value;
  }

  connect() {
    console.log(this);
  }

  update() {
    const value = this.searchValue;

    this.newTitleTarget.value = value;

    if (value.length > 0) {
      this.newButtonTarget.classList.remove('opacity-0');
    } else {
      this.newButtonTarget.classList.add('opacity-0');
    }
  }
}
