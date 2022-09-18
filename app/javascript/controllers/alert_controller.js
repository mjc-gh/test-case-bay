import { Controller } from '@hotwired/stimulus';

async function delay(duration) {
  return new Promise(resolve => {
    setTimeout(() => resolve(), duration);
  });
}

export default class extends Controller {
  async close() {
    this.element.classList.add('bottom-full', 'translate-y-[-100%]');

    await delay(500);

    this.element.remove();
  }
}
