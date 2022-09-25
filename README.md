# Welcome!

- [Intro](#intro)
- [Setup](#setup)
- [Responders](#responders)
- [Stimulus & Forms](#stimulus--forms)
- [Testing](#testing)
- [Closing](#closing)

## Intro

This repo contains my [September 2022 Rails Hackathon](https://railshackathon.com/) [submission](https://railshackathon.com/entries/2). The theme of the hackathon was Hotwire and Turbo. This page just highlights certain implementation decisions and exists mainly as an educational tool for those seeking to learn more about Rails and Hotwire.

## Setup

Two things worth noting as far as project setup goes.

1. [Shakapacker](https://github.com/shakacode/shakapacker)

   I still have yet to really move on from webpack and thus opted to use Shakapcker, which is a community maintained successor to webpacker. The guide for the gem are actually rather good and thorough and you should be able to get up and running in no time. Once Shakapacker was in place, I then setup TailwindCSS [using PostCSS](https://tailwindcss.com/docs/installation/using-postcss). Tailwind and Hotwire pair together rather well.
   
2. [ViewComponents](https://viewcomponent.org/)

   I've only recently started to use ViewComponent, which is a Rails gem from GitHub. In general, VC helps you DRY up views and "components" into individual component classes and view templates. The [Slots](https://viewcomponent.org/guide/slots.html) feature in particular is very useful for structuring components and views. A simple example in this repo is the `PageComponent`, which defines 3 slot types:
   
   https://github.com/mjc-gh/test-case-bay/blob/96de2d7bd74553d1c4b9ee753a4df74ccc425426/app/components/page_component.rb#L4-L7

   Here is how the "slots" are used in the views:

   https://github.com/mjc-gh/test-case-bay/blob/96de2d7bd74553d1c4b9ee753a4df74ccc425426/app/components/page_component.html.erb#L3-L12

## Responders

I love the [Responders](https://github.com/heartcombo/responders) gem and often reach for it in applications I work on. This gem and it's `Responder` class is designed to DRY up common controller behaviors for CRUD actions and is "[r]esponsible for exposing a resource to different mime requests". This can actually be rather useful in the context of Turbo Streams!

After installing Responders, I added the below method to my `ApplicationResponder` class which is [invoked by Responders here](https://github.com/heartcombo/responders/blob/main/lib/action_controller/responder.rb#L162-L167).

https://github.com/mjc-gh/test-case-bay/blob/96de2d7bd74553d1c4b9ee753a4df74ccc425426/app/lib/application_responder.rb#L11-L16

Now controllers in this application can opt-in to `respond_to :turbo_stream` as such:

https://github.com/mjc-gh/test-case-bay/blob/96de2d7bd74553d1c4b9ee753a4df74ccc425426/app/controllers/case_steps_controller.rb#L8

And easily render both error and succesful responses in a single `respond_with` call:

https://github.com/mjc-gh/test-case-bay/blob/96de2d7bd74553d1c4b9ee753a4df74ccc425426/app/controllers/case_steps_controller.rb#L41

In the above, when the `@step` model instance has one or more error, the `new.turbo_stream.erb` template is used ([source](https://github.com/mjc-gh/test-case-bay/blob/main/app/views/case_steps/new.turbo_stream.erb)). When `@step` is free from errors, the explicit `:render` option is used and the `create.turbo_stream.erb` template is used for the response ([source](https://github.com/mjc-gh/test-case-bay/blob/main/app/views/case_steps/create.turbo_stream.erb)).

At some point, I hope to work a bit more on this and try to open source a Turbo Stream aware Responder that implements a common, well documented `to_turbo_stream` responder format method. Stay tuned on this!

## Stimulus & Forms

Stimulus in general is great tool for front-end development. Overall, this app doesn't have that many Stimulus controllers or JavaScript. Perhaps the most worthwhile thing to point out here and in general is how you can use Stimulus to submit forms and invoke Turbo functionality. For instance, consider this text input and separate form:

https://github.com/mjc-gh/test-case-bay/blob/96de2d7bd74553d1c4b9ee753a4df74ccc425426/app/views/case_steps/_form.html.erb#L1-L7

This text input is used to power the auto-complete functionality of our "test case" builder and will submit the user's text in order to search for matching test steps to suggest to add to the test case. The input has `data-action` that via Stimulus triggers the `change` method ([source](https://github.com/mjc-gh/test-case-bay/blob/main/app/javascript/controllers/case_step_builder_controller.js#L26)) whenever the text input is updated.

https://github.com/mjc-gh/test-case-bay/blob/96de2d7bd74553d1c4b9ee753a4df74ccc425426/app/views/case_steps/_form.html.erb#L19-L22

When `change` is invoked, the controller eventually triggers the form's `submit` event through a debounced `submitForm` method, thus invoking Turbo.

https://github.com/mjc-gh/test-case-bay/blob/96de2d7bd74553d1c4b9ee753a4df74ccc425426/app/javascript/controllers/case_step_builder_controller.js#L52-L54

It's important to note that you have use a `CustomEvent` with `dispatchEvent`. Calling `submit()` on the form DOM element will not trigger DOM events which in turn does not trigger Turbo behavior. [See MDN](https://developer.mozilla.org/en-US/docs/Web/API/HTMLFormElement/submit_event) for more information about the submit event.

|Image|Description|
|-----|-----------|
|![image](https://user-images.githubusercontent.com/82063/192148189-985de30d-7afd-46d9-af62-f98856ef9f99.png)|Initial state with no text yet|
|![image](https://user-images.githubusercontent.com/82063/192148207-663c31fd-d503-40a5-b6d1-d7b5dc442f4a.png)|Text input changed, Stimulus dispatches form, Turbo makes a request, and the auto-complete UI is rendered|

Actually, while we're on the topic of forms and DOM behaviors, it's worth poinint out that [buttons](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/button#attr-form) and [inputs](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#form) both accept a `form` attribute which can be used to associate the element with a form element elsewhere in the DOM. This means you don't necessarily have to nest these elements within their corresponding `<form>` element which is actually rather useful for Turbo and Stimulus. As a quick example, consider this view used when marking test case steps as either "pass" or "fail": 

https://github.com/mjc-gh/test-case-bay/blob/96de2d7bd74553d1c4b9ee753a4df74ccc425426/app/views/assignment_case_steps/edit.html.erb#L3-L17

On lines 3-5 we have the "pass" form without any buttons nested within. On lines 7-17, we have the "fail" form and two UI buttons for "pass" and "fail". Since the "pass" button is not in the "pass" form, it has an explicit `form: dom_id(@step, :pass_btn)` to associate it with the correct form.

## Testing

We all joke that no one has time to write tests in a hackathon, but I do find them actually rather useful for testing more involved turbo functionality. A few quick test cases can save you a lot in the long run as far as QA setup and manual testing goes, especially as you refactor away!

Turbo Rails actually comes with a couple of assertion helpers for turbo-related controller test, you can take a look at these two test helpers [here](https://github.com/hotwired/turbo-rails/blob/main/lib/turbo/test_assertions.rb). The test coverage for application isn't particularly high, however it does have pretty good coverage around some key turbo stream responses. For instance consider the two below test cases that help test out some of the error response behavior handled by the `to_turbo_stream` responder mentioned above:

https://github.com/mjc-gh/test-case-bay/blob/96de2d7bd74553d1c4b9ee753a4df74ccc425426/test/controllers/case_steps_controller_test.rb#L19-L38

To me, this is one of the best features of Turbo and using it with Rails: we can test our turbo stream responses, and thus rich interactive behavior in our applications, with all the familiar comforts and trimmings of Rails testing. How great!

## Closing

Many thanks to the organizers of the [Rails Hackathon](https://railshackathon.com/). I hope this README has bit of info that is helpful to anyone looking to learn more about Rails or Turbo! Thanks for reading! Feel free to examine the application's source code and use it for educational purposes.

Thanks for reading, you can follow me Twitter [here](https://twitter.com/mjc_tw).
