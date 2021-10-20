;;; klj-new-projects.el -*- lexical-binding: t; -*-

;;Contains funtions to inititiase new projects in different languages.
;;So far only Python and Clojure have been implemented.

;;; Code:

(require 'vterm)

(defun new-python-project
    ()
  "Create a new Python3 project using Pipenv."
  (interactive)
  (let ((dirname (read-directory-name "Directory for new Python App:")))
  (make-directory dirname)
  (cd dirname)
  (shell-command "pipenv shell")
  ;; (sleep-for 5)
  ;; (vterm--write-input nil "pipenv shell")
  ;; (with-temp-buffer (shell-command "(echo -e \"!#/bin/sh \n\n pipenv shell\" > openshell.sh && chmod +x openshell.sh && sh openshell.sh)" t))
  (find-file (format "%s/Pipfile" dirname))
  ;; (kill-buffer "*Shell Command Output*")
  ;; (doom/window-maximize-buffer)
  ;; (message (shell-command-to-string "which python"))
  ))

(defun new-clojure-project
    ()
  "Create a new Clojure project using lein."
  (interactive)
  (let
  ((dirname (read-string "Name for new Clojure App:"))
  (username (string-trim (shell-command-to-string "whoami"))))
 (cd (format "/home/%s/git" username))
 (shell-command "echo 'Current Directory:' + $PWD")
  (shell-command (format "lein new app %s" dirname))
  (cd dirname)
  (find-file "project.clj")
 ))

(provide 'kji-new-projects)
;;; kji-new-projects ends here
