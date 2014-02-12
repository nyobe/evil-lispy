(require 'evil)
(require 'lispy)

(defmacro evil-lispy--bind (&rest code)
  "Helper to make an bindable command"
  `(lambda ()
     (interactive)
     ,@code))


;;;###autoload
(define-minor-mode evil-lispy-mode
  "Context sensitive paredit"
  :lighter " eLY"
  :keymap (make-sparse-keymap))


;; Evil sexp editing state
(evil-define-state
  lispy "lispy operation state"
  :tag " <S> "
  :cursor ("orange" box)
  :suppress-keymap t

  (if (evil-lispy-state-p) ;; disable automatically going into visual mode...
      (remove-hook 'activate-mark-hook 'evil-visual-activate-hook t)
    (add-hook 'activate-mark-hook 'evil-visual-activate-hook nil t)))


;; Evil standard keymap overrides
(let ((map evil-lispy-mode-map))
  ;; Entering lispy state
  (evil-define-key 'normal map (kbd "(")
    (evil-lispy--bind
     (evil-lispy-state)
     (evil-forward-char 1 nil nil)
     (lispy-backward 1)))
  (evil-define-key 'normal map (kbd ")")
    (evil-lispy--bind
     (evil-lispy-state)
     (evil-backward-char 1 nil nil)
     (lispy-forward 1)))

  ;; Brackets
  (evil-define-key 'insert map (kbd "(") 'lispy-parens)
  (evil-define-key 'insert map (kbd ")") 'lispy-out-forward-nostring)
  (evil-define-key 'insert map (kbd "{") 'lispy-braces)
  (evil-define-key 'insert map (kbd "}") 'lispy-out-forward-nostring)
  (evil-define-key 'insert map (kbd "[") 'lispy-brackets)
  (evil-define-key 'insert map (kbd "]") 'lispy-out-forward-nostring)

  ;; Killing
  (evil-define-key 'insert map (kbd "DEL") 'lispy-delete-backward)
  (evil-define-key 'normal map (kbd "x") 'lispy-delete)
  (evil-define-key 'normal map (kbd "D") 'lispy-kill)
  (evil-define-key 'normal map (kbd "C") (evil-lispy--bind
                                          (lispy-kill) (evil-insert 0)))
  (evil-define-key 'normal map (kbd "S") (evil-lispy--bind
                                          (lispy-kill-at-point) (evil-insert 0)))

  ;; Misc
  (evil-define-key 'normal map (kbd "M-v") 'lispy-mark-symbol)
  (evil-define-key 'normal map (kbd "M-j") 'lispy-split)
  (evil-define-key 'normal map (kbd "C-e") 'lispy-move-end-of-line)

  (evil-define-key 'normal map (kbd "C-1") 'lispy-describe-inline)
  (evil-define-key 'normal map (kbd "C-2") 'lispy-arglist-inline)
  map)


(let ((map evil-lispy-state-map))
  ;; Exiting state
  (define-key map (kbd "C-g")
    (evil-lispy--bind
     (if (region-active-p)
         (evil-visual-state)
       (evil-normal-state))))

  (define-key map [escape] (kbd "C-g"))
  
  (define-key map "i" 'evil-insert)
  (define-key map "I" 'evil-insert-line)
  (define-key map "a" 'evil-append)
  (define-key map "A" 'evil-append-line)
  (define-key map (kbd "SPC") (evil-lispy--bind
                               (lispy-space) (evil-insert-state)))
  (define-key map (kbd "RET") (evil-lispy--bind
                               (lispy-newline-and-indent) (evil-insert-state)))

  ;; Navigation
  (define-key map (kbd "(") 'lispy-out-backward)
  (define-key map (kbd ")") 'lispy-out-forward)
  (define-key map (kbd "C-o") 'evil-jump-backward) ; need to go to normal mode if out of special
  (define-key map (kbd "C-i") 'evil-jump-forward) ; need to go to normal mode if out of special
  (define-key map (kbd "C-e") 'lispy-move-end-of-line)

  (define-key map "h" 'lispy-backward)
  (define-key map "j" 'lispy-down)
  (define-key map "k" 'lispy-up)
  (define-key map "l" 'lispy-forward)
  (define-key map "f" 'lispy-flow)
  (define-key map "o" 'lispy-different)
  (define-key map "gd" 'lispy-follow)
  (define-key map "G" 'lispy-goto)
  (define-key map "q" 'lispy-ace-paren)
  (define-key map "Q" 'lispy-ace-char)

  ;; Paredit transformations
  (define-key map "<" 'lispy-barf)
  (define-key map ">" 'lispy-slurp)
  (define-key map "/" 'lispy-splice)
  (lispy-define-key map "r" 'lispy-raise t)
  (define-key map "R" 'lispy-raise-some)
  (define-key map (kbd "M-j") 'lispy-split)
  (define-key map "J" 'lispy-join)
  (lispy-define-key map "C" 'lispy-convolute t)
  (lispy-define-key map "C-k" 'lispy-move-up t)
  (lispy-define-key map "C-j" 'lispy-move-down t)
  (lispy-define-key map "O" 'lispy-oneline t)
  (lispy-define-key map "M" 'lispy-multiline t)
  (define-key map (kbd ";") 'lispy-comment)
  (define-key map "c" 'lispy-clone)
  (define-key map "t" 'lispy-teleport)

  ;; Kill related
  (define-key map (kbd "DEL") 'lispy-delete-backward)
  (define-key map "D" 'lispy-kill)
  (define-key map "S" (evil-lispy--bind
                       (lispy-kill-at-point) (evil-insert 0)))
  (define-key map "p" 'lispy-yank)

  ;; Marking
  (define-key map "w" 'lispy-ace-symbol)
  (define-key map "W" 'lispy-ace-symbol-replace)
  (define-key map "v" 'lispy-mark-symbol)
  (define-key map "V" 'lispy-mark-list)


  ;; Misc
  (define-key map (kbd "C-1") 'lispy-describe-inline)
  (define-key map (kbd "C-2") 'lispy-arglist-inline)
  (define-key map "u" 'lispy-undo)
  (define-key map "e" 'lispy-eval)
  (define-key map "E" 'lispy-eval-and-insert)
  (define-key map "K" 'lispy-describe)
  (define-key map "A" 'lispy-arglist)
  (define-key map "gq" 'lispy-normalize)
  (lispy-define-key map "z" 'lispy-view t)

  ;; Digit argument
  (mapc (lambda (x) (lispy-define-key map (format "%d" x) 'digit-argument))
        (number-sequence 0 9)))



(evil-add-command-properties 'lispy-out-forward :jump t)
(evil-add-command-properties 'lispy-out-backward :jump t)


(provide 'evil-lispy)
