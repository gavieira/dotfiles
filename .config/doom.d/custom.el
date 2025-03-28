(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doc-view-continuous t)
 '(org-agenda-files
   '("~/Dropbox/repos/ECG/apresentacao/apresentacao.org" "~/Dropbox/repos/ECG/leitura_artigos.org")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; allow for export=>beamer by placing

;; #+LaTeX_CLASS: beamer in org files
(unless (boundp 'org-export-latex-classes)
    (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
	       ;; beamer class, for presentations
	         '("beamer"
		        "\\documentclass[11pt]{beamer}\n
		         \\mode<{{{beamermode}}}>\n
			       \\usetheme{{{{beamertheme}}}}\n
			             \\usecolortheme{{{{beamercolortheme}}}}\n
				           \\beamertemplateballitem\n
					         \\setbeameroption{show notes}
						       \\usepackage[utf8]{inputenc}\n
						             \\usepackage[T1]{fontenc}\n
							           \\usepackage{hyperref}\n
								         \\usepackage{color}
									       \\usepackage{listings}
									             \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
										       frame=single,
										         basicstyle=\\small,
											   showspaces=false,showstringspaces=false,
											     showtabs=false,
											       keywordstyle=\\color{blue}\\bfseries,
											         commentstyle=\\color{red},
												   }\n
												         \\usepackage{verbatim}\n
													       \\institute{{{{beamerinstitute}}}}\n          
													              \\subject{{{{beamersubject}}}}\n"

														           ("\\section{%s}" . "\\section*{%s}")
															        
															        ("\\begin{frame}[fragile]\\frametitle{%s}"
																			            "\\end{frame}"
																				           "\\begin{frame}[fragile]\\frametitle{%s}"
																					          "\\end{frame}")))

  ;; letter class, for formal letters

  (add-to-list 'org-export-latex-classes

	         '("letter"
		        "\\documentclass[11pt]{letter}\n
		         \\usepackage[utf8]{inputenc}\n
			       \\usepackage[T1]{fontenc}\n
			             \\usepackage{color}"
				          
				          ("\\section{%s}" . "\\section*{%s}")
					       ("\\subsection{%s}" . "\\subsection*{%s}")
					            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
						         ("\\paragraph{%s}" . "\\paragraph*{%s}")
							      ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(put 'customize-variable 'disabled nil)
