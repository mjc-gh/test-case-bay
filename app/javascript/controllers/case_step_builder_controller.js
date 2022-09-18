import { Controller } from '@hotwired/stimulus';
import { useDebounce } from 'stimulus-use';

export default class extends Controller {
  static debounces = ['submitForm'];

  static targets = [
    'search', 'form', 'list', 'option', 'newButton', 'titleField'
  ];

  // TODO mvoe to stimulus values
  get hoverClasses() {
    return [
      'bg-stone-600'
    ];
  }

  get searchValue() {
    return this.searchTarget.value;
  }

  connect() {
    useDebounce(this);
  }

  change() {
    const value = this.searchValue;

    this.titleFieldTargets.forEach(input => input.value = value);

    if (value.length > 0) {
      this.submitForm();
      this.listTarget.classList.remove('opacity-0');

      if (this.hasNewButtonTarget) {
        this.newButtonTarget.classList.remove('opacity-0');
      }
    } else {
      this.listTarget.classList.add('opacity-0');

      if (this.hasNewButtonTarget) {
        this.newButtonTarget.classList.add('opacity-0');
      }


      requestAnimationFrame(() => {
        this.listTarget.children[0].innerHTML = '';
      });
    }
  }

  submitForm() {
    this.formTarget.dispatchEvent(new CustomEvent('submit', { bubbles: true }));
  }

  blur() {
    this.toggleOptions();
  }

  clear() {
    this.searchTarget.value = '';
    this.change();
    this.blur();
  }

  focus(ev) {
    this.toggleOptions(ev.target);
  }

  toggleOptions(focused) {
    this.optionTargets.forEach(option => {
      if (option === focused) {
        option.classList.add(...this.hoverClasses);

      } else {
        option.classList.remove(...this.hoverClasses);
      }
    });
  }
}
