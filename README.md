# `dirs`

[![Build Status][gh-actions-badge]][gh-actions]
[![LFE Versions][lfe-badge]][lfe]
[![Erlang Versions][erlang-badge]][versions]
[![Tags][github-tags-badge]][github-tags]
[![Downloads][hex-downloads]][hex-package]

*A low-level library that provides standard config/cache/data paths, following the respective conventions on Linux, macOS and Windows (port of the Rust `dirs` library to LFE/Erlang)*

[![Project Logo][logo]][logo-large]

## Introduction

- a tiny low-level library with a minimal API
- that provides the platform-specific, user-accessible locations
- for retrieving and storing configuration, cache and other data
- on Linux, Redox, Windows (≥ Vista), macOS and other platforms.

The library provides the location of these directories by leveraging the mechanisms defined by
- the [XDG base directory](https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html) and
  the [XDG user directory](https://www.freedesktop.org/wiki/Software/xdg-user-dirs/) specifications on Linux and Redox
- the [Known Folder](https://msdn.microsoft.com/en-us/library/windows/desktop/dd378457.aspx) API on Windows
- the [Standard Directories](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW6)
  guidelines on macOS

## Platforms

This library is written in LFE but can be used transparently in Erlang or Elixir projects (that support rebar3) as if it was an Erlang library. It supports Linux and macOS; Windows support is pending.

## Usage


Library run by user `alice` in Erlang:

```erlang
1> dirs:home().
%% Lin: /home/alice
%% Win: C:\Users\Alice
%% Mac: /Users/Alice

2> dirs:audio().
%% Lin: /home/alice/Music
%% Win: C:\Users\Alice\Music
%% Mac: /Users/Alice/Music

3> dirs:config().
%% Lin: /home/alice/.config
%% Win: C:\Users\Alice\AppData\Roaming
%% Mac: /Users/Alice/Library/Application Support

4> dirs:executable().
%% Lin: /home/alice/.local/bin
%% Win: undefined
%% Mac: undefined
```

In LFE:

```lisp
lfe> (dirs:home)
;; Lin: /home/alice
;; Win: C:\Users\Alice
;; Mac: /Users/Alice

lfe> (dirs:audio)
;; Lin: /home/alice/Music
;; Win: C:\Users\Alice\Music
;; Mac: /Users/Alice/Music

lfe> (dirs:config)
;; Lin: /home/alice/.config
;; Win: C:\Users\Alice\AppData\Roaming
;; Mac: /Users/Alice/Library/Application Support

lfe> (dirs:executable)
;; Lin: /home/alice/.local/bin
;; Win: undefined
;; Mac: undefined
```

Note that all `dirs:*` functions support an additional arity, allowing one to append one or more path segments to the given directory:

``` erlang
1> dirs:home("lab").
"/Users/oubiwann/lab"
2> dirs:home(["lab", "lfe"]).
"/Users/oubiwann/lab/lfe"
3> dirs:video(["Conferences", "EUC", 2019, drafts]).
"/Users/oubiwann/Movies/Conferences/EUC/2019/drafts"
4> dirs:cache([2023,11,27,d34db33fcafe,0,1,5,12,42]).
"/Users/oubiwann/Library/Caches/2023/11/27/d34db33fcafe/0/1/5/12/42"
```

## Design Goals

- The `dirs` library is a low-level one, designed to provide the paths to standard directories
  as defined by operating systems rules or conventions.<br/>
  If your requirements are more complex, e. g. computing cache, config, etc. paths for specific
  applications or projects, consider writing something higher-level that uses `dirs` -- let us know if you do, and we'll link to it!
- This library does not create directories or check for their existence. The library only provides
  information on what the path to a certain directory _should_ be.<br/>
  How this information is used is a decision that developers need to make based on the requirements
  of each individual application.
- This library is intentionally focused on providing information on user-writable directories only,
  as there is no discernible benefit in returning a path that points to a user-level, writable
  directory on one operating system, but a system-level, read-only directory on another.<br/>
  The confusion and unexpected failure modes of such an approach would be immense.
  - `executable` is specified to provide the path to a user-writable directory for binaries.<br/>
    As such a directory only commonly exists on Linux, it returns `undefined` on macOS and Windows.
  - `font` is specified to provide the path to a user-writable directory for fonts.<br/>
    As such a directory only exists on Linux and macOS, it returns `undefined` on Windows.
  - `runtime` is specified to provide the path to a directory for non-essential runtime data.
    It is required that this directory is created when the user logs in, is only accessible by the
    user itself, is deleted when the user logs out, and supports all filesystem features of the
    operating system.<br/>
    As such a directory only commonly exists on Linux, it returns `undefined` on macOS and Windows.

## Features

| Function name      | Value on Linux/Redox                                                   | Value on Windows (not yet impl)                 | Value on macOS                              |
|--------------------| ---------------------------------------------------------------------- |-----------------------------------| ------------------------------------------- |
| `dirs:home`         | `$HOME`                                                          | `{FOLDERID_Profile}`        | `$HOME`                               |
| `dirs:cache`        | `$XDG_CACHE_HOME`         or `$HOME/.cache`              | `{FOLDERID_LocalAppData}`   | `$HOME/Library/Caches`              |
| `dirs:config`       | `$XDG_CONFIG_HOME`        or `$HOME/.config`             | `{FOLDERID_RoamingAppData}` | `$HOME/Library/Application Support` |
| `dirs:config_local` and `dirs:config-local`| `$XDG_CONFIG_HOME`        or `$HOME/.config`             | `{FOLDERID_LocalAppData}`   | `$HOME/Library/Application Support` |
| `dirs:data`         | `$XDG_DATA_HOME`          or `$HOME/.local/share`       | `{FOLDERID_RoamingAppData}` | `$HOME/Library/Application Support` |
| `dirs:data_local` and `dirs::data-local`   | `$XDG_DATA_HOME`          or `$HOME/.local/share`        | `{FOLDERID_LocalAppData}`   | `$HOME/Library/Application Support` |
| `dirs:executable`   | `$XDG_BIN_HOME`           or `$HOME/.local/bin`          | `undefined`                            | `undefined`                                      |
| `dirs:preference`   | `$XDG_CONFIG_HOME`        or `$HOME/.config`             | `{FOLDERID_RoamingAppData}` | `$HOME/Library/Preferences`         |
| `dirs:runtime`      | `$XDG_RUNTIME_DIR`        or `undefined`                              | `undefined`                            | `undefined`                                      |
| `dirs:state`        | `$XDG_STATE_HOME`         or `$HOME/.local/state`        | `undefined`                            | `undefined`                                      |
| `dirs:audio`        | `XDG_MUSIC_DIR`           or `undefined`                              | `{FOLDERID_Music}`          | `$HOME/Music`                      |
| `dirs:desktop`      | `XDG_DESKTOP_DIR`         or `undefined`                              | `{FOLDERID_Desktop}`        | `$HOME/Desktop`                    |
| `dirs:document`     | `XDG_DOCUMENTS_DIR`       or `undefined`                              | `{FOLDERID_Documents}`      | `$HOME/Documents`                  |
| `dirs:download`     | `XDG_DOWNLOAD_DIR`        or `undefined`                              | `{FOLDERID_Downloads}`      | `$HOME/Downloads`                  |
| `dirs:font`         | `$XDG_DATA_HOME/fonts` or `$HOME/.local/share/fonts` | `undefined`                            | `$HOME/Library/Fonts`              |
| `dirs:picture`      | `XDG_PICTURES_DIR`        or `undefined`                              | `{FOLDERID_Pictures}`       | `$HOME/Pictures`                   |
| `dirs:public`       | `XDG_PUBLICSHARE_DIR`     or `undefined`                              | `{FOLDERID_Public}`         | `$HOME/Public`                     |
| `dirs:template`     | `XDG_TEMPLATES_DIR`       or `undefined`                              | `{FOLDERID_Templates}`      | `undefined`                                      |
| `dirs:video`        | `XDG_VIDEOS_DIR`          or `undefined`                              | `{FOLDERID_Videos}`         | `$HOME/Movies`                     |


## License

Apache License, Version 2.0

Copyright © 2023-2025, Duncan McGreggor <oubiwann@gmail.com>.

[//]: ---Named-Links---

[logo]: priv/images/logo.png
[logo-large]: priv/images/logo-large.png
[screenshot]: priv/images/screenshot.png
[gh-actions-badge]: https://github.com/lfex/dirs/workflows/ci%2Fcd/badge.svg
[gh-actions]: https://github.com/lfex/dirs/actions
[lfe]: https://github.com/lfe/lfe
[lfe-badge]: https://img.shields.io/badge/lfe-2.1+-blue.svg
[erlang-badge]: https://img.shields.io/badge/erlang-21%20to%2025-blue.svg
[versions]: https://github.com/lfex/dirs/blob/main/rebar.config
[github-tags]: https://github.com/lfex/dirs/tags
[github-tags-badge]: https://img.shields.io/github/tag/lfex/dirs.svg
[github-downloads]: https://img.shields.io/github/downloads/ut-proj/underack/total.svg
[hex-badge]: https://img.shields.io/hexpm/v/underack.svg?maxAge=2592000
[hex-package]: https://hex.pm/packages/underack
[hex-downloads]: https://img.shields.io/hexpm/dt/underack.svg
