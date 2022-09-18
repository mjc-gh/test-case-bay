import { cookie } from 'cookie.js';
import jstz from 'jstimezonedetect';

import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  connect() {
    this.tz = jstz.determine();
    this.tzName = jstz.determine().name();

    cookie.set('TZ', this.tzName, { path: '/' });
  }
}
