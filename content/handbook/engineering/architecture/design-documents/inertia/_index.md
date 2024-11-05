---
title: "'Modern monolith' SPA frontend architecture with Inertia"
status: proposed
creation-date: "2024-11-05"
authors: ["@thutterer"]
coaches: ["@leipert"]
dris: ["@jtucker_gl", "@samdbeckham"]
owning-stage: "~devops::foundations"
participating-stages: []
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

<!-- Design Doucments often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->

{{< design-document-header >}}

## Summary

Most of our new frontend features are implemented with Vue and GraphQL. But when it comes to navigating _between_ different pages, we are still limited to full page loads and server-rendered HTML responses.
This makes browsing GitLab feel slower than it could be, because:

- Nowadays, all the app's main navigation (left sidebar, breadcrumbs, right drawer) are interactive Vue components already, yet we have to recreate them from scratch on every page load.
- And most (new) pages are implemented as Vue apps. So on many pages, 100% of what you see is rendered with Vue, yet we have to init many indivual Vue _apps_ in DOM, making everything slower, less interactive, and requiring lots of boilerplate code.

**This design document suggests we add [Inertia](https://inertiajs.com/) to our codebase and use it for pages where already most or all of their content is made up by Vue.** Navigating between such pages with Inertia only takes a fraction of the time it would take to do a full page load, as all that goes "over the wire" is a small chunk of JSON with the needed data to display another Vue component as the next "[page](https://inertiajs.com/pages)", instead of building and sending a full HTML page.

## Motivation

This new approach would benefit both our users' experience (UX) and our own developer experience (DX).

### Goals

#### Improved UX

Navigating with Inertia feels much smoother, especially on slow network connections, or on pages that are slow to respond.
Because today, we rebuild the entire DOM from scratch on every page load, and the init multiple Vue apps.
So if you are on a slow connection or non-performant device, you will eventually see a "flash of white" where the browser hasn't done all the work to rerender the sidebar navigation, breadcrumbs, and the actual page.

With Inertia page visits, the page layout stays visible and active while going from one page to the next, and only the page content is swapped out.

This also means that way less data is sent over the network. Only the inital page load for the first page you open sends the server-rendered `index.html` and inits the Vue layout components.
For sub-sequent visits, only the required `props` data for the next page Vue component is sent via JSON, removing all HTML boilerplate that we today send over the wire on every page load, making page visits feel faster and smoother.

#### Improved DX

Every frontend dev at GitLab knows the hoops to jump through when you want a new Vue app to be initialized on a certain page. While the current approach works and is used hundreds of times, it's also hundreds of repetitions. That is not DRY, impossible to test, takes time to review, and is pure boilerplate.

Inertia offers a simple yet powerful solution to organize pages (which are just Vue components) in a folder structure and have them auto-init, with all their required props, from the Rails controller level.

At the same time, this still feels familiar to how we do Rails today. We can use all Ruby features and Rails conventions to create the data/props for the response, using existing helpers etc. The only thing we change is the response format, from HTML to JSON. See [how Intertia works](https://inertiajs.com/how-it-works) for more details.

#### Future opportunities

Building on this idea, this opens to door for lots of things that are not possible today. Like truely keeping state between page visits.

##### Keeping state between visits

One use for this could be Duo Chat, which could keep its drawer open and context available, while the user (or Duo Chat itself!) navigates to a different page.

##### SSR

Inertia also supports rendering its Vue pages [server-side](https://inertiajs.com/server-side-rendering). We haven't explored this further yet, but assuming this works for us, this would be another advantage over the current mix of SSR (Rails/Haml) and client-side rendering.

### Non-Goals

#### No radical change right now

This proposal does not suggest to immediately stop writing any Haml. It would be unrealistic to assume we could do this migration in one big bang.

One of the benefits of this approach is actually that we can do this in any pace that we think is best. We can take it slow if we want or have to. It's not a "all now, or nothing ever" approach, but keeps everything old working as is, while it allows us to build new parts on this approach, and migrate older parts when there is an opportunity to do so.

There might even be parts were can settle on the existing Haml pages, like the sign-in pages, as these use a simpler layout (no sidebar, breadcrumbs or duo) anyway.

## Proposal

A proof-of-concept MR of the following steps can be found here: https://gitlab.com/gitlab-org/gitlab/-/merge_requests/165637

- Add Inertia to our codebase behind a feature flag. It consists of the [`inertia-rails`](https://github.com/inertiajs/inertia-rails) gem for the server side, and a npm package for the [client side](https://inertiajs.com/client-side-setup).
- Recreate the current page layout (Left sidebar, breadcrumbs, duo chat drawer) as an Inertia layout.
- Start migrating pages that already are 100% Vue apps to render with with Inertia.
- Now when a user navigates from one Inertia-rendered page to another Inertia-rendered page, the layout components stay "alive", and only the page content is updated.
- At the same time, this approach doesn't break any existing Haml-based pages. We can iterate page by page, migrate Haml pages to Vue first (which is a benefit in itself) and in a later step swap out how these pages are init, removing _a lot_ of custom code, as Inertia provides a nice off-the-shelf solutution to organize and init Vue app as pages.
- Keep iterating to migrate the majority of pages to be Inertia-rendered.

## Design and implementation details

_While this doc is in its earliest stages, please see this [POC MR](https://gitlab.com/gitlab-org/gitlab/-/merge_requests/165637) for code examples._

See the _Proposal_ section for the big picture idea. See below for some details that are known already.

### Challenges and considerations

#### `inertia-rails` gem

Inertia is more commonly used in the Laravel community. The Rails gem is maintained by a smaller community.
We easily would be one of the largest monoliths starting to adopt it for Rails.

If we commit to Inertia, we should be ready to actually `git commit` back to `intertia-rails`.

#### inertiajs/vue2 npm package

⚠️ **This is where it gets a bit messy** While there is a official Inertia adapter for Vue 2, this will stop working with the next major release of Inertia. This [v2](https://v2.inertiajs.com/upgrade-guide) release is already in beta, and it **will drop support for Vue2**.

Starting out with Inertia v1 and our Vue2 might work (It does in the POC.), but it might also create another dependency blocker when we finally move GitLab to Vue 3, as it is unknown if Inertia's Vue3 adapter would work in `compat` mode.

**Possible solution**: We are confident that we could update the current Vue2 adapter to work with the upcoming Inertia 2, and either contribute that upstream, or just create our own fork, for the time while we still use Vue2.

#### Links in Markdown content

To get the faster page visits with Inertia, links between pages have to be done with the special Inertia `<Link>` component, which is just an `<a>` with a surrounding event handler to do the Ajax request. We will have to tweak our Markdown2HTML rendering to be aware when to use a classic `a` and when a `Link`, depending on the target page. But this is not a blocker. Having the normal `a` tags would just be today's behavior with a full page load.

Something similar is already implemented for the sidbar nav links in the prototype MR.

#### No more "cold start" on every page load

Today, every page load "resets" everything JS-related to zero, and rebuilds it. While this has all the downsides described above, it also has the hidden benefit of built-in garbage collection. Any memory leak is shut by just starting over.

With Inerta, in case we have existing Vue components with memory leaks (like not cleaning up event handlers), we would now be much more likely to run into these memory leaks, because we never do such a full "reset".

#### Differences in how redirects, rails flash and history are handled

Inertia can handle [redirects](https://inertiajs.com/redirects), but it requires some caution.
Same for flash messages. These need to be handled as props and rendered by the Vue layout component.
Browser history is maintained by Inertia. We need to test that nothing breaks here while mixing both Inertia and non-Inertia navigations.

#### Layout duplication

We would need to duplicate our current Haml layout with a new Inertia Vue component, that also loads the sidebar, breadcrumbs, etc, and lays them out _exactly_ like the Haml one, down to the last pixel, to not give away which page is an Inertia page already, and which one isn't yet.

Since migrating _everything_ to be rendered by Vue could take a long time, we will have this duplicated page layout for the time being.

But given that its main parts are all Vue components already today (sidebar, breadcrumbs, duo chat), recreating the same layout was pretty easy and (sort of) works already in the POC.

**Possible solution:** We had the idea of creating a "Haml-wrapping Inertia page", so a Vue app that gets some HTML as prop and renders that as its contents. This could - theoretically - enable any existing Haml page to be migrated to Inertia already. But of course, any page-specific JS has to be carried over for each page. The POC implements this idea for the Milestones dashboard as an example. This worked pretty well without much effort!

#### No real page loads to analyze/track

This would definitely need a few tweaks to support tracking page visits, but shouldn't be too complicated to make this work with our existing systems. We just have to fire these tracking events on Inertia visits (or `Link` clicks).
