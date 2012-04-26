echo "Loading $0"

alias doc-clearall="doctrine orm:clear-cache:metadata && doctrine orm:generate-proxies"
alias lintphp="find . -name '*\.php' -exec php -l {} \;"
alias wcexception="wcgrep 'InvalidArgumentException|RuntimeE| Exception;| Exception\(| \\\Exception'"
alias zend-findclasses="wcgrep Zend_ | sed 's/^.*\(Zend[A-za-z_]*\).*$/\1/' | sort | uniq"
