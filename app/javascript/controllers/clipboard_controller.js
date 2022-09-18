import { Controller } from '@hotwired/stimulus';
import copy from 'copy-to-clipboard';

export default class extends Controller {
  static targets = ['indicator'];

  static values = {
    copy: String
  };

  copy() {
    copy(this.copyValue);

    if (this.hasIndicatorTarget) {
      this.indicatorTarget.classList.remove('opacity-0');

      setTimeout(() => {
        this.indicatorTarget.classList.add('opacity-0');
      }, 3000);
    }
  }
}
