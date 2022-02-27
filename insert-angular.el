;;;   -*- lexical-binding: t; -*-
;;;
;; <type>(<scope>): <subject>
;; <BLANK LINE>
;; <body>
;; <BLANK LINE>
;; <footer>
;;
;;; Code:

;; build：对构建系统或者外部依赖项进行了修改 | Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
;; ci：对CI配置文件或脚本进行了修改 | Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
;; docs：对文档进行了修改 | Documentation only changes
;; feat：增加新的特征 | A new feature
;; fix：修复bug | A bug fix
;; pref：提高性能的代码更改 | A code change that improves performance
;; refactor：既不是修复bug也不是添加特征的代码重构 | A code change that neither fixes a bug nor adds a feature
;; style：不影响代码含义的修改，比如空格、格式化、缺失的分号等 | Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
;; test：增加确实的测试或者矫正已存在的测试 | Adding missing tests or correcting existing tests

(defvar iangular-type
  '(("build:    Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)" . "对构建系统或者外部依赖项进行了修改")
    ("ci:       Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)" . "对CI配置文件或脚本进行了修改")
    ("docs:     Documentation only changes" . "对文档进行了修改")
    ("feat:     A new feature" . "增加新的特征")
    ("fix:      A bug fix" . "修复bug")
    ("pref:     A code change that improves performance" . "提高性能的代码更改")
    ("refactor: A code change that neither fixes a bug nor adds a feature" . "既不是修复bug也不是添加特征的代码重构")
    ("style:    Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)" . "不影响代码含义的修改，比如空格、格式化、缺失的分号等")
    ("test:     Adding missing tests or correcting existing tests" . "增加确实的测试或者矫正已存在的测试"))
  "Angular-type data")

(defun iangular-type-completing-annotation (s)
  (let ((elt (assoc s iangular-type)))
    (when elt (format "\n          |%s" (cdr elt)))))

(defun iangular-type-completing-read (prompt &optional predicate require-match initial-input hist def inherit-input-method)
  (let* ((completion-extra-properties '(:annotation-function iangular-type-completing-annotation))
         (input (funcall completing-read-function
                        prompt
                        iangular-type
                        predicate
                        require-match
                        initial-input
                        hist
                        def
                        inherit-input-method)))
    (substring input 0 (string-match ":[ ]+" input))))

;;;###autoload
(defun iangular-insert-segment ()
  (interactive)
  (insert (iangular-type-completing-read "Insert Angular Type: ")))

(provide 'insert-angular)
