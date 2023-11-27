(defmodule dirs-common
  (export
   (abs-path? 1)
   (home 0)))

(defun abs-path?
  ((`(#\/ . ,_)) 'true)
  ((_) 'false))

(defun home ()
  (let ((`#(ok ((,home . ,_) . ,_)) (init:get_argument 'home)))
    home))

(defun home-subdir (path-segs)
  (filename:join (++ (dirs-common:home) path-segs)))