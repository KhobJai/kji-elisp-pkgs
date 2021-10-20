;;; klj-new-projects.el -*- lexical-binding: t; -*-

;;Contains funtions to inititiase new projects in different languages.
;;So far only Python and Clojure have been implemented.

;;; Code:

(require 'vterm)

(defun new-python-project
    ()
  "Create a new Python3 project using Pipenv."
  (interactive)
  (let ((dir-name (read-directory-name "Directory for new Python App:")))
  (make-directory dir-name)
  (cd dir-name)
  (shell-command "pipenv shell")
  ;; (message "Sleepy...")
  (sleep-for 2)
  ;; (vterm--write-input nil "pipenv shell")
  ;; (with-temp-buffer (shell-command "(echo -e \"!#/bin/sh \n\n pipenv shell\" > openshell.sh && chmod +x openshell.sh && sh openshell.sh)" t))
  (find-file (format "%s/Pipfile" dir-name))
  ;; (message "Found Pipfile")
  ;; (kill-buffer "*Shell Command Output*")
  (doom/window-maximize-buffer)
  (message "Maximising bufffer, now cding in virtualenv..")
  (setq splitted-dirname (split-string dir-name "\\/"))
  (setq app-name (mapconcat #'identity (last splitted-dirname) ""))
  (setq venv-dir (format "/home/%s/.local/share/virtualenvs/%s-*" (whoami) app-name))
  (message (format "App Name: %s Venv Dir: %s" app-name venv-dir))
  ;; (cd venv-dir)
  (shell-command (format "source %s/bin/activate" venv-dir))
  (sleep-for 2)
  (cd dir-name)
  (message (shell-command-to-string "which python"))
  ))

(defun remove-chars
    (stri charlist)
  "Remove all occurances of every char in the CHARLIST from the STRI."
  (interactive)
    ;; (let (result)
      (dolist (elt charlist stri)
        (setq stri (replace-regexp-in-string (string elt) "" stri)))
     stri)

(message (remove-chars "HELLO" '(?H ?L ?O)))

(defun get-cwd
    ()
  "Gets the current working directory."
  (interactive)
 (replace-regexp-in-string "DIRECTORY " "" (pwd)))

(defun whoami
    ()
  "Return the person's username."
  (interactive)
  (string-trim (shell-command-to-string "whoami")))

(defun new-clojure-project
    ()
  "Create a new Clojure project using lein."
  (interactive)
  (let
  ((app-name (read-string "Name for new Clojure App:"))
  (username (string-trim (shell-command-to-string "whoami"))))
 (cd "/home/$USER/git")
 (shell-command "echo 'Current Directory:' + $PWD")
  (shell-command (format "lein new app %s" app-name))
  (cd app-name)
  (find-file "project.clj")
 ))

;; (message (replace-regexp-in-string "A" "" "BAAAA"))
(provide 'kji-new-projects)
;;; kji-new-projects ends here
