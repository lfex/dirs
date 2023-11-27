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
  (('home) (dirs-common:home))
  (('preference) (filename:join (list (library) "Preferences")))
  (('font) (filename:join (list (library) "Fonts")))
  (('audio) (dirs-common:home-subdir '("Music")))
  (('desktop) (dirs-common:home-subdir '("Desktop")))
  (('document) (dirs-common:home-subdir '("Documents")))
  (('download) (dirs-common:home-subdir '("Downloads")))
  (('picture) (dirs-common:home-subdir '("Pictures")))
  (('public) (dirs-common:home-subdir '("Public")))
  (('video) (dirs-common:home-subdir '("Movies"))))

;;; Private Functions

(defun app-support ()
  (filename:basedir 'user_config ""))

(defun library ()
  (filename:dirname (app-support)))
