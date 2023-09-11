// allow vimium_c (and other extensions) to be used on mozilla.org & other sites restricted by default
user_pref('privacy.resistFingerprinting.block_mozAddonManager', true);
user_pref('extensions.webextensions.restrictedDomains', '');

// load userChrome.css customizations
user_pref('toolkit.legacyUserProfileCustomizations.stylesheets', true);

// scaling
user_pref('layout.css.devPixelsPerPx', 1.5);

// disable pasting w/ middlemouse button
user_pref('middlemouse.paste', false)

// hardware acceleration
user_pref('media.ffmpeg.vaapi.enabled', true);
user_pref('media.ffvpx.enabled', false);
user_pref('media.rdd-vpx.enabled', false);
user_pref('media.navigator.mediadatadecoder_vpx_enabled', true);

// disable alt key popping top menu
user_pref('ui.key.menuAccessKeyFocuses', false);

// etc
user_pref("general.warnOnAboutConfig", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("pdfjs.enableScripting", false);
user_pref("browser.urlbar.suggest.quicksuggest", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.onboarding.enabled", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("extensions.pocket.enabled", false);
user_pref("view_source.wrap_long_lines", true);
user_pref("network.prefetch-next", false);
user_pref("media.video_stats.enabled", false);
user_pref("network.dns.disablePrefetch", true);
user_pref("geo.enabled", false);
user_pref("browser.newtab.preload", false);
user_pref("browser.newtabpage.activity-stream.disableSnippets", true);
user_pref("browser.newtabpage.activity-stream.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.migrationExpired", true);
user_pref("browser.newtabpage.activity-stream.prerender", false);
user_pref("browser.newtabpage.activity-stream.showSearch", false);
user_pref("browser.newtabpage.activity-stream.showTopSites", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.newtabpage.directory.source", "");
user_pref("browser.newtabpage.directory.ping", "");
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtabpage.enhanced", false);
user_pref("browser.newtabpage.introShown", true);
user_pref("browser.search.region", "EN");
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("toolkit.telemetry.server", "");
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("browser.selfsupport.url", "");
user_pref("browser.send_pings", false);
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("beacon.enabled", false);
user_pref("loop.logDomains", false);
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");
user_pref("extensions.shield-recipe-client.enabled", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("network.allow-experiments", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("experiments.supported", false);
user_pref("experiments.enabled", false);
user_pref("experiments.manifest.uri", "");
user_pref("media.eme.enabled", false);
user_pref("media.gmp-widevinecdm.enabled", false);
user_pref("security.ssl.disable_session_identifiers", true);
user_pref("signon.rememberSignons", false);
user_pref("browser.formfill.enable", false);
user_pref("browser.download.manager.retention", 0);
user_pref("browser.safebrowsing.downloads.remote.enabled",false);
user_pref("general.buildID.override", "20100101");
user_pref("browser.startup.homepage_override.buildID", "20100101");
user_pref("gfx.font_rendering.opentype_svg.enabled", false);

// dns over http - https://wiki.mozilla.org/Trusted_Recursive_Resolver
user_pref("network.trr.mode", 5);
user_pref("network.trr.default_provider_uri", "https://mozilla.cloudflare-dns.com/dns-query");
user_pref("network.trr.uri", "https://mozilla.cloudflare-dns.com/dns-query");
user_pref("network.trr.custom_uri", "https://mozilla.cloudflare-dns.com/dns-query");
user_pref("network.trr.bootstrapAddress", "1.1.1.1");

// don't allow websites to highjack rightclick context menu
// user_pref("dom.event.contextmenu.enabled", false);

// oscp
user_pref("security.ssl.enable_ocsp_stapling", false);
user_pref("security.OCSP.enabled", 0);
user_pref("security.OCSP.require", false);

// disable recommendation pane in about:addons (uses google analytics)
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);

// more telemetry (some duplicates)
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("toolkit.coverage.opt-out", true);
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("browser.ping-centre.telemetry", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);

// crash reports
user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
