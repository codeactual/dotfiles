" http://stackoverflow.com/a/8891619
if did_filetype()
    finish
endif
if getline(1) =~# '^#!.*/bin/env\s\+node\>'
    setfiletype javascript
endif
