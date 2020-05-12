(require 'subr-x)

;; Useful for getting AWS credentials and loading them automatically
(defun jkxyz-read-ini (filename section key)
  "Returns the value in an INI config file at section.key."
  (shell-command-to-string
   (format "python -c '%s'"
           (string-join
            (list "import ConfigParser"
                  "import sys"
                  "c = ConfigParser.ConfigParser()"
                  (format "c.readfp(open(\"%s\"))" filename)
                  (format "sys.stdout.write(c.get(\"%s\", \"%s\"))" section key))
            "; "))))

(defun jkxyz-reload-dir-locals-for-current-buffer ()
  (interactive)
  (let ((enable-local-variables :all))
    (hack-dir-local-variables-non-file-buffer)))

(defun jkxyz-reload-dir-locals-for-all-buffers-in-this-directory ()
  (interactive)
  (let ((dir default-directory))
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
        (when (equal default-directory dir))
        (jkxyz-reload-dir-locals-for-current-buffer)))))
