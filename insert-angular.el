;;;   -*- lexical-binding: t; -*-
;;;
;; <type>(<scope>): <subject>
;; <BLANK LINE>
;; <body>
;; <BLANK LINE>
;; <footer>
;;
;;; Code:

(require 'json)

(defvar iangular-type nil
  "Emoji data, to be populated from the file `gitmoji-json-file'.")

(defvar iangular-type-json-file
  (expand-file-name "data/iangular-type.json" (file-name-directory (locate-library "insert-angular")))
  "JSON file to read gitmoji emoji data from.")

(defun iangular-set-type-data (&optional force)
  (when (or force (not iangular-type))
    (let* ((json-object-type 'hash-table)
           (json-array-type 'list)
           (json-key-type 'string)
           (iangular-json (json-read-file iangular-type-json-file))
           (angular-type (gethash "angular-type" iangular-json)))
      (setq iangular-type
            (mapcar (lambda (type)
                      (cons
                              (gethash "key" type)
                              (gethash "description" type)))
                    angular-type)))))

(defun iangular-type-completing-annotation (s)
  (let ((elt (assoc s iangular-type)))
    (when elt (format "\t: %s" (cdr elt)))))

(defun iangular-type-completing-read (prompt &optional predicate require-match initial-input hist def inherit-input-method)
  (iangular-set-type-data)
  (let ((completion-extra-properties '(:annotation-function iangular-type-completing-annotation)))
   (funcall completing-read-function
                        prompt
                        iangular-type
                        predicate
                        require-match
                        initial-input
                        hist
                        def
                        inherit-input-method)))

;;;###autoload
(defun iangular-insert-segment ()
  (interactive)
  (insert (iangular-type-completing-read "Insert Angular Type: ")))

(provide 'insert-angular)
