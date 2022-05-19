(map! :leader
      :desc "File Tree"
      "p t" #'+treemacs/toggle
      :desc "Alternate Buffer"
      "TAB" #'+spacemacs/alternate-buffer
      :desc "Maximize"
      "w m" #'+spacemacs/toggle-maximize-buffer
      :desc "Comment Lines"
      "c l" #'evilnc-comment-or-uncomment-lines
      :desc "M-x"
      "SPC" #'execute-extended-command)

(map! :mode rspec-mode
      ", TAB" #'rspec-toggle-spec-and-target)
