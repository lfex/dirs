(defmodule dirs-mac
  (export
   (assemble 1)))

(defun assemble
  ;; Unsupported
  (('executable) 'undefined)
  (('runtime) 'undefined)
  (('state) 'undefined)
  (('template) 'undefined)
  ;; Erlang-supported
  (('cache) (filename:basedir 'user_cache ""))
  (('config) (app-support))
  (('config-local) (app-support))
  (('data) (app-support))
  (('data-local) (app-support))
  ;; Custom
  (('home) (home))
  (('preference) (filename:join (list (library) "Preferences")))
  (('font) (filename:join (list (library) "Fonts")))
  (('audio) (filename:join (list (home) "Music")))
  (('desktop) (filename:join (list (home) "Desktop")))
  (('document) (filename:join (list (home) "Documents")))
  (('download) (filename:join (list (home) "Downloads")))
  (('picture) (filename:join (list (home) "Pictures")))
  (('public) (filename:join (list (home) "Public")))
  (('video) (filename:join (list (home) "Movies"))))

;;; Private Functions

(defun home ()
  (let ((`#(ok ((,home . ,_) . ,_)) (init:get_argument 'home)))
    home))

(defun app-support ()
  (filename:basedir 'user_config ""))

(defun library ()
  (filename:dirname (app-support)))
