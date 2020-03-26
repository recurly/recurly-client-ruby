# Change Log

## [3.4.0](https://github.com/recurly/recurly-client-ruby/tree/3.4.0) (2020-03-23)
[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/3.3.1...3.4.0)

**Implemented enhancements:**

- Replace Faraday gem with Net::HTTP, add connection pooling & keep-alive, update CA roots [\#568](https://github.com/recurly/recurly-client-ruby/pull/568) ([isaachall](https://github.com/isaachall))

**Merged pull requests:**

- Release 3.4.0 [\#569](https://github.com/recurly/recurly-client-ruby/pull/569) ([bhelx](https://github.com/bhelx))

## [3.3.1](https://github.com/recurly/recurly-client-ruby/tree/3.3.1) (2020-03-20)
[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/3.3.0...3.3.1)

**Merged pull requests:**

- Release 3.3.1 [\#567](https://github.com/recurly/recurly-client-ruby/pull/567) ([douglasmiller](https://github.com/douglasmiller))
- Adding changelog and updated release scripts [\#566](https://github.com/recurly/recurly-client-ruby/pull/566) ([douglasmiller](https://github.com/douglasmiller))
- Thu Mar 19 21:04:19 UTC 2020 Upgrade API version v2019-10-10 [\#564](https://github.com/recurly/recurly-client-ruby/pull/564) ([douglasmiller](https://github.com/douglasmiller))
- Update rake to 12.3.3 [\#561](https://github.com/recurly/recurly-client-ruby/pull/561) ([douglasmiller](https://github.com/douglasmiller))
- Add request for stack trace in issue report [\#558](https://github.com/recurly/recurly-client-ruby/pull/558) ([bhelx](https://github.com/bhelx))

## [3.3.0](https://github.com/recurly/recurly-client-ruby/tree/3.3.0) (2020-02-20)
[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/3.2.2...3.3.0)

**Merged pull requests:**

- Release 3.3.0 [\#556](https://github.com/recurly/recurly-client-ruby/pull/556) ([bhelx](https://github.com/bhelx))
- Latest generated changes for v2019-10-10 [\#555](https://github.com/recurly/recurly-client-ruby/pull/555) ([bhelx](https://github.com/bhelx))
- Link to new dev docs for webhooks [\#554](https://github.com/recurly/recurly-client-ruby/pull/554) ([bhelx](https://github.com/bhelx))
- Latest v2019-10-10 Changes [\#552](https://github.com/recurly/recurly-client-ruby/pull/552) ([bhelx](https://github.com/bhelx))

## [3.2.2](https://github.com/recurly/recurly-client-ruby/tree/3.2.2) (2020-02-03)
[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/3.2.1...3.2.2)

**Merged pull requests:**

- Release 3.2.2 [\#550](https://github.com/recurly/recurly-client-ruby/pull/550) ([bhelx](https://github.com/bhelx))
- Loosen version restriction on faraday [\#549](https://github.com/recurly/recurly-client-ruby/pull/549) ([bhelx](https://github.com/bhelx))

## [3.2.1](https://github.com/recurly/recurly-client-ruby/tree/3.2.1) (2019-12-10)
[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/3.2.0...3.2.1)

**Fixed bugs:**

- Convert Array params to CSV strings [\#545](https://github.com/recurly/recurly-client-ruby/pull/545) ([douglasmiller](https://github.com/douglasmiller))

## [3.2.0](https://github.com/recurly/recurly-client-ruby/tree/3.2.0) (2019-12-03)
[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/3.1.3...3.2.0)

**Fixed bugs:**

- It's hard to find out what payment method was used [\#543](https://github.com/recurly/recurly-client-ruby/issues/543)
- Implement way to actually get ErrorMayHaveTransaction [\#540](https://github.com/recurly/recurly-client-ruby/issues/540)

**Merged pull requests:**

- Release 3.2.0 [\#544](https://github.com/recurly/recurly-client-ruby/pull/544) ([bhelx](https://github.com/bhelx))
- Allow object attributes through [\#542](https://github.com/recurly/recurly-client-ruby/pull/542) ([bhelx](https://github.com/bhelx))

## [3.1.3](https://github.com/recurly/recurly-client-ruby/tree/3.1.3) (2019-12-02)
[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/3.1.2...3.1.3)

**Fixed bugs:**

- Getting ArgumentError instead of Recurly::Errors::ValidationError [\#538](https://github.com/recurly/recurly-client-ruby/issues/538)
- Issue 540 error may have transaction [\#541](https://github.com/recurly/recurly-client-ruby/pull/541) ([bhelx](https://github.com/bhelx))

## [3.1.2](https://github.com/recurly/recurly-client-ruby/tree/3.1.2) (2019-12-02)
[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/3.1.1...3.1.2)

**Fixed bugs:**

- Skip request property type validation for nil values [\#539](https://github.com/recurly/recurly-client-ruby/pull/539) ([bhelx](https://github.com/bhelx))

## [3.1.1](https://github.com/recurly/recurly-client-ruby/tree/3.1.1) (2019-11-27)
[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/3.1.0...3.1.1)

**Fixed bugs:**

- Undefined method cast [\#536](https://github.com/recurly/recurly-client-ruby/issues/536)
- Disable searching ancestors when looking up constants [\#537](https://github.com/recurly/recurly-client-ruby/pull/537) ([douglasmiller](https://github.com/douglasmiller))

## [3.1.0](https://github.com/recurly/recurly-client-ruby/tree/3.1.0) (2019-11-18)
[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/3.0.0...3.1.0)

**Merged pull requests:**

- Release 3.1.0 [\#530](https://github.com/recurly/recurly-client-ruby/pull/530) ([bhelx](https://github.com/bhelx))
- Generated Updates for API version v2019-10-10 [\#529](https://github.com/recurly/recurly-client-ruby/pull/529) ([douglasmiller](https://github.com/douglasmiller))
- Generated Updates for API version v2019-10-10 [\#528](https://github.com/recurly/recurly-client-ruby/pull/528) ([bhelx](https://github.com/bhelx))

## [3.0.0](https://github.com/recurly/recurly-client-ruby/tree/3.0.0) (2019-10-09)
[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/3.0.0.beta.5...3.0.0)

**Merged pull requests:**

- Release 3.0.0 [\#521](https://github.com/recurly/recurly-client-ruby/pull/521) ([bhelx](https://github.com/bhelx))
- Upgrade API version v2019-10-10 [\#519](https://github.com/recurly/recurly-client-ruby/pull/519) ([bhelx](https://github.com/bhelx))
- Update recurly.gemspec [\#518](https://github.com/recurly/recurly-client-ruby/pull/518) ([bhelx](https://github.com/bhelx))
- Add a script for releasing [\#517](https://github.com/recurly/recurly-client-ruby/pull/517) ([bhelx](https://github.com/bhelx))
- Change base url to v3.recurly.com [\#516](https://github.com/recurly/recurly-client-ruby/pull/516) ([bhelx](https://github.com/bhelx))
- No longer need bundler 1.7 [\#511](https://github.com/recurly/recurly-client-ruby/pull/511) ([bhelx](https://github.com/bhelx))
- Refactor internal schema representation [\#510](https://github.com/recurly/recurly-client-ruby/pull/510) ([bhelx](https://github.com/bhelx))
- Implement bump script [\#507](https://github.com/recurly/recurly-client-ruby/pull/507) ([bhelx](https://github.com/bhelx))
- Remove the site-id constraint from Client [\#504](https://github.com/recurly/recurly-client-ruby/pull/504) ([bhelx](https://github.com/bhelx))
- Only set strict mode when env explicitly true [\#501](https://github.com/recurly/recurly-client-ruby/pull/501) ([bhelx](https://github.com/bhelx))
- Document use of webhooks [\#500](https://github.com/recurly/recurly-client-ruby/pull/500) ([bhelx](https://github.com/bhelx))
- Latest v2018-08-09 Updates [\#498](https://github.com/recurly/recurly-client-ruby/pull/498) ([bhelx](https://github.com/bhelx))
- Refer user to rubydoc.info [\#497](https://github.com/recurly/recurly-client-ruby/pull/497) ([bhelx](https://github.com/bhelx))
- Expose HTTP request and response metadata [\#488](https://github.com/recurly/recurly-client-ruby/pull/488) ([bhelx](https://github.com/bhelx))
- Add CONTRIBUTING.md [\#486](https://github.com/recurly/recurly-client-ruby/pull/486) ([bhelx](https://github.com/bhelx))
- Bump 3.0.0.beta.6 [\#485](https://github.com/recurly/recurly-client-ruby/pull/485) ([bhelx](https://github.com/bhelx))
-  Latest v2018-08-09 Changes [\#484](https://github.com/recurly/recurly-client-ruby/pull/484) ([bhelx](https://github.com/bhelx))

## [3.0.0.beta.5](https://github.com/recurly/recurly-client-ruby/tree/3.0.0.beta.5) (2019-06-28)
[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/3.0.0.beta.4...3.0.0.beta.5)

**Merged pull requests:**

- 3.0.0.beta.5 [\#483](https://github.com/recurly/recurly-client-ruby/pull/483) ([bhelx](https://github.com/bhelx))
- Latest v2018-08-09 Changes [\#482](https://github.com/recurly/recurly-client-ruby/pull/482) ([bhelx](https://github.com/bhelx))
- no longer need dep scripts [\#476](https://github.com/recurly/recurly-client-ruby/pull/476) ([bhelx](https://github.com/bhelx))
- Add format script and check in specs [\#474](https://github.com/recurly/recurly-client-ruby/pull/474) ([bhelx](https://github.com/bhelx))
- Url Encode Path items [\#472](https://github.com/recurly/recurly-client-ruby/pull/472) ([bhelx](https://github.com/bhelx))
- Add strict mode for json deserializer [\#469](https://github.com/recurly/recurly-client-ruby/pull/469) ([bhelx](https://github.com/bhelx))

## [3.0.0.beta.4](https://github.com/recurly/recurly-client-ruby/tree/3.0.0.beta.4) (2019-04-04)
[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/3.0.0.beta.3...3.0.0.beta.4)

**Merged pull requests:**

- V3 Update v2018-08-09 [\#460](https://github.com/recurly/recurly-client-ruby/pull/460) ([aaron-suarez](https://github.com/aaron-suarez))
- Small fixes for private beta [\#458](https://github.com/recurly/recurly-client-ruby/pull/458) ([bhelx](https://github.com/bhelx))
- Use Net-http-persistent for persistent connection [\#408](https://github.com/recurly/recurly-client-ruby/pull/408) ([bhelx](https://github.com/bhelx))

## [3.0.0.beta.3](https://github.com/recurly/recurly-client-ruby/tree/3.0.0.beta.3) (2018-08-27)
[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/3.0.0.beta.2...3.0.0.beta.3)

**Merged pull requests:**

- Update to API 2018-06-06 [\#407](https://github.com/recurly/recurly-client-ruby/pull/407) ([bhelx](https://github.com/bhelx))
- Regenerating the client [\#406](https://github.com/recurly/recurly-client-ruby/pull/406) ([drewish](https://github.com/drewish))
- V3 Pager can error [\#401](https://github.com/recurly/recurly-client-ruby/pull/401) ([drewish](https://github.com/drewish))
- \[V3\] Test more versions of ruby [\#397](https://github.com/recurly/recurly-client-ruby/pull/397) ([drewish](https://github.com/drewish))
- Allow faraday 0.12 for compatibility with oauth2 gem [\#396](https://github.com/recurly/recurly-client-ruby/pull/396) ([drewish](https://github.com/drewish))

## [3.0.0.beta.2](https://github.com/recurly/recurly-client-ruby/tree/3.0.0.beta.2) (2018-07-17)
[Full Changelog](https://github.com/recurly/recurly-client-ruby/compare/3.0.0.beta.1...3.0.0.beta.2)



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*