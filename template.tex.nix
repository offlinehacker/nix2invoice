{ input, i18n, lib }:

with lib;

''


\renewcommand{\familydefault}{\sfdefault}

\documentclass{invoice}

\usepackage[utf8]{inputenc}
\usepackage[slovene]{babel}

\def \tab {\hspace*{3ex}}

\begin{document}

${i18n.invoice} ${toString input.index}

\hfil{\Large\bf ${input.name}}\hfil
\bigskip\break
\hrule
${input.address.street} \hfill ${input.phone} \\
${input.address.city} \hfill ${input.email} \\
${input.address.country}
${i18n.vatId}: ${input.taxId} \\
${i18n.iban}: ${input.account.iban} \\
${i18n.bic}: ${input.account.bic} \\
${i18n.reference}: ${input.ref} \\

{\bf ${i18n.invoiceTo}:} \\
${concatMapStringsSep "\\" (i: "\\tab ${i} \\") input.to}

{\bf ${i18n.dateOfService}:} \\
\tab ${input.dateOfService.start.full} - ${input.dateOfService.end.full}

{\bf ${i18n.invoiceDate}:} \\
\tab ${input.date.full}

{\bf ${i18n.dueDate}:} \\
\tab ${input.due.full} \\

\hourlyrate{${toString input.hourlyRate}}

\begin{invoiceTable}
${concatMapStringsSep "\n" (i: if i.hours != null then "\\hourrow{${i.description}}{${toString i.hours}}" else "\\feerow{${i.description}}{${toString i.amount}}") input.work}
\end{invoiceTable}

${if input ? extra then concatMapStringsSep "\\" (i: "\\tab ${i} \\") input.extra else ""}

${optionalString (input.signature != null) ''
\includegraphics[width=.4\textwidth,right]{signature}
''}

\end{document}
''
