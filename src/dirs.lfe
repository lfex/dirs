(defmodule dirs
  (export
   (home 0)
   (cache 0)
   (config 0) (config-local 0) (config_local 0)
   (data 0) (data-local 0) (data_local 0)
   (executable 0)
   (preference 0)
   (runtime 0)
   (state 0)
   (audio 0)
   (desktop 0)
   (document 0)
   (download 0)
   (font 0)
   (picture 0)
   (public 0)
   (template 0)
   (video 0)))

;;; Returns the path to the user's home directory.
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value                | Example        |
;;; | ------- | -------------------- | -------------- |
;;; | Linux   | `$HOME`              | /home/alice    |
;;; | macOS   | `$HOME`              | /Users/Alice   |
;;; | Windows | `{FOLDERID_Profile}` | C:\Users\Alice |
;;;
;;; ### Linux and macOS:
;;;
;;; - Use `$HOME` if it is set and not empty.
;;; - If `$HOME` is not set or empty, then the function `getpwuid_r` is used to determine
;;;   the home directory of the current user.
;;; - If `getpwuid_r` lacks an entry for the current user id or the home directory field is empty,
;;;   then the function returns `None`.
;;;
;;; ### Windows:
;;;
;;; This function retrieves the user profile folder using `SHGetKnownFolderPath`.
;;;
;;; All the examples on this page mentioning `$HOME` use this behavior.
;;;

(defun home() (dispatch 'home))

;;; Returns the path to the user's cache directory.
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value                               | Example                      |
;;; | ------- | ----------------------------------- | ---------------------------- |
;;; | Linux   | `$XDG_CACHE_HOME` or `$HOME`/.cache | /home/alice/.cache           |
;;; | macOS   | `$HOME`/Library/Caches              | /Users/Alice/Library/Caches  |
;;; | Windows | `{FOLDERID_LocalAppData}`           | C:\Users\Alice\AppData\Local |

(defun cache() (dispatch 'cache))

;;; Returns the path to the user's config directory.
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value                                 | Example                                  |
;;; | ------- | ------------------------------------- | ---------------------------------------- |
;;; | Linux   | `$XDG_CONFIG_HOME` or `$HOME`/.config | /home/alice/.config                      |
;;; | macOS   | `$HOME`/Library/Application Support   | /Users/Alice/Library/Application Support |
;;; | Windows | `{FOLDERID_RoamingAppData}`           | C:\Users\Alice\AppData\Roaming           |

(defun config() (dispatch 'config))

;;; Returns the path to the user's local config directory.
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value                                 | Example                                  |
;;; | ------- | ------------------------------------- | ---------------------------------------- |
;;; | Linux   | `$XDG_CONFIG_HOME` or `$HOME`/.config | /home/alice/.config                      |
;;; | macOS   | `$HOME`/Library/Application Support   | /Users/Alice/Library/Application Support |
;;; | Windows | `{FOLDERID_LocalAppData}`             | C:\Users\Alice\AppData\Local             |

(defun config-local() (dispatch 'config-local))
(defun config_local() (dispatch 'config-local)) ; for Erlanger's

;;; Returns the path to the user's data directory.
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value                                    | Example                                  |
;;; | ------- | ---------------------------------------- | ---------------------------------------- |
;;; | Linux   | `$XDG_DATA_HOME` or `$HOME`/.local/share | /home/alice/.local/share                 |
;;; | macOS   | `$HOME`/Library/Application Support      | /Users/Alice/Library/Application Support |
;;; | Windows | `{FOLDERID_RoamingAppData}`              | C:\Users\Alice\AppData\Roaming           |

(defun data() (dispatch 'data))

;;; Returns the path to the user's local data directory.
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value                                    | Example                                  |
;;; | ------- | ---------------------------------------- | ---------------------------------------- |
;;; | Linux   | `$XDG_DATA_HOME` or `$HOME`/.local/share | /home/alice/.local/share                 |
;;; | macOS   | `$HOME`/Library/Application Support      | /Users/Alice/Library/Application Support |
;;; | Windows | `{FOLDERID_LocalAppData}`                | C:\Users\Alice\AppData\Local             |

(defun data-local() (dispatch 'data-local))
(defun data_local() (dispatch 'data-local)) ; for Erlanger's

;;; Returns the path to the user's executable directory.
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value                                                            | Example                |
;;; | ------- | ---------------------------------------------------------------- | ---------------------- |
;;; | Linux   | `$XDG_BIN_HOME` or `$XDG_DATA_HOME`/../bin or `$HOME`/.local/bin | /home/alice/.local/bin |
;;; | macOS   | –                                                                | –                      |
;;; | Windows | –                                                                | –                      |

(defun executable() (dispatch 'executable))

;;; Returns the path to the user's preference directory.
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value                                 | Example                          |
;;; | ------- | ------------------------------------- | -------------------------------- |
;;; | Linux   | `$XDG_CONFIG_HOME` or `$HOME`/.config | /home/alice/.config              |
;;; | macOS   | `$HOME`/Library/Preferences           | /Users/Alice/Library/Preferences |
;;; | Windows | `{FOLDERID_RoamingAppData}`           | C:\Users\Alice\AppData\Roaming   |

(defun preference() (dispatch 'preference))

;;; Returns the path to the user's runtime directory.
;;;
;;; The runtime directory contains transient, non-essential data (like sockets or named pipes) that
;;; is expected to be cleared when the user's session ends.
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value              | Example         |
;;; | ------- | ------------------ | --------------- |
;;; | Linux   | `$XDG_RUNTIME_DIR` | /run/user/1001/ |
;;; | macOS   | –                  | –               |
;;; | Windows | –                  | –               |

(defun runtime() (dispatch 'runtime))

;;; Returns the path to the user's state directory.
;;;
;;; The state directory contains data that should be retained between sessions (unlike the runtime
;;; directory), but may not be important/portable enough to be synchronized across machines (unlike
;;; the config/preferences/data directories).
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value                                     | Example                  |
;;; | ------- | ----------------------------------------- | ------------------------ |
;;; | Linux   | `$XDG_STATE_HOME` or `$HOME`/.local/state | /home/alice/.local/state |
;;; | macOS   | –                                         | –                        |
;;; | Windows | –                                         | –                        |

(defun state() (dispatch 'state))

;;; Returns the path to the user's audio directory.
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value              | Example              |
;;; | ------- | ------------------ | -------------------- |
;;; | Linux   | `XDG_MUSIC_DIR`    | /home/alice/Music    |
;;; | macOS   | `$HOME`/Music      | /Users/Alice/Music   |
;;; | Windows | `{FOLDERID_Music}` | C:\Users\Alice\Music |

(defun audio() (dispatch 'audio))

;;; Returns the path to the user's desktop directory.
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value                | Example                |
;;; | ------- | -------------------- | ---------------------- |
;;; | Linux   | `XDG_DESKTOP_DIR`    | /home/alice/Desktop    |
;;; | macOS   | `$HOME`/Desktop      | /Users/Alice/Desktop   |
;;; | Windows | `{FOLDERID_Desktop}` | C:\Users\Alice\Desktop |

(defun desktop() (dispatch 'desktop))

;;; Returns the path to the user's document directory.
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value                  | Example                  |
;;; | ------- | ---------------------- | ------------------------ |
;;; | Linux   | `XDG_DOCUMENTS_DIR`    | /home/alice/Documents    |
;;; | macOS   | `$HOME`/Documents      | /Users/Alice/Documents   |
;;; | Windows | `{FOLDERID_Documents}` | C:\Users\Alice\Documents |

(defun document() (dispatch 'document))

;;; Returns the path to the user's download directory.
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value                  | Example                  |
;;; | ------- | ---------------------- | ------------------------ |
;;; | Linux   | `XDG_DOWNLOAD_DIR`     | /home/alice/Downloads    |
;;; | macOS   | `$HOME`/Downloads      | /Users/Alice/Downloads   |
;;; | Windows | `{FOLDERID_Downloads}` | C:\Users\Alice\Downloads |

(defun download() (dispatch 'download))

;;; Returns the path to the user's font directory.
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value                                                | Example                        |
;;; | ------- | ---------------------------------------------------- | ------------------------------ |
;;; | Linux   | `$XDG_DATA_HOME`/fonts or `$HOME`/.local/share/fonts | /home/alice/.local/share/fonts |
;;; | macOS   | `$HOME/Library/Fonts`                                | /Users/Alice/Library/Fonts     |
;;; | Windows | –                                                    | –                              |

(defun font() (dispatch 'font))

;;; Returns the path to the user's picture directory.
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value                 | Example                 |
;;; | ------- | --------------------- | ----------------------- |
;;; | Linux   | `XDG_PICTURES_DIR`    | /home/alice/Pictures    |
;;; | macOS   | `$HOME`/Pictures      | /Users/Alice/Pictures   |
;;; | Windows | `{FOLDERID_Pictures}` | C:\Users\Alice\Pictures |

(defun picture() (dispatch 'picture))

;;; Returns the path to the user's public directory.
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value                 | Example             |
;;; | ------- | --------------------- | ------------------- |
;;; | Linux   | `XDG_PUBLICSHARE_DIR` | /home/alice/Public  |
;;; | macOS   | `$HOME`/Public        | /Users/Alice/Public |
;;; | Windows | `{FOLDERID_Public}`   | C:\Users\Public     |

(defun public() (dispatch 'public))

;;; Returns the path to the user's template directory.
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value                  | Example                                                    |
;;; | ------- | ---------------------- | ---------------------------------------------------------- |
;;; | Linux   | `XDG_TEMPLATES_DIR`    | /home/alice/Templates                                      |
;;; | macOS   | –                      | –                                                          |
;;; | Windows | `{FOLDERID_Templates}` | C:\Users\Alice\AppData\Roaming\Microsoft\Windows\Templates |

(defun template() (dispatch 'template))

;;; Returns the path to the user's video directory.
;;;
;;; The returned value depends on the operating system and is either a `Some`, containing a value from the following table, or a `None`.
;;;
;;; |Platform | Value               | Example               |
;;; | ------- | ------------------- | --------------------- |
;;; | Linux   | `XDG_VIDEOS_DIR`    | /home/alice/Videos    |
;;; | macOS   | `$HOME`/Movies      | /Users/Alice/Movies   |
;;; | Windows | `{FOLDERID_Videos}` | C:\Users\Alice\Videos |

(defun video() (dispatch 'video))

;;; Private functions

(defun dispatch (dir-type)
  ;; Erlang supports some of these natively, but the results in Erlang are not
  ;; consistent with those of the upstream Rust library. We follow the Rust
  ;; library's conventions; if you'd like to use Erlang's, then you should use
  ;; the `filename:basedir` function directly and not use the 'dirs' library.
  (case (os:type)
    (#(unix linux) (dirs-lin:assemble dir-type))
    (#(unix darwin) (dirs-mac:assemble dir-type))
    (#(win32 _) (dirs-win:assemble dir-type))
    (os-type #(error (io_lib:format "unsupported OS type ~p" (list os-type))))))
