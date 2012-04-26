echo "Loading $0"

alias doc_clearall="doctrine orm:clear-cache:metadata && doctrine orm:generate-proxies"
alias findzendclass="wcgrep Zend_ | sed 's/^.*\(Zend[A-za-z_]*\).*$/\1/' | sort | uniq"
alias lintphp="find . -name '*\.php' -exec php -l {} \;"
alias wcexception="wcgrep 'InvalidArgumentException|RuntimeE| Exception;| Exception\(| \\\Exception'"
