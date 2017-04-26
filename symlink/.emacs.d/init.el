;; 行番号表示
(global-linum-mode t)
(set-face-attribute 'linum nil
                    :foreground "#800"
                    :height 0.9)
;; 行番号フォーマット
(setq linum-format "%4d")

;;; 対応する括弧を光らせる。
(show-paren-mode 1)
;;; ウィンドウ内に収まらないときだけ括弧内も光らせる。
(setq show-paren-style 'mixed)
;;; 現在行を目立たせる
;(global-hl-line-mode)
;;; カーソルの位置が何文字目かを表示する
(column-number-mode t)
;;; カーソルの位置が何行目かを表示する
(line-number-mode t)

;; 行末の空白を強調表示
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")

;; タブをスペースで扱う
(setq-default indent-tabs-mode nil)
;; タブ幅
(custom-set-variables '(tab-width 2))
;(setq default-tab-width 2)
; c,c++でのtab幅
(add-hook 'c-mode-hook '(lambda () (setq tab-width 4)))
(add-hook 'c++-mode-hook '(lambda () (setq tab-width 4)))

;; yes or noをy or n
(fset 'yes-or-no-p 'y-or-n-p)
;; ミニバッファの履歴を保存する
(savehist-mode 1)
;; ミニバッファの履歴の保存数を増やす
(setq history-length 3000)

;; 行間
;(setq-default line-spacing 0

;; 1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t) ;; shell-mode

;; M-wやC-kでコピーしたものを、他のアプルケーションで貼り付け可能にする
(cond (window-system
       (setq x-select-enable-clipboard t)
))

;; バックアップファイル(~ファイル)を作成しない
(setq make-backup-files nil)

;; @Setting of Lisp
;;;; auto-install(emacsの起動がのろまになります
; (add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install/"))
; (require 'auto-install)
; ;(auto-install-update-emacswiki-package-name t)
; (auto-install-compatibility-setup)


